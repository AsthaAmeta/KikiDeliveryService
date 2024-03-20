//
//  MultiplePackages.swift
//  KikiDeliveryService
//
//  Created by Recro on 20/03/24.
//

import Foundation

//struct Package {
//    // Assuming Package structure exists with a method GetTotalWeight() -> Double
//    func GetTotalWeight() -> Double {
//        // Implementation
//        return 0.0
//    }
//}

typealias Packages = [Package]

struct MultiplePackages {
    var packages: [Packages]

    var count: Int {
        return packages.count
    }

    mutating func swap(_ i: Int, _ j: Int) {
        (packages[i], packages[j]) = (packages[j], packages[i])
    }

    func isLessThan(_ i: Int, _ j: Int) -> Bool {
        if packages[i].count == packages[j].count {
            return packages[i].map { $0.GetTotalWeight() }.reduce(0, +) > packages[j].map { $0.GetTotalWeight() }.reduce(0, +)
        }
        return packages[i].count > packages[j].count
    }

    func convertToPackages() -> Packages {
        return packages.flatMap { $0 }
    }
}


