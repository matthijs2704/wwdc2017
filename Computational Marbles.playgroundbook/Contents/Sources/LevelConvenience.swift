import Foundation

// MARK: Convenience methods to access methods on a single Level object

public let level = Level()

/**
 * This function will add a Ball to the cylinder
 *
 * - parameter ball: The ball to add to the cylinder
 */
public func add(_ ball: Ball) {
    level.addBallToStack(ball)
}

/**
 * This function will add a Ball to the cylinder
 *
 * - parameter ball: The ball to add to the cylinder
 */
public func add(ball: Ball) {
    add(ball)
}

/**
 * This function will create a new Ball and add it to the cylinder
 *
 * - parameter ball: The type of the ball to add to the cylinder
 */
public func add(ballType: BallType) {
    let ball = Ball()
    ball.type = ballType
    level.addBallToStack(ball)
}

/**
 * This function will cause the lowest two balls to drop out of the cylinder
 */
public func dropBalls() {
    level.dropBalls()
}

/// Boolean to indicate if the game is still running or if it's finished
public var gameIsOver: Bool {
    return level.state == .finished
}

/// Boolean indicating if the game is busy dropping balls
public var gameIsBusy: Bool {
    return level.state == .dropping
}
