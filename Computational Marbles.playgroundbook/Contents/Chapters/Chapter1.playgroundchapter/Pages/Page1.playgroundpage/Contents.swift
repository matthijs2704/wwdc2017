/*:
* callout(Goal):
 Create the `redFellFirst` and `blueFellFirst` functions to finish the [algorithm](glossary://algorithm) described below.
 
 We start of with a cylinder consisting of 5 marbles, which are either red or blue. Every time you press the **GO** button, it causes the two lowest marbles drop out. When there are two or less balls in the cylinder left, the game is over.
 Now your task is to create the `redFellFirst` and `blueFellFirst` [functions](glossary://function) to do the following:
 * callout(Red fell first):
 Drop a blue ball
 
 
 * callout(Blue fell first):
 Drop a red, then a blue and lastly another red ball

 Tap the functions below to enter the code to conform to these requirements and remember to look into other parts of the code, which might give you clues on how to do certain stuff. Press `Run My Code` whenever you're ready and drop the balls two times by pressing the **GO** button to check if you've done it correctly!
 */
//#-hidden-code
import SpriteKit
import PlaygroundSupport

let vc = LiveViewController.loadFromStoryboard() as! LiveViewController
PlaygroundPage.current.liveView = vc
vc.showsGoButton = true
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, add(_:))
//#-code-completion(identifier, show, 🔴, 🔵)
func redFellFirst(ball: Ball) {
    //#-copy-source(id1)
    //#-editable-code Tap to write your code
    //#-end-editable-code
    //#-end-copy-source
    //#-hidden-code
    // Solution:
    //add(🔵)
    //#-end-hidden-code
}

func blueFellFirst(ball: Ball) {
    //#-copy-source(id2)
    //#-editable-code Tap to write your code
    //#-end-editable-code
    //#-end-copy-source
    //#-hidden-code
    // Solution:
    //add(🔴)
    //add(🔵)
    //add(🔴)
    //#-end-hidden-code
}

/* The next few lines of code will add 5 balls to the cylinder at the start. */
add(🔴)
add(🔵)
add(🔵)
add(🔴)
add(🔴)
//#-hidden-code
func checkAssessment() {
    print ("Checking assessment")
    let bis = level.ballsInStack
    guard bis.count == 5 else {
        #if !(arch(i386) || arch(x86_64))
            PlaygroundPage.current.assessmentStatus = .fail(hints: ["Make sure you are dropping all the nescessary balls"], solution: "The `redFellFirst` function should contain:\n\n`add(🔵)`\n\nAnd `blueFellFirst` function should contain:\n\n`add(🔴)`\n\n`add(🔵)`\n\n`add(🔴)`")
        #else
            print ("*Assessment failed* - Not enough items in stack")
        #endif
        return
    }
    
    guard bis[0].type == .red && bis[1].type == .blue && bis[2].type == .red && bis[3].type == .blue && bis[4].type == .red else {
        #if !(arch(i386) || arch(x86_64))
            PlaygroundPage.current.assessmentStatus = .fail(hints: ["Use the `add(ball:)` function to add the right balls in the functions", "Make sure you are dropping red, blue, red when the first ball falling is blue", "Make sure you are dropping a blue ball when the first ball falling is red"], solution: "The `redFellFirst` function should contain:\n\n`add(🔵)`\n\nAnd `blueFellFirst` function should contain:\n\n`add(🔴)`\n\n`add(🔵)`\n\n`add(🔴)")
        #else
            print ("*Assessment failed* - Wrong balls in stack")
        #endif
        return
    }
    
    #if !(arch(i386) || arch(x86_64))
        PlaygroundPage.current.assessmentStatus = .pass(message: "Correct! ✅ You have finished writing the algorithm correctly. Now let's go to the [next page](@next) to automate the ball cycling.")
    #else
        print ("*Assessment successfull* - Correct amount and order of balls!")
    #endif

}

level.blueBallFell = blueFellFirst
level.redBallFell = redFellFirst
level.ballsDropped = { amount, drops in
    vc.timesDroppedCountLabel.text = "\(drops)"
    if drops == 2 {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            checkAssessment()
        }
    }
}
level.ballsBeganContact = { bodyA, bodyB in
    level.play(sound: .bump)
}
//#-end-hidden-code
