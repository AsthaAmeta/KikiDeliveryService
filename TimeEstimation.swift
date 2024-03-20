//
//  TimeEstimation.swift
//  KikiDeliveryService
//
//  Created by Recro on 20/03/24.
//

import Foundation

func findDeliveryTimeForPackages() -> [DeliveryPackage] {
    
    //var allPackages = findDeliveryCostForPackages()
    var deliveryPackage = [DeliveryPackage]()
    
    var vehicleCount: Int = 0
    var vehicleMaxSpeed: Int = 0
    var vehicleMaxLoad: Int = 0
    print("Enter vehicleCount, vehicleMaxSpeed, vehicleMaxLoad:", terminator: " ")
    if let input = readLine() {
        let inputs = input.split(separator: " ").compactMap { Int($0) }
        if inputs.count >= 3 {
            vehicleCount = inputs[0]
            vehicleMaxSpeed = inputs[1]
            vehicleMaxLoad = inputs[2]
        }
    }
    
    var vehicles = [Vehicle]() // Initialize vehicles based on input
    
    deliveryPackage.sort(by: { $0.weight < $1.weight })
   // allPackages = allPackages.packages.sorted(by: ({ $0.weight < $1.weight }))
    let packageGroups = calculatePackagesGroups(maxLoad: vehicleMaxLoad, packages: deliveryPackage)
    
    var index = 0
    while index < packageGroups.count {
        for v in vehicles {
            index += 1
        }
        vehicles.sort(by: { $0.nextDeliveryTime < $1.nextDeliveryTime })
    }
    return packageGroups.flatMap { $0 }
}

func calculatePackagesGroups(maxLoad: Int, packages: [DeliveryPackage]) -> [[DeliveryPackage]] {
    var remainingPackages = packages
    
    func getPossiblePackages(_ packages: [DeliveryPackage]) -> [[DeliveryPackage]] {
        var group = [[DeliveryPackage]]()
        for i in 0..<packages.count {
            var packageItems = [packages[i]]
            for j in i..<packages.count {
                if i == j {
                    continue
                }
                if packages[j].weight + packageItems.reduce(0, { $0 + $1.weight }) <= maxLoad {
                    packageItems.append(packages[j])
                } else {
                    group.append(packageItems)
                    packageItems = [packages[i]]
                    if packages[j].weight + packageItems.reduce(0, { $0 + $1.weight }) <= maxLoad {
                        packageItems.append(packages[j])
                    }
                }
            }
            group.append(packageItems)
        }
        return group
    }
    
    var toBeDeliveredPackages = [[DeliveryPackage]]()
    while !remainingPackages.isEmpty {
        var packagesGroup = getPossiblePackages(remainingPackages)
        
        packagesGroup = packagesGroup.sorted(by: { $0.reduce(0, { $0 + $1.weight }) < $1.reduce(0, { $0 + $1.weight }) })
        remainingPackages.removeAll()
        toBeDeliveredPackages.append(packagesGroup[0])
        for v in packages {
            if !toBeDeliveredPackages.flatMap({ $0 }).contains(where: { $0.weight == v.weight }) {
                remainingPackages.append(v)
            }
        }
    }
    return toBeDeliveredPackages
}


