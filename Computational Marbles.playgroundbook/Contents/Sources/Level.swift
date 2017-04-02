import Foundation
import SpriteKit

public typealias RedBallFell = (Ball) -> Void
public typealias BlueBallFell = (Ball) -> Void
public typealias BallsDropped = (Int, Int) -> Void

public class Level {
    public let scene: Scene
    
    let audioHelper: AudioHelper = AudioHelper()
    
    let sealSlider: SKSpriteNode
    let hiddenTubeSeal: SKSpriteNode
    
    let leftTubeWall: SKSpriteNode
    let rightTubeWall: SKSpriteNode
    
    public var ballsInStack: [Ball] = []
    public var minimumInStack = 3
    public var timesDropped = 0
    
    public var redBallFell: RedBallFell? = nil
    public var blueBallFell: BlueBallFell? = nil
    public var ballsDropped: BallsDropped? = nil
    public var ballsBeganContact: BallsBeganContact? {
        set {
            scene.ballsBeganContact = newValue
        }
        get {
            return scene.ballsBeganContact
        }
    }
    
    public var state: LevelState = .preparing
    
    init() {
        guard let scene = SKScene(fileNamed: "Level") as? Scene else {
            fatalError("Level not found")
        }
        
        scene.scaleMode = .aspectFit
        scene.backgroundColor = SKColor.clear
        
        self.sealSlider = scene.childNode(withName: "VisibleTubeSeal") as! SKSpriteNode
        self.sealSlider.physicsBody?.categoryBitMask = PhysicsCategory.sealGate
        self.sealSlider.physicsBody?.collisionBitMask = PhysicsCategory.ball
        self.hiddenTubeSeal = scene.childNode(withName: "HiddenTubeSeal") as! SKSpriteNode
        self.hiddenTubeSeal.physicsBody?.categoryBitMask = PhysicsCategory.seal
        self.hiddenTubeSeal.physicsBody?.collisionBitMask = PhysicsCategory.ball

        self.leftTubeWall = scene.childNode(withName: "Walls")?.childNode(withName: "LeftWall") as! SKSpriteNode
        self.leftTubeWall.physicsBody?.categoryBitMask = PhysicsCategory.tube
        self.leftTubeWall.physicsBody?.collisionBitMask = PhysicsCategory.ball
        self.rightTubeWall = scene.childNode(withName: "Walls")?.childNode(withName: "RightWall") as! SKSpriteNode
        self.rightTubeWall.physicsBody?.categoryBitMask = PhysicsCategory.tube
        self.rightTubeWall.physicsBody?.collisionBitMask = PhysicsCategory.ball
        
        self.scene = scene

        self.audioHelper.setupAudio()
    }
    
    public func addBallToStack(_ ball: Ball) {
        ball.shapeNode.position = CGPoint(x: 512-75, y: scene.size.height+82.0*CGFloat(ballsInStack.count))
        ball.shapeNode.fillColor = ball.color
        ball.shapeNode.strokeColor = ball.color

        ball.shapeNode.physicsBody?.categoryBitMask = PhysicsCategory.ball
        ball.shapeNode.physicsBody?.collisionBitMask = PhysicsCategory.seal | PhysicsCategory.tube | PhysicsCategory.ball
        ball.shapeNode.physicsBody?.contactTestBitMask = PhysicsCategory.seal | PhysicsCategory.ball

        ballsInStack.append(ball)
        scene.addChild(ball.shapeNode)
    }
    
    public func openSeal() {
        let action = SKAction.moveBy(x: -sealSlider.frame.size.width, y: 0, duration: 0.55)
        action.timingMode = .easeInEaseOut
        sealSlider.run(action)
    }
    
    public func closeSeal() {
        let action = SKAction.moveBy(x: sealSlider.frame.size.width, y: 0, duration: 0.55)
        action.timingMode = .easeInEaseOut
        sealSlider.run(action)
    }
    
    public func dropBalls(amount: Int = 2) {
        if state == .finished || state == .dropping {
            return
        }

        self.state = .dropping
        
        timesDropped += 1
        ballsDropped?(amount, timesDropped)
        
        openSeal()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.45) {
            let firstBall = level.ballsInStack.first!
            let secondBall = level.ballsInStack[1]
            self.dropBall(ball: firstBall)
            self.dropBall(ball: secondBall)
        
            if firstBall.type == .red {
                self.redBallFell?(firstBall)
            }else if firstBall.type == .blue {
                self.blueBallFell?(firstBall)
            }

            if self.ballsInStack.count < self.minimumInStack {
               self.state = .finished
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.45) {
                self.closeSeal()
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.95) {
                if self.state != .finished {
                    self.state = .idle
                }
            }
        }
    }
    
    public func dropBall(ball: Ball) {
        ball.shapeNode.physicsBody?.collisionBitMask = PhysicsCategory.none | PhysicsCategory.sealGate
        ball.shapeNode.physicsBody?.contactTestBitMask = PhysicsCategory.none
        ballsInStack.remove(object: ball)
    }
    
    public func play(sound: Sound, completion: (() -> Void)? = nil) {
//        audioHelper.play(sound: sound)
        let file = "\(sound.rawValue).m4a"
        let play = SKAction.playSoundFileNamed(file, waitForCompletion: true)
        let fireCompletion = SKAction.run {
            if let completion = completion {
                completion()
            }
        }
        
        scene.run(SKAction.sequence([play, fireCompletion]))
    }
}
