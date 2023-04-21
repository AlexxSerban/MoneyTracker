//
//  DIContainer.swift
//  Peso
//
//  Created by Alex Serban on 28.10.2022.
//

import Foundation

protocol DIContainerProtocol {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) -> Component
}

final class DIContainer: DIContainerProtocol {
    
    static let shared = DIContainer()
    var components: [String: Any] = [:]
    
    private init() {}
    
    func register<Component>(type: Component.Type, component: Any) {
        if components.keys.contains("\(type)") {
            print("\(type) was already registered in DIContainer! Old component was replaced!")
        }
        components["\(type)"] = component
    }
    
    func resolve<Component>(type: Component.Type) -> Component {
        guard let component = components["\(type)"] as? Component else {
            fatalError("Component \(type) not registered in DIContainter!")
        }
        return component
    }
}
