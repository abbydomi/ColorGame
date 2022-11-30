//
//  GameOverViewController.swift
//  ColorGame
//
//  Created by Abby Dominguez on 30/11/22.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    
    override func viewDidLoad() {
        scoreLabel.text = String(score)
    }
}
