//
//  ViewController.swift
//  Project2
//
//  Created by RAJ RAVAL on 09/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = (countries[correctAnswer].uppercased())
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title:String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            totalAnswer += 1
            if totalAnswer == 10 {
                let bc = UIAlertController(title: "Final Score : \(score)", message: "Do you want to replay?", preferredStyle: .alert)
                bc.addAction(UIAlertAction(title: "Replay", style: .default, handler: askQuestion))
                present(bc, animated: true)
                score = 0
                totalAnswer = 0
            } else {
                let ac = UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
            }
        } else {
            title = "Wrong"
            score -= 1
            totalAnswer += 1
            let rc = UIAlertController(title: title, message: "It is flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            rc.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(rc, animated: true)
        }
        
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Current Score", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
}

