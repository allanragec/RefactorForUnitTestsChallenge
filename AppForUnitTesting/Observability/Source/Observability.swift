//
//  Observability.swift
//  Observability
//
//  Created by Allan Barbosa De Melo on 15/08/23.
//

import Foundation

public class Observability {
    public init() {}
    
    public func sendHandledError(title: String, properties: [String: String]) {
        print("Observability.sendHandledError can't be executed during tests")
        print("Observability.sendHandledError title: \(title) , properties: \(properties)")
    }
}
