import UIKit
import SpriteKit
import PlaygroundSupport

@objc(LiveViewController)
public class LiveViewController: UIViewController {
    @IBOutlet weak var spriteKitView: SKView!
    @IBOutlet var safeArea: UIView!
    @IBOutlet var backgroundGradientView: UIView!

    @IBOutlet public var timesDroppedCountLabel: UILabel!
    @IBOutlet public var goButton: UIButton!

    public var showsGoButton = true {
        didSet {
            goButton.isHidden = !showsGoButton
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.listenForSuspend()
        
        #if !(arch(i386) || arch(x86_64))
            NSLayoutConstraint.activate([
                safeArea.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 20),
                safeArea.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor)
                ])
        #endif

        spriteKitView.presentScene(level.scene)
        
        self.goButton.addTarget(self, action: #selector(LiveViewController.goButtonPressed), for: .touchUpInside)
        
        styleUI()
    }
    
    func styleUI() {
        self.goButton.layer.masksToBounds = true
        self.goButton.layer.borderColor = UIColor.init(red: 254/255, green: 75/255, blue: 38/255, alpha: 1.0).cgColor
        self.goButton.layer.borderWidth = 1.0
        self.goButton.layer.cornerRadius = self.goButton.bounds.height/2
        
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = self.backgroundGradientView.bounds
        let lightBlueColor = UIColor(red:0.82, green:0.93, blue:0.99, alpha:1.0)
        
        gradientLayer.colors = [lightBlueColor.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0,1.0]
        self.backgroundGradientView.layer.addSublayer(gradientLayer)
    }
    
    func goButtonPressed() {
        level.dropBalls()
    }
}

#if !(arch(i386) || arch(x86_64))
extension LiveViewController: PlaygroundLiveViewSafeAreaContainer {}
#endif

public extension LiveViewController {
    class func loadFromStoryboard() -> UIViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
}
