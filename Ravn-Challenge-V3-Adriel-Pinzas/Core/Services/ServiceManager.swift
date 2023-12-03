//
//  ServiceManager.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import Foundation

struct RequestError: Error, Codable {
    let key: String
    let message: String
}

enum HTTPMethod: String {
    case post = "POST"
    case update = "PATCH"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

protocol ServiceManagerType: AnyObject {
    func request<T: Codable>(_ url: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?, completionHandler: @escaping (Result<T, RequestError>) -> Void)
}

class ServiceManager: ServiceManagerType {
    func request<T: Codable>(_ url: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        request(url, method: method, parameters: parameters, headers: headers, attempt: 1, completionHandler: completionHandler)
    }

    private func request<T: Codable>(_ url: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?, attempt: Int, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        // Convert URL
        guard let convertedURL = URL(string: url) else {
            completionHandler(.failure(RequestError(key: "invalid.url", message: "Invalid URL")))
            return
        }
        
        var request = URLRequest(url: convertedURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        // Set headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set HTTP body if needed
        if method != .get, let parameters = parameters {
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = httpBody
            } catch {
                completionHandler(.failure(RequestError(key: "json.serialization.error", message: error.localizedDescription)))
                return
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            // Handle network errors
            if let error = error {
                DispatchQueue.main.async {
                    let requestError = RequestError(key: "network.error", message: error.localizedDescription)
                    completionHandler(.failure(requestError))
                }
                return
            }
            
            // Handle HTTP response
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200..<300:
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode(T.self, from: data)
                            completionHandler(.success(result))
                        } catch {
                            completionHandler(.failure(RequestError(key: "json.parsing.error", message: error.localizedDescription)))
                        }
                    } else {
                        completionHandler(.failure(RequestError(key: "missing.response", message: "Invalid server response")))
                    }
                    
                case 400..<500:
                    completionHandler(.failure(RequestError(key: "client.error", message: "Client error")))
                    
                case 500..<600:
                    // Retry logic
                    if attempt < 5 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                            self.request(url, method: method, parameters: parameters, headers: headers, attempt: attempt + 1, completionHandler: completionHandler)
                        }
                    } else {
                        completionHandler(.failure(RequestError(key: "request.failed", message: "Request failed after 5 attempts")))
                    }
                    
                default:
                    break
                }
            }
        }
        task.resume()
    }
}
