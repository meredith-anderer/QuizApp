//
//  ViewController.swift
//  QuizApp
//
//  Created by Meredith Anderer on 4/14/22.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set self as the delegate and datasource for the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set up the model
        model.delegate = self
        model.getQuestions()
    }
    
    //MARK: - Logic Methods
    func displayQuestion() {
        // Check if there are questions/ that the currentQUestionIndex is not out of bounds
        guard currentQuestionIndex < questions.count && questions.count > 0 else { return }
        
        // Display the question text
        questionLabel.text = questions[currentQuestionIndex].question
        
        // Reload the tableview with the answers for this question
        tableView.reloadData()
    }
    
    //MARK: - UITableView Protocol Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        // Customize it
        cell.isSelected = false
        let answerText = questions[currentQuestionIndex].answers?[indexPath.row]
        let label = cell.viewWithTag(1) as? UILabel
        label?.text = answerText
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Make sure the question array has a value for the current index before trying to access element at that index to prevent crash
        guard questions.count > currentQuestionIndex else {return 0}
        // Return the number of answers for the question being displayed
        return questions[currentQuestionIndex].answers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if there are questions/ that the currentQUestionIndex is not out of bounds
        guard currentQuestionIndex < questions.count && questions.count > 0 else { return }
        // Display the feedback
        let currentQuestion = questions[currentQuestionIndex]
        // Check if the correct answer was selected and handle accordingly
        if indexPath.row == currentQuestion.correctAnswerIndex {
            
        } else {
            
        }
        // Update the currentQuestionIndex by either incrementing it or resetting it to 0 if the question currently displayed was the last one
        if currentQuestionIndex >= questions.count - 1 {
            // This was the last question, go back to the beginning
            currentQuestionIndex = 0
        } else {
            //Increment the currentQuestionINdex to display the next question
            currentQuestionIndex += 1
        }
        // Display the next question, or go back to beginning if this was the last one.
        displayQuestion()
    }
    
    //MARK: - QuizProtocol Methods
    func questionsRetrieved(_ questions:[Question]) {
        // Get a reference to the questsions
        self.questions = questions
        
        //Display the first question
        displayQuestion()
        
        //Reload the tableview
        tableView.reloadData()
    }

}

