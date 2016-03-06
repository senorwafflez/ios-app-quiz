//
//  QuizModel.swift
//  Quiz
//
//  Created by Dan Jesus on 1/16/16.
//  Copyright © 2016 Dan Jesus. All rights reserved.
//

import Foundation
import UIKit

class Question {
    var question : String?
    var img : UIImage!
    var answers : [Answer]!
    
    init (question: String, img: String, answers: [Answer]) {
        self.question = question
        self.img = UIImage(named: img)
        self.answers = answers
    }
}

class Answer {
    var response: String!
    var isRight: Bool!
    
    init(answer: String, isRight: Bool) {
        self.response  = answer
        self.isRight = isRight
    }
}
