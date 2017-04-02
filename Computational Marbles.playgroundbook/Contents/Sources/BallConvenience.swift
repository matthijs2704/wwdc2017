import Foundation

public extension Ball {
    /// This will create a new instance of a red ball
    public static var red: Ball {
        let ball = Ball()
        ball.type = .red
        return ball
    }
    
    /// This will create a new instance of a blue ball
    public static var blue: Ball {
        let ball = Ball()
        ball.type = .blue
        return ball
    }
}

// MARK: Convenience methods to create marbles easier

/// This will create a new instance of a red ball
public var 🔴: Ball {
    return Ball.red
}

/// This will create a new instance of a blue ball
public var 🔵: Ball {
    return Ball.blue
}
