//
//  NumberGuessViewController.swift
//  NumberGuess
//
//  Created by pasico on 14-11-26.
//  Copyright (c) 2014年 com.pasico. All rights reserved.
//

import Foundation
import UIKit

class NumberGuessViewController:UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setSlider()
        setSureButton()
        setGuessLabel()
        setRandom()
    }
    
    var guessLabel:UILabel?
    var sureButton:UIButton?
    var guessSlider:UISlider?// 设置 猜数字的拉条
    var goalValue = 0
    
    var currentValue = 0
    
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
    
        guessSlider!.frame = CGRectMake(10,self.view.bounds.size.height-40,self.view.bounds.size.width-20,20)
        sureButton!.frame = CGRectMake(10,self.view.bounds.size.height-120,self.view.bounds.size.width-20,60)
        guessLabel!.frame = CGRectMake(10,20,self.view.bounds.size.width-20,60)
        
    }
    func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
    func setRandom(){
        goalValue = random(0...100)
        println("goalValue is:\(goalValue)")
    }
    func setGuessLabel(){
        guessLabel = UILabel()
        guessLabel!.textColor = UIColor.blackColor()
        guessLabel!.font = UIFont(name: nil,size:40)
//        guessLabel!.backgroundColor = UIColor.whiteColor()
        guessLabel!.textAlignment = NSTextAlignment.Center
        guessLabel!.text = "0"
//        timeLabel!.text = NSString(format: "%02d:%02d", mins, seconds)
        
        self.view.addSubview(guessLabel)
    }
        
    func setSlider(){

        guessSlider = UISlider()
        guessSlider!.minimumValue = 0.0
        guessSlider!.maximumValue = 100.0

        guessSlider!.addTarget(self,action:"sliderValueChanged:",forControlEvents:UIControlEvents.ValueChanged)
        self.view.addSubview(guessSlider)
    }
    func setSureButton(){
        sureButton = UIButton()
        sureButton!.backgroundColor = UIColor.blueColor();
        sureButton!.setTitleColor(UIColor.whiteColor(),forState:UIControlState.Normal)
        sureButton!.setTitle("确认",forState:UIControlState.Normal)
        sureButton!.addTarget(self,action:"sureButtonTapped:",forControlEvents:UIControlEvents.TouchUpInside)
        
        self.view.addSubview(sureButton)
    }
    
    func sureButtonTapped(sender: UIButton){
        println("sureButtonTapped")
        

        if(goalValue==currentValue){
            let alert = UIAlertView()
            alert.title = "game over"
            alert.message = ""
            alert.addButtonWithTitle("OK")
            alert.show()
        }else if(goalValue<currentValue){
//            guessSlider!.minimumValue = 0.0
            guessSlider!.maximumValue = Float(currentValue)
//            guessSlider.value = 
        }else{
            guessSlider!.minimumValue = Float(currentValue)
        }
    }
    func sliderValueChanged(sender: UISlider) {
        currentValue = Int(sender.value)
//        println("\(currentValue)")
        guessLabel!.text = "\(currentValue)"
    }
    
}
