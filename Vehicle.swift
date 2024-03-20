//
//  Vehicle.swift
//  KikiDeliveryService
//
//  Created by Recro on 20/03/24.
//

import Foundation

struct Vehicle {
    var id: Int
    var maxSpeed: Int
    var maxLoad: Int
    var nextDeliveryTime: Float

    init(id: Int, maxSpeed: Int, maxLoad: Int) {
        self.id = id
        self.maxSpeed = maxSpeed
        self.maxLoad = maxLoad
        self.nextDeliveryTime = 0.0
    }

    mutating func setNextDeliveryTime(totalDeliveryTime: Float) {
        self.nextDeliveryTime = roundOff(f: 2 * totalDeliveryTime)
    }

    private func roundOff(f: Float) -> Float {
        return Float((Double(f) * 100).rounded(.down) / 100)
    }
}

struct Vehicles: Comparable {
    private var vehicles: [Vehicle]

    init() {
        self.vehicles = []
    }

    static func < (lhs: Vehicles, rhs: Vehicles) -> Bool {
        return lhs.vehicles.count < rhs.vehicles.count
    }

    static func == (lhs: Vehicles, rhs: Vehicles) -> Bool {
        return lhs.vehicles.count == rhs.vehicles.count
    }

    mutating func addVehicle(_ vehicle: Vehicle) {
        vehicles.append(vehicle)
    }

    func count() -> Int {
        return vehicles.count
    }

    mutating func swap(i: Int, j: Int) {
        let temp = vehicles[i]
        vehicles[i] = vehicles[j]
        vehicles[j] = temp
    }

    func less(i: Int, j: Int) -> Bool {
        return vehicles[i].nextDeliveryTime < vehicles[j].nextDeliveryTime
    }
}

func newVehicles(vehicleCount: Int, vehicleMaxSpeed: Int, vehicleMaxLoad: Int) -> Vehicles {
    var vehicles = Vehicles()
    for i in 0..<vehicleCount {
        vehicles.addVehicle(Vehicle(id: i, maxSpeed: vehicleMaxSpeed, maxLoad: vehicleMaxLoad))
    }
    return vehicles
}


