//
//  FeatureFlagService.swift
//  FeatureFlag
//
//  Created by Allan Barbosa De Melo on 15/08/23.
//

import Foundation

public class FeatureFlagService {
    public init() {}
    
    public func isEnabled(flag: String) -> Bool {
        print("FeatureFlagService.isEnabled can't be executed during tests")
        return Bool.random()
    }
}
