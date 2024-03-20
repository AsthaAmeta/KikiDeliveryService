//
//  main.swift
//  KikiDeliveryService
//
//  Created by Recro on 19/03/24.
//

import Foundation


func findDeliveryCostForPackages() -> DeliveryPackages {
    var baseDeliveryPrice: Int = 0
    var totalPackages: Int = 0
    
    if let input = readLine() {
        let inputs = input.split(separator: " ").map { String($0) }
        if inputs.count == 2 {
            if let price = Int(inputs[0]), let packages = Int(inputs[1]) {
                baseDeliveryPrice = price
                totalPackages = packages
            }
        }
    }
    
    var allPackages = DeliveryPackages()
    let discounts = mockAllDiscounts()
    
    for _ in 0..<totalPackages {
        if let input = readLine() {
            let inputs = input.split(separator: " ").map { String($0) }
            let packageID = inputs[0]
            let weight = Int(inputs[1]) ?? 0
            let distance = Int(inputs[2]) ?? 0
            let coupon = inputs[3]
            
            let discount = discounts.getCouponDiscount(coupons: [coupon])
            
            let p = DeliveryPackage(packageId: packageID, distance: distance, weight: weight, baseCost: baseDeliveryPrice, discounts: discount)
            allPackages.addPackage(p)
        }
    }
    
    allPackages.calculateDeliveryCost()
    return allPackages
}

func main() {
    //let problem = CommandLine.arguments[1]
   // if problem == "1" {
        let allPackages = findDeliveryCostForPackages()
        allPackages.packages.forEach({
            print("\($0.packageId) \($0.discountedCost ?? 0) \($0.totalCost ?? 0)")
        })
   // }
    
//    if problem == "2" {
        let packages = findDeliveryTimeForPackages()
        packages.forEach({
            print("\($0.packageId) \($0.discountedCost ?? 0) \($0.totalCost ?? 0) \($0.deliveryTime ?? 0)")
        })
//    }
}

main()


//func main() {
//    let discounts: Discounts = []
//    var package = DeliveryPackage(packageId: "1", distance: 10, weight: 5, baseCost: 100, discounts: discounts)
//    package.calculateDeliveryCost()
//}
