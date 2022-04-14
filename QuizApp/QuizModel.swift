//
//  QuizModel.swift
//  QuizApp
//
//  Created by Meredith Anderer on 4/14/22.
//

import Foundation

protocol QuizProtocol {
    func questionsRetrieved(_ questions:[Question])
}

class QuizModel {
    
    var delegate: QuizProtocol?
    
    func getQuestions() {
        // TODO-  Fetch the questions
        var questions = [Question]()
        // Notify the delegate of the retrieved questions
        delegate?.questionsRetrieved(questions)
    }
}
