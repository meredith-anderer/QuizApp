//
//  ViewController.swift
//  QuizApp
//
//  Created by Meredith Anderer on 4/14/22.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {

    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.getQuestions()
    }

    func questionsRetrieved(_ questions:[Question]) {
        //TO DO
    }

}

