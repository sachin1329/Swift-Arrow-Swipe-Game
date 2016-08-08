//
//  ViewController.swift
//  Arrow
//
//  Created by Sachin Katyal on 7/19/16.
//  Copyright © 2016 Sachin Katyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var TestLabel: UILabel!
    @IBOutlet var arrowImage: [UIImageView]!
    @IBOutlet weak var Tscore: UILabel!
    
    var randomArrow = Int(arc4random_uniform(8) + 1)
    var GameOver = false
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
        
    }
    
    
    //randomly chooses and displays next arrow
    func chooseNextArrow() {
     if !GameOver {
        //chooses random arrow based on a number from 1 to 8
        randomArrow = Int(arc4random_uniform(8) + 1)
        print(randomArrow)
        
        //once chooses next Arrow, Arrow Shows on Screen in a customizable animation
        UIView.animateWithDuration(0.2, animations: {
            //change opacity of arrow
            self.arrowImage[self.randomArrow-1].alpha = 1

        })

        
        }
        
    }
    
    //sets up swiping gestures
    func setUpGestures() {
        
        //initalize swipes
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        //after swipe is detected, it will choose next arrow
        chooseNextArrow()

    }
    
    
//checks and reacts to different swipes
func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
    if !GameOver {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            if (randomArrow == 1 || randomArrow == 8) && swipeGesture.direction == UISwipeGestureRecognizerDirection.Right{
                print("Correct: Right")
                TestLabel.text = "Correct"
                
                //increases score if swipes in wrong direction
                score += 1
            } else if (randomArrow == 2 || randomArrow == 7) && swipeGesture.direction == UISwipeGestureRecognizerDirection.Left {
                print("Correc: Left")
                TestLabel.text = "Correct"
                score += 1
            } else if (randomArrow == 3 || randomArrow == 6) && swipeGesture.direction == UISwipeGestureRecognizerDirection.Down {
                print("correct: Down")
                TestLabel.text = "Correct"
                score += 1
            } else if (randomArrow == 4 || randomArrow == 5) && swipeGesture.direction == UISwipeGestureRecognizerDirection.Up {
                print("correct: Up")
                TestLabel.text = "Correct"
                score += 1
            } else  { //if swipe is wrong
                print("incorrect swipe")
                TestLabel.text = "Incorrect"
                
                //changes Gamover variable
                GameOver = false
            }
            
            //updates score text on screen
            Tscore.text = "\(score)"
            
        }
        
        for (index) in arrowImage.enumerate() {
            
            
            UIView.animateWithDuration(0.2, animations: {
                let grow = CGAffineTransformMakeScale(1.5,1.5)
                index.element.transform = grow
                
                //sets the reverse of the grow animation into the variable of shrink
                let shrink = CGAffineTransformInvert(grow)
                
                index.element.alpha = 0
                
                //shrinks the arrows
                index.element.transform = shrink
                
                
                
                //Total animation fades out the arrow while making it "pop" out of the screen
                
                
            })
        
        }
        
        
        
        chooseNextArrow()
        
    }
        
}
    

}

