import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var imgQuestion: UIImageView!
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    @IBOutlet weak var viewFeddback: UIView!
    @IBOutlet weak var feedbackText: UILabel!
    @IBOutlet weak var feedbackButton: UIButton!
    
    var questions : [Question]!
    var currentQuestion = 0
    var grade = 0.0
    var quizEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
        startQuiz()
    }
    
    func loadQuestions() -> Void {
        let question1 = Question(
            question: "Quantos anos em média vive um elefante africano?",
            img: "elefante",
            answers: [
                Answer(answer: "120 anos", isRight: true),
                Answer(answer: "80 anos", isRight: false),
                Answer(answer: "140 anos", isRight: false),
                Answer(answer: "54 km/h", isRight: false)
            ]
            
        )
        
        let question2 = Question(
            question: "Quantos metros em média tem uma girafa macho adulta?",
            img: "girafa",
            answers: [
                Answer(answer: "5,5 metros", isRight: true),
                Answer(answer: "3,5 metros", isRight: false),
                Answer(answer: "4,5 metros", isRight: false),
                Answer(answer: "54 km/h", isRight: false)
            ]
            
        )
        
        let question3 = Question(
            question: "Quanto pesa em média um rinoceronte macho adulto?",
            img: "rinoceronte",
            answers: [
                Answer(answer: "2300 kg", isRight: true),
                Answer(answer: "3300 kg", isRight: false),
                Answer(answer: "4300 kg", isRight: false),
                Answer(answer: "54 km/h", isRight: false)
            ]
            
        )
        
        let question4 = Question(
            question: "Qual a velocidade de uma zebra?",
            img: "zebra",
            answers: [
                Answer(answer: "64 km/h", isRight: true),
                Answer(answer: "74 km/h", isRight: false),
                Answer(answer: "54 km/h", isRight: false),
                Answer(answer: "54 km/h", isRight: false)
            ]
            
        )
        
        let question5 = Question(
            question: "Qual a velocidade de uma zebra?",
            img: "zebra",
            answers: [
                Answer(answer: "64 km/h", isRight: true),
                Answer(answer: "74 km/h", isRight: false),
                Answer(answer: "54 km/h", isRight: false),
                Answer(answer: "54 km/h", isRight: false)
            ]
            
        )
        
        let question6 = Question(
            question: "Qual a velocidade de uma zebra?",
            img: "zebra",
            answers: [
                Answer(answer: "64 km/h", isRight: true),
                Answer(answer: "74 km/h", isRight: false),
                Answer(answer: "54 km/h", isRight: false),
                Answer(answer: "54 km/h", isRight: false)
            ]
            
        )
        
        self.questions = [
            question1,
            question2,
            question3,
            question4,
            question5,
            question6
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }
    
    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }
    
    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    
    @IBAction func chooseAnswer4(sender: AnyObject) {
        selectAnswer(3)
    }
    
    func startQuiz() -> Void {
        questions.shuffle()
        
        for(var i=0; i < questions.count; i++) {
            questions[i].answers.shuffle()
        }
        
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        viewFeddback.hidden = true
        
        showQuestion(0)
    }
    
    func showQuestion(questionId : Int) -> Void {
        enableButtons()
        
        let selectedQuestion : Question = questions[questionId]
        question.text = selectedQuestion.question
        imgQuestion.image = selectedQuestion.img
        
        answer1.setTitle(selectedQuestion.answers[0].response, forState: UIControlState.Normal)
        answer2.setTitle(selectedQuestion.answers[1].response, forState: UIControlState.Normal)
        answer3.setTitle(selectedQuestion.answers[2].response, forState: UIControlState.Normal)
    }
    
    func disableButtons() -> Void {
        answer1.enabled = false
        answer2.enabled = false
        answer3.enabled = false
        answer4.enabled = false
        question.hidden = true
    }
    
    func enableButtons() -> Void {
        answer1.enabled = true
        answer2.enabled = true
        answer3.enabled = true
        answer4.enabled = true
        question.hidden = false
    }
    
    func selectAnswer(answerId : Int) -> Void {
        disableButtons()
        
        let answer : Answer = questions[currentQuestion].answers[answerId]
        
        if (true == answer.isRight) {
            grade += 1.0
            feedbackText.text = answer.response + "\n\nResposta correta!"
            viewFeddback.backgroundColor = UIColor.greenColor()
            feedbackText.textColor = UIColor.blackColor()
        } else {
            viewFeddback.backgroundColor = UIColor.redColor()
            feedbackText.text = answer.response + "\n\nResposta incorreta!"
            feedbackText.textColor = UIColor.whiteColor()
        }
        
        if (currentQuestion < questions.count-1) {
            feedbackButton.setTitle("Próxima", forState: UIControlState.Normal)
        } else {
            feedbackButton.setTitle("Ver nota", forState: UIControlState.Normal)
        }
        
        viewFeddback.hidden = false
    }
    
    @IBAction func sendFeedback(sender: AnyObject) {
        viewFeddback.hidden = true
        
        if (true == quizEnded) {
            startQuiz()
        } else {
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        currentQuestion++
        
        if (currentQuestion < questions.count) {
            showQuestion(currentQuestion)
        } else {
            endQuiz()
        }
    }
    
    func endQuiz() {
        grade = grade / Double(questions.count) * 100.0
        quizEnded = true
        viewFeddback.hidden = false
        
        viewFeddback.backgroundColor = UIColor.whiteColor()
        feedbackText.textColor = UIColor.blackColor()
    
        
        feedbackText.text = "Sua nota \(round(grade))"
        feedbackButton.setTitle("Refazer", forState: UIControlState.Normal)
    }
    
}

