import Foundation
import UIKit
import PlaygroundSupport

/*
 
 This class makes sure the execution is stopped whenever the Playgrounds app moves to background. This so the playground doesn't keep running when the app is on the background. When the user returns, they just have to press the Run button again.
 
 If any of you Apple guys is reading this: SpriteKit already stops doing animation stuff whereas the code to make the balls drop keeps running. I believe this should not happen and the playground should be stopped from running when the Playgrounds app moves to the background, also so the user doesn't miss anything of the amazing Playgrounds :)
 
 */
public extension LiveViewController {
    public func listenForSuspend() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    func appMovedToBackground() {
        PlaygroundPage.current.finishExecution()
    }
}
