//
//  ServicesListViewController.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import UIKit

protocol ServicesListDisplayLogic: AnyObject {
    func displayFetchedData(_ viewModel: ServicesListDataFlow.FetchData.ViewModel)
    func displayError(_ viewModel: ServicesListDataFlow.Error.ViewModel)
}

final class ServicesListViewController: UIViewController {
    
    // MARK: - Internal properties
    
    lazy var tableManager = ServicesListTableManager(delegate: self)
    lazy var contentView: ServicesListView = {
        $0.tableView.dataSource = tableManager
        $0.tableView.delegate = tableManager
        return $0
    }(ServicesListView())
    
    // MARK: - Private properties
    
    private let interactor: ServicesListBusinessLogic
    private let router: ServicesListRouting
    
    // MARK: - Initializer
    
    init(interactor: ServicesListBusinessLogic, router: ServicesListRouting) {
        self.interactor = interactor
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        
        contentView.startLoading()
        interactor.fetchData()
    }
    
    // MARK: - Private methods
    
    private func configureNavigation() {
        title = "VK services"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - ServicesListDisplayLogic

extension ServicesListViewController: ServicesListDisplayLogic {
    
    func displayFetchedData(_ viewModel: ServicesListDataFlow.FetchData.ViewModel) {
        tableManager.services = viewModel.servicesList
        contentView.stopLoading()
        contentView.reloadData()
    }
    
    func displayError(_ viewModel: ServicesListDataFlow.Error.ViewModel) {
        contentView.stopLoading()
        router.routeToAlert(title: viewModel.title, message: viewModel.message)
    }
}

// MARK: - ServicesListViewDelegate

extension ServicesListViewController: ServicesListTableDelegate {
    
    func didSelectRow() {
        router.routeToServiceDetail()
    }
}

// MARK: - ServicesListViewDelegate

extension ServicesListViewController: ServicesListViewDelegate {
    
    func reloadButtonDidTap() {
        interactor.fetchData()
    }
}
