//
//  ActionViewController.swift
//  My Meal
//
//  Created by 肖梦真 on 2/20/19.
//  Copyright © 2019 mengzhenxiao. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {
    
    @IBOutlet weak var imageNameInput: UITextField!
    
    
    //Timer
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var timer: Timer!
    var isStart: Bool = false
    var recordCnt: Int = 0
    var msCnt: Int = 0
    var cMaxLabelNum: Int!
    var cButtonH: CGFloat!
    var recordArray: [UILabel]!
    
    
    // Callback method to be defined in parent view controller.
    var didSaveElement: ((_ element: Element) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func UpdateTimer() {
        msCnt += 1
        let timeStr = String(format: "%02d:%02d:%02d", msCnt/6000, (msCnt/100)%60, msCnt%100)
        self.timeLabel.text = timeStr
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        if(isStart) {
            return
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isStart = true
    }
    
    @IBAction func pauseTimer(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isStart = false
    }
    
    @IBAction func resetTimer(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isStart = false
        let timeStr = String(format: "%02d:%02d:%02d", 0, 0, 0)
        self.timeLabel.text = timeStr
    }
    
    
    
    @IBAction func handleSaveButton(_ sender: UIButton) {
        // Get current time and date.
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        // get the date time String from the date object
        formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        
        let dateString = formatter.string(from: currentDateTime)

        
        // Pass back data.
//        let element = Element(imageName: imageNameInput.text!, mealTime: mealTimeInput.text!, date: dateString)
//        didSaveElement?(element)
        
        let element = Element(imageName: imageNameInput.text!, mealTime: timeLabel.text!, date: dateString)
        didSaveElement?(element)
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when done is pressed.
        view.endEditing(true)
        return false
    }
    
    


}
