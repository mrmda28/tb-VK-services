//
//  ServicesListCell.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import UIKit
import Kingfisher

final class ServicesListCell: UITableViewCell {
    
    // MARK: - Internal properties
    
    static let identifier = "cellId"
    
    // MARK: - Private properties
    
    private enum Constants {
        static let iconSize: CGFloat = 40
        static let offset: CGFloat = 10
    }
    
    // MARK: - Views
    
    private lazy var icon: UIImageView = {
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    
    private lazy var title: UILabel = {
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with service: ServiceDetail) {
        icon.kf.indicatorType = .activity
        icon.kf.setImage(with: URL(string: service.iconUrl), options: [.backgroundDecode, .cacheOriginalImage])
        title.text = service.name
    }
}

// MARK: - UI

private extension ServicesListCell {
    
    func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        addSubview(icon)
        addSubview(title)
    }
    
    func configureConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            icon.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset)
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.offset),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset)
        ])
    }
}
