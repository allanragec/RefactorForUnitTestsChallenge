//
//  Analytics.swift
//  Analytics
//
//  Created by Allan Barbosa De Melo on 15/08/23.
//

import Foundation

public class Analytics {
    public init() {}
    
    public func sendEvent(name: String, properties: [String: String]) {
        print("Analytics.sendEvent can't be executed during tests")
        print("Analytics.sendEvent name: \(name) , properties: \(properties)")
    }
}
