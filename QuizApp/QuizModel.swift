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
        getQuestionsFromLocalJSONFile()
    }
    
    func getQuestionsFromLocalJSONFile() {
        // Get the bundle path to json file
        guard let path = Bundle.main.path(forResource: "QuestionData", ofType: "json") else { return }
        
        //Create URL object from the path
        let url = URL(fileURLWithPath: path)
        
        do {
        //Get the Data from the URL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let questions: [Question] = try decoder.decode([Question].self, from: data)
            // Notify the delegate of the retrieved questions
            delegate?.questionsRetrieved(questions)
        }
        catch{
            // Error: Couldn't get the data at that url
        }
    }
    
    func getQuestionsFromRemoteJSONFile() {
        // TO DO
    }
}
