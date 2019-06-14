//
//  Question.swift
//  OwU
//
//  Created by Nicholas Spoletini on 2019-05-07.
//  Copyright © 2019 Nicholas S. All rights reserved.
//

import Foundation

class Question {
    let questionText : String
    let answer : Bool
    init(text : String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
    
    
}
