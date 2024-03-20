//
//  Discount.swift
//  KikiDeliveryService
//
//  Created by Recro on 19/03/24.
//

import Foundation

struct Discount {
    let coupon: String
    let percentage: Int
    let minDistance: Int
    let maxDistance: Int
    let minWeight: Int
    let maxWeight: Int
    
    func calculateDiscountAmt(cost: Int) -> Int {
        return(cost/100 * percentage)
    }
}

typealias Discounts = [Discount]

extension Discounts {
    func calculateDiscountAmt(cost: Int) -> Int {
        var totalDiscountAmt = 0
        for discount in self {
            totalDiscountAmt += discount.calculateDiscountAmt(cost: cost)
        }
        return totalDiscountAmt
    }
    func getCouponDiscount(coupons: [String]) -> Discounts {
        var discounts = Discounts()
        for discount in self {
            if coupons.contains(discount.coupon) {
                discounts.append(discount)
            }
        }
        return discounts
    }
}

func mockAllDiscounts() -> Discounts {
    var allDiscounts = Discounts()
    allDiscounts.append(Discount(coupon: Coupon.coupon1.rawValue, percentage: 10, minDistance: 0, maxDistance: 200, minWeight: 70, maxWeight: 200))
    allDiscounts.append(Discount(coupon: Coupon.coupon2.rawValue, percentage: 7, minDistance: 50, maxDistance: 150, minWeight: 100, maxWeight: 250))
    allDiscounts.append(Discount(coupon: Coupon.coupon3.rawValue, percentage: 5, minDistance: 50, maxDistance: 250, minWeight: 10, maxWeight: 150))
    
    return allDiscounts
}
