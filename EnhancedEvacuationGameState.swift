// EnhancedEvacuationGameState.swift
// This file extends the evacuation game with additional features like fire suppression states,
// extinguisher tracking, person following system, and dynamic smoke expansion.

import Foundation

// Fire suppression states enumeration
enum FireSuppressionState {
    case notActive
    case activated
    case extinguishing
    case extinguished
}

// Class to track extinguishers
class Extinguisher { 
    var location: (x: Double, y: Double)
    var isActive: Bool
    var usageCount: Int

    init(location: (Double, Double), isActive: Bool = true) { 
        self.location = location
        self.isActive = isActive
        self.usageCount = 0
    }

    func use() {
        if isActive {
            usageCount += 1
            // Logic for using the extinguisher
            print("Extinguisher used at location: \(location)")
        }
    }
}

// Class to represent the evacuation game state 
class EnhancedEvacuationGameState {
    var fireSuppressionState: FireSuppressionState
    var extinguishers: [Extinguisher]
    var dynamicSmokeLevel: Double

    init() {
        self.fireSuppressionState = .notActive
        self.extinguishers = []
        self.dynamicSmokeLevel = 0.0
    }

    // Method to activate fire suppression
    func activateFireSuppression() {
        fireSuppressionState = .activated
        print("Fire suppression activated.")
    }

    // Method to track smoke expansion dynamically
    func updateSmokeLevel(with newLevel: Double) {
        self.dynamicSmokeLevel = newLevel
        print("Dynamic smoke level updated to: \(dynamicSmokeLevel)")
    }

    // Method to follow a person based on their ID
    func followPerson(personId: String) {
        // Logic for following a person
        print("Following person with ID: \(personId)")
    }
}