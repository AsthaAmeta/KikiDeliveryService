//
//  DeliveryPackage.swift
//  KikiDeliveryService
//
//  Created by Recro on 19/03/24.
//

import Foundation

struct DeliveryPackage {
    var packageId: String
    var distance: Int
    var weight: Int
    var baseCost: Int
    var totalCost: Int?
    var discountedCost: Int?
    var deliveryTime: Float?
    var discounts: Discounts
    var totalWeight: Double?
    
    init(packageId: String, distance: Int, weight: Int, baseCost: Int, discounts: Discounts) {
        self.packageId = packageId
        self.distance = distance
        self.weight = weight
        self.baseCost = baseCost
        self.totalCost = 0
        self.discountedCost = 0
        self.deliveryTime = 0.0
        self.discounts = discounts
        self.totalWeight = 0.0
    }
    
    func isApplicableDiscount() ->Bool {
        for discount in discounts {
            if discount.minWeight <= weight && weight <= discount.maxWeight &&
                discount.minDistance <= distance && distance <= discount.maxDistance {
                return true
            }
        }
        return false
    }
    
    mutating func calculateDeliveryCost() {
        var totalCost = baseCost + (weight*10) + (distance*5)
        if isApplicableDiscount() {
            discountedCost = discounts.calculateDiscountAmt(cost: totalCost)
        }
        totalCost -= (discountedCost ?? 0)
        print("Total delivery cost of the package: \(totalCost)")
        
    }
}

