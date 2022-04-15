//
//  StateManager.swift
//  QuizApp
//
//  Created by Meredith Anderer on 4/15/22.
//

import Foundation

class StateManager {
    static var questionIndexKey = "QuestionIndexKey"
    static var numCorrectKey = "NumCorrectKey"
    
    static func saveState(questionIndex: Int, numCorrect: Int) {
        let defaults = UserDefaults.standard
        
        defaults.set(questionIndex, forKey: questionIndexKey)
        defaults.set(numCorrect, forKey: numCorrectKey)
    }
    
    static func retrieveValue(key: String) -> Any? {
        let defaults = UserDefaults.standard

        return defaults.object(forKey: key)
    }
    
    static func clearState() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: questionIndexKey)
        defaults.removeObject(forKey: numCorrectKey)
    }
}
