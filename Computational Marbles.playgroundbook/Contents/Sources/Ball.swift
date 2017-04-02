import SpriteKit

/**
 * Represents a marble in the game. Creation of Balls can be done with the convenience variables 🔴 and 🔵
 */
public class Ball {
    public var shapeNode: SKShapeNode
    public var radius: CGFloat = 75
    public var type: BallType = .red
    
    public var color: UIColor {
        switch type {
        case .red:
            return #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case .blue:
            return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
    }

    public init() {
        shapeNode = SKShapeNode.init(ellipseIn: CGRect(x:0,y:0,width:radius*2-0.5,height:radius*2-0.5))
        shapeNode.fillColor = color
        shapeNode.strokeColor = color
        shapeNode.name = "Ball"
        let physicsBody = SKPhysicsBody.init(circleOfRadius: radius, center: CGPoint(x:radius,y:radius))
        shapeNode.physicsBody = physicsBody
        shapeNode.isAntialiased = true
    }
}

extension Ball: Equatable {
    static public func ==(lhs: Ball, rhs: Ball) -> Bool {
        return (lhs.shapeNode == lhs.shapeNode) && (lhs.radius == rhs.radius) && (lhs.color == rhs.color)
    }
}
