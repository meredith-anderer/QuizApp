//
//  ViewController.swift
//  QuizApp
//
//  Created by Meredith Anderer on 4/14/22.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource, ResultViewControllerProtocol {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    
    var resultDialog: ResultViewController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the result dialog
        resultDialog = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        resultDialog?.delegate = self
        
        // Set self as the delegate and datasource for the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Dynamic row heights
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
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
        let currentQuestion = questions[currentQuestionIndex]
        
        // Check if the correct answer was selected and handle accordingly
        if indexPath.row == currentQuestion.correctAnswerIndex {
            resultDialog?.titleText = "Correct!"
            numCorrect += 1
        } else {
            resultDialog?.titleText = "Wrong!"
        }
        
        // Set the feedback text
        resultDialog?.feedbackText = currentQuestion.feedback ?? ""

        // Make different updates depending on if the question displayed was the last one or not
        if currentQuestionIndex >= questions.count - 1 {
            // This was the last question, go back to the beginning
            currentQuestionIndex = 0
            resultDialog?.feedbackText += "\n\nYou got \(numCorrect) correct out of \(questions.count) questions."
            resultDialog?.buttonText = "Start Over"
            //clear the state
            StateManager.clearState()
        } else {
            //Increment the currentQuestionINdex to display the next question
            currentQuestionIndex += 1
            resultDialog?.buttonText = "Next"
        }
        
        // Save the state
        StateManager.saveState(questionIndex: self.currentQuestionIndex, numCorrect: self.numCorrect)
        //Display the result dialog
        if let resultDialog = resultDialog {
            // Ensure that we are doing layout work on main thread
            DispatchQueue.main.async {
                self.present(resultDialog, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - QuizProtocol Methods
    func questionsRetrieved(_ questions:[Question]) {
        // Get a reference to the questsions
        self.questions = questions
        
        // Check if we should restore the sate before showing question #1
        if let questionIndex = StateManager.retrieveValue(key: StateManager.questionIndexKey) as? Int, let numCorrect = StateManager.retrieveValue(key: StateManager.numCorrectKey) as? Int, questionIndex < self.questions.count {
            self.currentQuestionIndex = questionIndex
            self.numCorrect = numCorrect
        }

        //Display the first question
        displayQuestion()
        
        //Reload the tableview
        tableView.reloadData()
    }
    
    //MARK: - ResultViewControllerProtocol Methods
    func dialogDismissed() {
        // Display the next question, or go back to beginning if this was the last one.
        displayQuestion()
    }

}

