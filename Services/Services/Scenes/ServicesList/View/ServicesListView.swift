//
//  ServicesListView.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import UIKit

protocol DisplayServicesListView: UIView {
    func reloadData()
    func startLoading()
    func stopLoading()
}

protocol ServicesListViewDelegate: AnyObject {
    func reloadButtonDidTap()
}

final class ServicesListView: UIView {
    
    // MARK: - Views
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        $0.style = .large
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView())
    
    lazy var tableView: UITableView = {
        $0.register(ServicesListCell.self, forCellReuseIdentifier: ServicesListCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    
    // MARK: - Initializer
    
    required init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension ServicesListView {
    
    func configureUI() {
        backgroundColor = .systemBackground
        
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        addSubview(loadingIndicator)
        addSubview(tableView)
    }
    
    func configureConstraints() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - DisplayServicesListView

extension ServicesListView: DisplayServicesListView {
    
    func reloadData() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func startLoading() {
        tableView.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
}
