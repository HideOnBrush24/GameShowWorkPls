//
//  ViewController.swift
//  OwU
//
//  Created by Nicholas Spoletini on 2019-05-07.
//  Copyright © 2019 Nicholas S. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            
            try button0.setDeviceSerialNumber(528055)
            try button0.setHubPort(2)
            try button0.setIsHubPortDevice(true)
            
            try button1.setDeviceSerialNumber(528055)
            try button1.setHubPort(3)
            try button1.setIsHubPortDevice(true)
            
            let _ = button0.attach.addHandler(attach_handler)
            let _ = button1.attach.addHandler(attach_handler)
            
            let _ = button0.stateChange.addHandler(buttonTrue_button0)
            let _ = button1.stateChange.addHandler(buttonfalse_button1)
            
            try button0.open()
            try button1.open()
            
            
            for i in 0..<ledArray.count{
                try ledArray[i].setDeviceSerialNumber(528055)
                try ledArray[i].setHubPort(i)
                try ledArray[i].setIsHubPortDevice(true)
                let _ = ledArray[i].attach.addHandler(attach_handler)
                try ledArray[i].open()
                
            }
        } catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        } catch {
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let button0 = DigitalInput()
    let button1 = DigitalInput()
    let ledArray = [DigitalOutput(),DigitalOutput()]
    var GreenScore : Int = 0
    var RedScore : Int = 0
    var questionNumber : Int = 0
    var pickedAnswer : Bool = false
    let allQuestion = QuesionBank()
    var buttonPressed = "none"
    
    
    
    func attach_handler(sender: Phidget){
        do{
            let hubPort = try sender.getHubPort()
            
            if(try sender.getHubPort() == 0){
                print("Button true Attached")
            }
            else if (hubPort == 2){
                print("Led 1 attached")
            }
            else{
                print("button false attached")
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    func buttonTrue_button0(sender:DigitalInput, state: Bool){
        do{
            if(state == true){
                print("true")
                 try ledArray[0].setState(true)
                    pickedAnswer = true
                if (buttonPressed == "none"){
                    buttonPressed = "Green"
                    
                }
                updateGreenPlayerUI()
                GreenScoreUI()
                    
            }
            else{
                print("not pressed")
                
            }
        } catch let err as PhidgetError {
            print("phidget Error " + err.description)
        } catch {
            
        }
    }
    
    func buttonfalse_button1(sender:DigitalInput, state: Bool){
        do{
            if(state == true){
                try ledArray[1].setState(true)
                print("false")
                pickedAnswer = false
                if (buttonPressed == "none"){
                    buttonPressed = "Red"
                }
                updateRedPlayerUI()
                RedScoreUI()
               
                
            }
            else{
                print("not pressed")
                
            }
        } catch let err as PhidgetError {
            print("phidget Error " + err.description)
        } catch {
        
        }
        
        self.nextQuestion()
        
    }
    
   

    
    
    // buttons and text fields
    @IBOutlet weak var Question: UILabel!
    @IBAction func buttonPressed(_ sender: AnyObject) {
        DispatchQueue.main.async {
        if sender.tag == 1 {
            self.pickedAnswer = false
        }
        else if sender.tag == 2 {
            self.pickedAnswer = true
        }
            
            self.checkAnswerGreen()
            self.checkAnswerRed()
            
            self.questionNumber = self.questionNumber + 1
            
            self.nextQuestion()
    }
}
    // score funcs
    func updateRedPlayerUI() {
        DispatchQueue.main.async {
            self.pickedAnswer = false
            
            self.checkAnswerRed()
            
            self.questionNumber = self.questionNumber + 1
            
            self.nextQuestion()
            
        }
    }
    
    func updateGreenPlayerUI() {
        DispatchQueue.main.async {
            self.pickedAnswer = true
            
            self.questionNumber = self.questionNumber + 1
            
            self.checkAnswerGreen()
            
            self.nextQuestion()
            
            
        }
    }
    
    func RedScoreUI() {
        DispatchQueue.main.async {
            self.RedPlayerScore.text = "RedScore : \(self.RedScore)"
            
        }
    }
    
    func GreenScoreUI() {
        DispatchQueue.main.async {
            self.GreenPLayerScore.text = "GreenScore : \(self.GreenScore)"
            
        }
    }
    
  
   
    
    @IBOutlet weak var RedPlayerScore: UILabel!
    @IBOutlet weak var GreenPLayerScore: UILabel!
    @IBOutlet weak var RedButton_False: UIButton!
    @IBOutlet weak var GreenButton_True: UIButton!
    @IBOutlet weak var ProgressBar: UIView!
    @IBOutlet weak var ProgressLabel: UILabel!
    
    // func
    func nextQuestion() {
        DispatchQueue.main.async {
            if self.questionNumber <= 12 {
            self.Question.text = self.allQuestion.list[self.questionNumber].questionText
      
            }
            else {
                let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                    self.startOver()
                })
                
                alert.addAction(restartAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func checkAnswerGreen() {
        DispatchQueue.main.async {
            
            let correctAnswerGreen = self.allQuestion.list[self.questionNumber].answer
            
            if correctAnswerGreen == self.pickedAnswer {
                print("GJ Green You got it!")
                self.GreenScore += 1
                
            } else {
                print("Green False")
            }
            
            if self.questionNumber >= 12 {
                self.startOver()
                self.questionNumber = self.questionNumber + 0
            }
            else {
                print("nothing")
            }
        }
    }
    
    func checkAnswerRed() {
        DispatchQueue.main.async {
            
            
            
            let correctAnswerRed = self.allQuestion.list[self.questionNumber].answer
            
            if correctAnswerRed == self.pickedAnswer {
                print("GJ Red You got it!")
                self.RedScore += 1
                
            } else {
                print("Red false")
        }
            if self.questionNumber >= 12 {
                self.startOver()
                self.questionNumber = self.questionNumber + 0
            }
            else {
                print("nothing")
            }
        }
    }
        
    
    
    func startOver() {
        DispatchQueue.main.async {
            self.questionNumber = 0
            self.nextQuestion()
            self.GreenScoreUI()
            self.RedScoreUI()
            self.RedScore = 0
            self.GreenScore = 0
        }
    }
    
    
    
    
    
    
    
   



}

