//
//  ViewController.swift
//  ColorGame
//
//  Created by Abby Dominguez on 7/11/22.
//

import UIKit

enum Color {
    case red, green, blue, yellow, gray
}

class ViewController: UIViewController {
    
    private var screenSize = CGRect()
    private var screenWidth = CGFloat()
    private var screenHeight = CGFloat()
    private var margin = 22.0
    private var imageSizeDivider = CGFloat(2.1)
    private var monitorDivider = CGFloat(1.5)
    private let tapRed = UITapGestureRecognizer()
    private let tapBlue = UITapGestureRecognizer()
    private let tapGreen = UITapGestureRecognizer()
    private let tapYellow = UITapGestureRecognizer()
    private var colorList: [Color] = []
    private var userTapIndex = 0
    private var score = 0
    private var speed = 1.0
    
    @IBOutlet weak var monitorImage: ImageViewMonitor!
    @IBOutlet weak var buttonGreen: ImageViewButton!
    @IBOutlet weak var buttonBlue: ImageViewButton!
    @IBOutlet weak var buttonRed: ImageViewButton!
    @IBOutlet weak var buttonYellow: ImageViewButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            imageSizeDivider = 2.9
            monitorDivider = 1.6
            margin = 40
        }
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        monitorImage.resizeImage(targetSize: CGSize(width: screenWidth/monitorDivider, height: screenHeight/monitorDivider))
        monitorImage.layer.cornerRadius = 10
        
        disablePlay()
        
        buttonRed.name = Color.red
        buttonBlue.name = Color.blue
        buttonGreen.name = Color.green
        buttonYellow.name = Color.yellow
        
        //Add gesture recognizers
        tapRed.addTarget(self, action: #selector(self.tappedView(_:)))
        tapBlue.addTarget(self, action: #selector(self.tappedView(_:)))
        tapYellow.addTarget(self, action: #selector(self.tappedView(_:)))
        tapGreen.addTarget(self, action: #selector(self.tappedView(_:)))
        buttonBlue.addGestureRecognizer(tapBlue)
        buttonGreen.addGestureRecognizer(tapGreen)
        buttonRed.addGestureRecognizer(tapRed)
        buttonYellow.addGestureRecognizer(tapYellow)
        
        //Game start
        initColorList(amount: 4)
        showColorList(speed: speed, index: 0)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOverSeg"{
            let destination = segue.destination as? GameOverViewController
            destination?.score = self.score
        }
    }
    
    @objc func tappedView(_ sender: UITapGestureRecognizer){
        let buttonTapped = sender.view as! ImageViewButton
        if buttonTapped.isUserInteractionEnabled {
            print(userTapIndex)
            if self.colorList.count-2 == userTapIndex {
                nextLevel()
            } else {
                if self.colorList[userTapIndex] == buttonTapped.name {
                    print("👍")
                } else {
                    gameOver()
                }
                userTapIndex+=1
            }
        }
    }
    func randomColor() -> Color{
        let i = Int.random(in: 0..<5)
        switch(i){
        case 1: return Color.red
        case 2: return Color.green
        case 3: return Color.blue
        case 4: return Color.yellow
        default: return Color.red
        }
    }
    func addColorToList(color: Color){
        colorList.append(color)
    }
    func showColorList(speed: TimeInterval, index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + speed){
            self.changeMonitorImage(color: self.colorList[index])
            if index != self.colorList.count-1 {
                self.showColorList(speed: speed, index: index+1)
                print(self.colorList[index])
            } else {
                print(self.colorList.count-1)
                self.changeMonitorImage(color: Color.gray)
                self.enablePlay()
            }
        }
    }
    func changeMonitorImage(color: Color){
        switch(color){
        case Color.red: monitorImage.image = UIImage(named: "RedButton")
        case Color.green: monitorImage.image = UIImage(named: "GreenButton")
        case Color.yellow: monitorImage.image = UIImage(named: "YellowButton")
        case Color.blue: monitorImage.image = UIImage(named: "BlueButton")
        case Color.gray: monitorImage.image = UIImage(named: "GrayButton")
        }
        monitorImage.resizeImage(targetSize: CGSize(width: screenWidth/monitorDivider, height: screenHeight/monitorDivider))
        monitorImage.layer.cornerRadius = 10
    }
    func initColorList(amount: Int){
        colorList = []
        var i = 0
        while (i <= amount) {
            addColorToList(color: randomColor())
            i+=1
        }
    }
    func disablePlay(){
        userTapIndex = 0
        buttonBlue.image = UIImage(named: "GrayButton")
        buttonBlue.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonBlue.layer.cornerRadius = 22
        buttonRed.image = UIImage(named: "GrayButton")
        buttonRed.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonRed.layer.cornerRadius = 22
        buttonGreen.image = UIImage(named: "GrayButton")
        buttonGreen.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonGreen.layer.cornerRadius = 22
        buttonYellow.image = UIImage(named: "GrayButton")
        buttonYellow.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonYellow.layer.cornerRadius = 22
        buttonBlue.isUserInteractionEnabled = false
        buttonRed.isUserInteractionEnabled = false
        buttonGreen.isUserInteractionEnabled = false
        buttonYellow.isUserInteractionEnabled = false
    }
    func enablePlay(){
        buttonBlue.image = UIImage(named: "BlueButton")
        buttonBlue.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonBlue.layer.cornerRadius = 22
        buttonRed.image = UIImage(named: "RedButton")
        buttonRed.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonRed.layer.cornerRadius = 22
        buttonGreen.image = UIImage(named: "GreenButton")
        buttonGreen.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonGreen.layer.cornerRadius = 22
        buttonYellow.image = UIImage(named: "YellowButton")
        buttonYellow.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenHeight/imageSizeDivider - margin))
        buttonYellow.layer.cornerRadius = 22
        buttonBlue.isUserInteractionEnabled = true
        buttonRed.isUserInteractionEnabled = true
        buttonGreen.isUserInteractionEnabled = true
        buttonYellow.isUserInteractionEnabled = true
        buttonYellow.isUserInteractionEnabled = true
    }
    func gameOver(){
        let uialert = UIAlertController(title: "Game over", message: "Boo!!", preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: ":(", style: UIAlertAction.Style.default, handler: {
            (action) in
            self.disablePlay()
            self.initColorList(amount: 4)
            self.showColorList(speed: 1.0, index: 0)
        }))
        //self.present(uialert, animated: true, completion: nil)
        self.performSegue(withIdentifier: "gameOverSeg", sender: Any?.self)
    }
    func nextLevel(){
        if speed > 0.2 {
            speed = speed-0.1
        }
        score+=1
        disablePlay()
        addColorToList(color: randomColor())
        showColorList(speed: speed, index: 0)
    }
}
