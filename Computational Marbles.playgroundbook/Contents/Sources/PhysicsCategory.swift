import Foundation

enum PhysicsCategory {
    static let none     : UInt32 = 0
    static let tube     : UInt32 = 0b001
    static let ball     : UInt32 = 0b010
    static let seal     : UInt32 = 0b011
    static let sealGate : UInt32 = 0b100
}
