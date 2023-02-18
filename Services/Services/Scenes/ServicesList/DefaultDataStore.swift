//
//  DefaultDataStore.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import Foundation


protocol DataStoring: AnyObject {
    associatedtype Model
    func getValue() -> Model?
    func setValue(newValue: Model)
}

class DefaultDataStore<Model>: DataStoring {
    
    private var model: Model?
    
    func getValue() -> Model? {
        model
    }
    
    func setValue(newValue: Model) {
        model = newValue
    }
}
