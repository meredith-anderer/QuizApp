//
//  Question.swift
//  QuizApp
//
//  Created by Meredith Anderer on 4/14/22.
//

import Foundation

struct Question: Codable {
    var question: String?
    var answers: [String]?
    var correctAnswerIndex: Int?
    var feedback: String?
}
