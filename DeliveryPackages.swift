//
//  DeliveryPackages.swift
//  KikiDeliveryService
//
//  Created by Recro on 19/03/24.
//

import Foundation

class DeliveryPackages {
    var packages: [DeliveryPackage]

    init(packages: [DeliveryPackage] = []) {
        self.packages = packages
    }

    var count: Int {
        return packages.count
    }

    func swap(i: Int, j: Int) {
        packages.swapAt(i, j)
    }

    func isLessThan(i: Int, j: Int) -> Bool {
        return packages[i].weight < packages[j].weight
    }

    func addPackage(_ package: DeliveryPackage) {
        packages.append(package)
    }

    func getTotalWeight() -> Int {
        return packages.reduce(0) { $0 + $1.weight }
    }

    func setDeliveryTimeForPackages(maxSpeed: Int, additionalTime: Float) {
        for package in packages {
            var deliveryTime = package.deliveryTime
            deliveryTime = round(additionalTime + Float(package.distance) / Float(maxSpeed))
        }
    }

    func getTotalDeliveryTime() -> Float {
        return packages.map { $0.deliveryTime ?? 0 }.max() ?? 0
    }

    func containsPackage(_ package: DeliveryPackage) -> Bool {
        return packages.contains { $0.packageId == package.packageId }
    }

    func calculateDeliveryCost() {
        //packages.forEach { $0.calculateDeliveryCost() }
        for i in 0..<packages.count {
            packages[i].calculateDeliveryCost()
        }
    }
}

