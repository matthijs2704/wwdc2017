/*:
 Okay, so now you know how to create and add new balls to the cylinder and we have a working [algorithm](glossary://algorithm) and situation to start our challenge.
 * callout(Goal):
 Produce a starting stack that consists of only four marbles, which will produce a never ending game.
 
 Just like last times, every cycle, it causes the two lowest marbles drop out. When the first marble to drop out is a red one `redFellFirst` is executed and when the first marble to drop out is a blue one `blueFellFirst` is executed. The game is over when two or less balls remain in the cylinder. So try to keep at least three balls in the cylinder.
 * note:
 Before you try to find the solution using [trial-and-error](glossary://trial-and-error), think about what you think the solution would be and why. Put yourself to the test and find the solution within 3 trials.
 */
//#-hidden-code
import SpriteKit
import PlaygroundSupport

let vc = LiveViewController.loadFromStoryboard() as! LiveViewController
PlaygroundPage.current.liveView = vc
vc.showsGoButton = true
//#-end-hidden-code
//#-hidden-code
/**
 * Easy way to create a loop for dropping balls
 *
 * - parameter every: Time in seconds to loop
 * - parameter codeToRun: Code to execute when the timer fires
 */
func loop(every: Double, _ codeToRun: @escaping (() -> Void)){
    vc.showsGoButton = false
    let timer = Timer.scheduledTimer(withTimeInterval: abs(every), repeats: true) { a in
        codeToRun()
        if level.state == .finished {
            #if !(arch(i386) || arch(x86_64))
                PlaygroundPage.current.assessmentStatus = .fail(hints: ["It looks like the stack wasn't producing an infinite game... Try a different combination!", "Try to figure out which balls in the starting stack have an effect on the times the balls can drop.", "Which of the two balls drop the most balls when dropped first?"], solution: nil)
                PlaygroundPage.current.finishExecution()
            #else
                print ("*Assessment failed* - Not infinite")
            #endif
            a.invalidate()
        }
    }
}
//#-end-hidden-code
//#-code-completion(everything, hide)
/*:
 Change the color of the balls below to create a stack of marbles.
 */
//#-code-completion(identifier, show, 🔴, 🔵)
add(ball: /*#-editable-code Ball*/🔴/*#-end-editable-code*/)
add(ball: /*#-editable-code Ball*/🔴/*#-end-editable-code*/)
add(ball: /*#-editable-code Ball*/🔴/*#-end-editable-code*/)
add(ball: /*#-editable-code Ball*/🔴/*#-end-editable-code*/)

//#-code-completion(identifier, show, add(_:))
func redFellFirst(ball: Ball) {
    // This code should drop a blue ball
    //#-editable-code Tap to write your code
    //#-copy-destination("Preparing the Situation", id1)
    add(ball: 🔵)
    //#-end-copy-destination
    //#-end-editable-code
}

func blueFellFirst(ball: Ball) {
    // This code should drop a red, blue and another red ball
    //#-editable-code Tap to write your code
    //#-copy-destination("Preparing the Situation", id2)
    add(ball: 🔴)
    add(ball: 🔵)
    add(ball: 🔴)
    //#-end-copy-destination
    //#-end-editable-code
}

// Looping code
// Change the time to a lower value to drop balls faster
loop(every: /*#-editable-code Time in seconds*/2.5/*#-end-editable-code*/) {
    dropBalls()
}

//#-hidden-code
level.blueBallFell = blueFellFirst
level.redBallFell = redFellFirst
level.ballsDropped = { amount, drops in
    vc.timesDroppedCountLabel.text = "\(drops)"
    if drops == 10 {
        #if !(arch(i386) || arch(x86_64))
            PlaygroundPage.current.assessmentStatus = .pass(message: "Congratulations, you've done it! 🎉 The way you thought about finding the solution was done using computational thinking, at least if you didn't use trial-and-error 😉")
        #else
            print ("*Assessment successfull* - Correct amount and order of balls!")
        #endif
    }
}
level.ballsBeganContact = { bodyA, bodyB in
    level.play(sound: .bump)
}
//#-end-hidden-code
