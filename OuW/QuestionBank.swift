//
//  QuestionBank.swift
//  OwU
//
//  Created by Nicholas Spoletini on 2019-05-07.
//  Copyright © 2019 Nicholas S. All rights reserved.
//

import Foundation

class QuesionBank {
    var list = [Question]()
    init() {
        
        
        
        // Creating a quiz item and appending it to the list
        let item = Question(text: "Did the two world wars give women right/'s?", correctAnswer: true)
        
        // Add the Question to the list of questions
        list.append(item)
        
        // skipping one step and just creating the quiz item inside the append function
        list.append(Question(text: "The turing point in WW2 for the USA was Midway?", correctAnswer: true))
        
        list.append(Question(text: "Am I going to fail the final project?", correctAnswer: true))
        
        list.append(Question(text: "The crusades were aimed re-taking the holy land?", correctAnswer: true))
        
        list.append(Question(text: "Am I going to ever get a job while in school?", correctAnswer: false))
        
        list.append(Question(text: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", correctAnswer: false))
        
        list.append(Question(text: "It is illegal to pee in the Ocean in Portugal.", correctAnswer: true))
        
        list.append(Question(text: "You can lead a cow down stairs but not up stairs.", correctAnswer: false))
        
        list.append(Question(text: "Google was originally called \"Backrub\".", correctAnswer: true))
        
        list.append(Question(text: "Buzz Aldrin\'s mother\'s maiden name was \"Moon\".", correctAnswer: true))
        
        list.append(Question(text: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", correctAnswer: false))
        
        list.append(Question(text: "No piece of square dry paper can be folded in half more than 7 times.", correctAnswer: false))
        
        list.append(Question(text: "Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.", correctAnswer: true))
    }
    
}

        
        
        

