/*:
 Okay, so now you know how to create and add new balls to the cylinder and we have a working [algorithm](glossary://algorithm) and situation to start working on our challenge. But doesn't pressing the go button get annoying after a while?
 * callout(Goal):
 Create a function to automatically drop balls from the cylinder
 
 In this example we have the same cylinder like on the previous page. It contains 5 marbles and the game is over when there are two or less balls in the cylinder. Using the changes to algorithm you made on the previous page, this stack would take exactly 5 cycles to finish. Go give it a try by pressing `Run My Code` and pressing the **GO** button manually!
 
 Now let's go ahead and automate it. 👍🏼
 */
//#-hidden-code
import SpriteKit
import PlaygroundSupport

let vc = LiveViewController.loadFromStoryboard() as! LiveViewController
PlaygroundPage.current.liveView = vc
vc.showsGoButton = true
//#-end-hidden-code
//#-hidden-code
func loop(every: Double, _ codeToRun: @escaping (() -> Void)){
    vc.showsGoButton = false
    let timer = Timer.scheduledTimer(withTimeInterval: abs(every), repeats: true) { a in
        
        codeToRun()
        if level.state == .finished {
            #if !(arch(i386) || arch(x86_64))
                PlaygroundPage.current.assessmentStatus = .pass(message: "Cool! 😎 We now have working code to automatically drop balls. This should come in handy on the [next page](@next)!")
            #else
                print ("*Assessment successfull* - Correct amount and order of balls!")
            #endif
            a.invalidate()
        }
        //
        //    dropBalls()
        
    }
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, dropBalls())
let codeToRun = {
    //#-hidden-code
    if gameIsBusy { return }
    //#-end-hidden-code
    // Drop the balls in here
    //#-copy-source(id3)
    //#-editable-code Tap to write your code
    
    //#-end-editable-code
    //#-end-copy-source
}
/*:
 To create the actual loop, you have to execute similar code to the following line of code:
 * callout(Example):
 `loop(every: 10, codeToRun)` will run the code every 10 seconds
 
 Now it's your turn!
 */
//#-code-completion(identifier, hide, dropBalls())
//#-code-completion(identifier, show, codeToRun)
//#-code-completion(identifier, show, loop(every:_:))
//#-copy-source(id4)
//#-editable-code Tap to write your code
//#-end-editable-code
//#-end-copy-source
//#-hidden-code
/*:
 The code below here is the same code as in the previous page. It makes sure the correct balls are being dropped and adds the 5 balls to start of with to the cylinder.
 */
func redFellFirst(ball: Ball) {
    // Drop a blue ball
    //#-code-completion(identifier, show, add(ball:), Ball)
    //#-code-completion(identifier, show, .)
    //#-code-completion(identifier, show, red, blue)
    //#-editable-code Tap to write your code
    //#-copy-destination("Preparing the Situation", id1)
    add(🔵)
    //#-end-copy-destination
    //#-end-editable-code
}

func blueFellFirst(ball: Ball) {
    // Drop a red, blue and red ball
    //#-code-completion(everything, hide)
    //#-code-completion(identifier, show, add(ball:), Ball)
    //#-code-completion(identifier, show, .)
    //#-code-completion(identifier, show, red, blue)
    //#-editable-code Tap to write your code
    //#-copy-destination("Preparing the Situation", id2)
    add(🔴)
    add(🔵)
    add(🔴)
    //#-end-copy-destination
    //#-end-editable-code
}

add(🔴)
add(🔵)
add(🔵)
add(🔴)
add(🔴)
//-hidden-code
level.blueBallFell = blueFellFirst
level.redBallFell = redFellFirst
level.ballsDropped = { amount, drops in
    vc.timesDroppedCountLabel.text = "\(drops)"
}
level.ballsBeganContact = { bodyA, bodyB in
    level.play(sound: .bump)
}
//#-end-hidden-code
