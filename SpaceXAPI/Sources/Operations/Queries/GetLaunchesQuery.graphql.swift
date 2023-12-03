// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetLaunchesQuery: GraphQLQuery {
  public static let operationName: String = "GetLaunches"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetLaunches { launches { __typename id details mission_name launch_date_local } }"#
    ))

  public init() {}

  public struct Data: SpaceXAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpaceXAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("launches", [Launch?]?.self),
    ] }

    public var launches: [Launch?]? { __data["launches"] }

    /// Launch
    ///
    /// Parent Type: `Launch`
    public struct Launch: SpaceXAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpaceXAPI.Objects.Launch }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", SpaceXAPI.ID?.self),
        .field("details", String?.self),
        .field("mission_name", String?.self),
        .field("launch_date_local", SpaceXAPI.Date?.self),
      ] }

      public var id: SpaceXAPI.ID? { __data["id"] }
      public var details: String? { __data["details"] }
      public var mission_name: String? { __data["mission_name"] }
      public var launch_date_local: SpaceXAPI.Date? { __data["launch_date_local"] }
    }
  }
}
