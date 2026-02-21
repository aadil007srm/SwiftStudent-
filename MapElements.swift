// Updated Person struct to include isFollowing and position tracking
struct Person {
    var name: String
    var isFollowing: Bool
    var position: (x: Double, y: Double)

    // Additional methods for animation and tracking can be implemented here
}

// Updated FireHazard struct to track suppression and extinguishment states
struct FireHazard {
    var isSuppressed: Bool
    var isExtinguished: Bool
    var visualIndicators: [String] // Example: Could hold names of different indicators

    // Additional methods for managing state and visual feedback can be implemented here
}
