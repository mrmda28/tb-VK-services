//
//  ServicesListTableManager.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import UIKit

protocol ServicesListTableDelegate: AnyObject {
    func didSelectRow()
}

final class ServicesListTableManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Internal properties
    
    var services: [ServiceDetail] = []
    weak var delegate: ServicesListTableDelegate?
    
    // MARK: - Initializer
    
    init(delegate: ServicesListTableDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServicesListCell.identifier, for: indexPath) as? ServicesListCell else { return UITableViewCell() }
        cell.configure(with: services[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRow()
    }
}
