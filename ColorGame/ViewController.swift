//
//  ViewController.swift
//  ColorGame
//
//  Created by Abby Dominguez on 7/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var screenSize = CGRect()
    private var screenWidth = CGFloat()
    private var screenHeight = CGFloat()
    private var margin = 22.0
    private var imageSizeDivider = CGFloat(2)
    private var monitorDivider = CGFloat(1.2)
    private let tapRed = UITapGestureRecognizer()
    private let tapBlue = UITapGestureRecognizer()
    private let tapGreen = UITapGestureRecognizer()
    private let tapYellow = UITapGestureRecognizer()
    
    @IBOutlet weak var monitorImage: ImageViewMonitor!
    @IBOutlet weak var buttonGreen: ImageViewButton!
    @IBOutlet weak var buttonBlue: ImageViewButton!
    @IBOutlet weak var buttonRed: ImageViewButton!
    @IBOutlet weak var buttonYellow: ImageViewButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            imageSizeDivider = 3
            monitorDivider = 1.5
            margin = 40
        }
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        monitorImage.resizeImage(targetSize: CGSize(width: screenWidth/monitorDivider, height: screenWidth/monitorDivider))
        monitorImage.layer.cornerRadius = 40
        buttonGreen.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenWidth/2 - margin))
        buttonGreen.layer.cornerRadius = 22
        buttonYellow.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenWidth/imageSizeDivider - margin))
        buttonYellow.layer.cornerRadius = 22
        buttonRed.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenWidth/imageSizeDivider - margin))
        buttonRed.layer.cornerRadius = 22
        buttonBlue.resizeImage(targetSize: CGSize(width: screenWidth/imageSizeDivider - margin, height: screenWidth/imageSizeDivider - margin))
        buttonBlue.layer.cornerRadius = 22
        buttonRed.name = "red"
        buttonBlue.name = "blue"
        buttonGreen.name = "green"
        buttonYellow.name = "yellow"
        //Add gesture recognizers
        tapRed.addTarget(self, action: #selector(self.tappedView(_:)))
        tapBlue.addTarget(self, action: #selector(self.tappedView(_:)))
        tapYellow.addTarget(self, action: #selector(self.tappedView(_:)))
        tapGreen.addTarget(self, action: #selector(self.tappedView(_:)))
        buttonGreen.isUserInteractionEnabled = true
        buttonRed.isUserInteractionEnabled = true
        buttonBlue.isUserInteractionEnabled = true
        buttonYellow.isUserInteractionEnabled = true
        buttonBlue.addGestureRecognizer(tapBlue)
        buttonGreen.addGestureRecognizer(tapGreen)
        buttonRed.addGestureRecognizer(tapRed)
        buttonYellow.addGestureRecognizer(tapYellow)
        
    
    }
    @objc func tappedView(_ sender: UITapGestureRecognizer){
        let buttonTapped = sender.view as! ImageViewButton
        switch(buttonTapped.name){
            case "red": self.monitorImage.image = UIImage(named: "RedButton")
            case "green": self.monitorImage.image = UIImage(named: "GreenButton")
            case "blue": self.monitorImage.image = UIImage(named: "BlueButton")
            case "yellow": self.monitorImage.image = UIImage(named: "YellowButton")
            default: print("oops")
        }
        self.monitorImage.resizeImage(targetSize: CGSize(width: self.screenWidth/self.monitorDivider, height: self.screenWidth/self.monitorDivider))
        self.monitorImage.layer.cornerRadius = 40
    }
}
