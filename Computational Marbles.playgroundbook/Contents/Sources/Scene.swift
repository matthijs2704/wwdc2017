import Foundation
import SpriteKit

public typealias BallsBeganContact = ((_ ballBodyA: SKPhysicsBody, _ ballBodyB: SKPhysicsBody) -> Void)

@objc(Scene)
public class Scene: SKScene, SKPhysicsContactDelegate {
    
    public var ballsBeganContact: BallsBeganContact? = nil
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.physicsWorld.contactDelegate = self
        
        print ("Hiya, I've moved!")
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Ball" &&
            (contact.bodyB.node?.name == "Ball" || contact.bodyB.node?.name == "HiddenTubeSeal") &&
            contact.contactPoint.y > 0 &&
            contact.collisionImpulse > 30 {
            ballsBeganContact?(contact.bodyA, contact.bodyB)
        }
    }
}
