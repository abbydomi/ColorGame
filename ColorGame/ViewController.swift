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
        
    
    }
}
