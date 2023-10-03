//
//  ViewController.swift
//  Trivia
//
//  Created by Hai Anh on 02/10/2023.
//

import UIKit

struct QuizQuestion {
    let questionText: String
    let answerChoices: [String]
    let correctAnswerIndex: Int
}

    
class ViewController: UIViewController {
    
    // UI Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    @IBOutlet weak var questionNumber: UILabel!
    
    var quizQuestions = [
        QuizQuestion(questionText: "What is the capital of France?", answerChoices: ["Paris", "London", "Berlin", "Rome"], correctAnswerIndex: 1),
        QuizQuestion(questionText: "What is the largest ocean in the world?", answerChoices: ["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Arctic Ocean"], correctAnswerIndex: 1),
        QuizQuestion(questionText: "What is the chemical symbol for water?", answerChoices: ["H2O", "CO2", "O2", "H2"], correctAnswerIndex: 1)
    ]
    
    var currentQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestion()
        setupAction()
    }

    
    
    func setupQuestion() {
        let currentQuestion = quizQuestions[currentQuestionIndex]
        questionNumber.text = "Question \(currentQuestionIndex + 1)/3."
        questionLabel.text = currentQuestion.questionText
        answerOne.setTitle(currentQuestion.answerChoices[0], for: .normal)
        // !!! What is for. normal
        // !!! Is setTitle only for button and text only for label?
        answerTwo.setTitle(currentQuestion.answerChoices[1], for: .normal)
        answerThree.setTitle(currentQuestion.answerChoices[2], for: .normal)
        answerFour.setTitle(currentQuestion.answerChoices[3], for: .normal)
    }
    
    func setupAction() {
        // !!! What is this structure?
        answerOne.addTarget(self, action: #selector(optionSelected(_:)), for:.touchUpInside)
        answerTwo.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        answerThree.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        answerFour.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        
    }
    
    // !!! What is objc. What is sender
    @objc func optionSelected(_ sender: UIButton) {
        guard let selectedOption = sender.titleLabel?.text else { return }
        
        // Identity the button pressed using its title
        print("User selected: \(selectedOption)")
        
        // Check if answer is correct
        var correctAnswerIndex = quizQuestions[currentQuestionIndex].correctAnswerIndex
        if selectedOption == quizQuestions[currentQuestionIndex].answerChoices[correctAnswerIndex] {
            print("Correct answer!")
            score += 1
        } else { print("Incorrect answer.") }
        
        // Move to another question
        if currentQuestionIndex < quizQuestions.count - 1 {
            currentQuestionIndex += 1
            setupQuestion()
        } else {
            print("Quiz finished! You got \(score)/3 scores.")
            showResult()
        }
    }
    
    func showResult() {
        let alertController = UIAlertController(title: "Quiz finished!", message: "You got \(score)/3 scores.", preferredStyle: .alert)
        
        // Add actions to alertController
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let restartAction = UIAlertAction(title: "Restart", style: .default) { action in
            self.currentQuestionIndex = 0
            self.score = 0
            self.setupQuestion()
            self.setupAction()
        }
        
        // Add actions to the alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(restartAction)
        
        // Present the alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    /*
    @IBAction func answerClick(_ sender: Any) {
        let selectedAnswer = (sender as! UIButton).titleLabel!.text!
        //let selectedAnswer = sender.titleLabel!.text!
        if selectedAnswer == quizQuestions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        
        if currentQuestionIndex >= quizQuestions.count {
            // The quiz is over
            let message = "Congratulations on completing the quiz! Your score is \(score)."
            questionLabel.text = message
        } else {
            currentQuestionIndex += 1
            // Generate a new question
            generateRandomQuestion()
        }*/
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
    


