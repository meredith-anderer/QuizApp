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
        //getQuestionsFromLocalJSONFile()
        getQuestionsFromRemoteJSONFile()
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
        let urlString = "https://codewithchris.com/code/QuestionData.json"
        
        // Get a URL object
        guard let url = URL(string: urlString) else { return }
        
        // Get a URL Session object
        let session = URLSession.shared

        // Get a data task object
        let datatask = session.dataTask(with: url) {data, response, error in
            if let data = data, error == nil {
                let decoder = JSONDecoder()
                
                if let questions = try? decoder.decode([Question].self, from: data) {
                    // Use the main thread to notify the view controller for UI Work
                    DispatchQueue.main.async {
                        // Notify the delegate
                        self.delegate?.questionsRetrieved(questions)
                    }
                }
            }
        }
        // Call resume on the data task
        datatask.resume()
    }
}
