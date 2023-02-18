//
//  ServicesListFactory.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

struct ServicesListFactory {
    
    func build() -> ServicesListViewController {
        let service = ServicesListService()
        let provider = ServicesListProvider(networkService: AnyNetworkService(service))
        
        let presenter = ServicesListPresenter()
        let interactor = ServicesListInteractor(presenter: presenter, provider: provider)
        let router = ServicesListRouter()
        let viewController = ServicesListViewController(interactor: interactor,
                                                        router: router)
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
