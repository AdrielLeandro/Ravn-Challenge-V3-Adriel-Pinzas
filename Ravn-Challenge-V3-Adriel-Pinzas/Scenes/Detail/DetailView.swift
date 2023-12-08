//
//  DetailView.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 7/12/23.
//

import UIKit

class DetailView: UIView {
    enum Constant {
        static let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 32, left: 24, bottom: 0, right: 24)
        static let bottomMargin: CGFloat = 24
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .black
        label.text = "Descriptión".localized
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let infoContainerView = UIView()
        infoContainerView.translatesAutoresizingMaskIntoConstraints = false
        infoContainerView.layoutMargins = Constant.edgeInsets
        
        let infoStackView = UIStackView(arrangedSubviews:[ titleLabel, dateLabel, descriptionTitleLabel, descriptionLabel ])
        infoStackView.setCustomSpacing(Constant.bottomMargin, after: titleLabel)
        infoStackView.setCustomSpacing(Constant.bottomMargin, after: dateLabel)
        infoStackView.setCustomSpacing(Constant.bottomMargin / 2, after: descriptionTitleLabel)
        infoStackView.setCustomSpacing(Constant.bottomMargin, after: descriptionLabel)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.spacing = 0
        infoContainerView.addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(equalTo: infoContainerView.layoutMarginsGuide.leadingAnchor),
            infoStackView.topAnchor.constraint(equalTo: infoContainerView.layoutMarginsGuide.topAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: infoContainerView.layoutMarginsGuide.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: infoContainerView.layoutMarginsGuide.bottomAnchor)
        ])
        
        let contentStackView = UIStackView(arrangedSubviews: [infoContainerView])

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setup(with content: Detail.DetailViewModel) {
        titleLabel.text = content.missionName
        dateLabel.text = content.launchDate
        descriptionLabel.text = content.launchDetail
    }
}
