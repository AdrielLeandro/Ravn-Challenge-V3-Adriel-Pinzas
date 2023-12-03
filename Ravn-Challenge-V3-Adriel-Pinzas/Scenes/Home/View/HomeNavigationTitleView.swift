//
//  HomeNavigationTitleView.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 1/12/23.
//

import UIKit

protocol HomeNavigationTitleViewDelegateProtocol: AnyObject {
    
    func showSearchButtonTouched()
    func searchBarCancelButtonTouched()
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
}

final class HomeNavigationTitleView: UIView {

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var showSearchBarButton: UIButton = {
        let showSearchBarButton = UIButton(type: .roundedRect)
        showSearchBarButton.translatesAutoresizingMaskIntoConstraints = false
        showSearchBarButton.setImage(UIImage(named: "searchIcon"), for: .normal)
        showSearchBarButton.addTarget(self, action: #selector(showSearchButtonTouched), for: .touchUpInside)
        return showSearchBarButton
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    var showSearchBar: Bool = false {
        didSet {
            setNeedsLayout()
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.beginFromCurrentState, .curveEaseInOut],
                           animations: {
                            self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    weak var delegate: HomeNavigationTitleViewDelegateProtocol?
    
    init(title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        searchBar.delegate = self
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(showSearchBarButton)
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            showSearchBarButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showSearchBarButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.widthAnchor.constraint(equalTo: widthAnchor),
            searchBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.alpha = showSearchBar ? 0.0 : 1.0
        showSearchBarButton.alpha = showSearchBar ? 0.0 : 1.0
        searchBar.alpha = showSearchBar ? 1.0 : 0.0
        _ = showSearchBar ? searchBar.becomeFirstResponder() : searchBar.resignFirstResponder()
    }
    
    @objc private func showSearchButtonTouched() {
        delegate?.showSearchButtonTouched()
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
}

extension HomeNavigationTitleView: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        delegate?.searchBarCancelButtonTouched()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBar(searchBar, textDidChange: searchText)
    }
}
