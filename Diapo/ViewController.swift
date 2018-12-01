//
//  ViewController.swift
//  Diapo
//
//  Created by Victorien Houry on 30/11/2018.
//  Copyright © 2018 Victorien Houry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK : Properties
    @IBOutlet weak var diapoImageView: UIImageView!
    @IBOutlet weak var numberDiapoLabel: UILabel!
    @IBOutlet weak var controlView: UIView!
    
    var userDefault:UserDefaults = UserDefaults.standard
    var _timer: Timer?
    var index = 0
    let imageArray: [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!]
    
    
    
    // MARK : Parent function
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controlView.isHidden = !self.userDefault.bool(forKey: OptionsViewController.USER_DEFAULT_SHOW_CONTROL_KEY)
        fireTimer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        killTimer()
    }

    // MARK: Action
    @IBAction func nextButtonPressed(_ sender: Any) {
        goToNext()
        fireTimer()
    }
    @IBAction func previousButtonPressed(_ sender: Any) {
        goToPrev()
        fireTimer()
    }
    
    // MARK: Local function
    
    fileprivate func goToPrev() {
        index -= 1
        if index < 0 {
            index = imageArray.count - 1
        }
        changeImage()
    }
    
    fileprivate func goToNext() {
        index += 1
        if index > imageArray.count-1 {
            index = 0
        }
        changeImage()
    }
    
    fileprivate func changeImage() {
        self.diapoImageView.image = imageArray[index]
        self.numberDiapoLabel.text = "\(index + 1)/\(imageArray.count)"
    }
    
    
    // MARK: Time function
    
    fileprivate func killTimer() {
        if let timer = _timer {
            timer.invalidate()
            _timer = nil
        }
    }
    
    fileprivate func fireTimer() {
        killTimer()
        var interval: Double = 3
        if self.userDefault.float(forKey: OptionsViewController.USER_DEFAULT_DELAY_KEY) > 0 , let _interval = Double(exactly: self.userDefault.float(forKey: OptionsViewController.USER_DEFAULT_DELAY_KEY)) {
            interval = _interval
        }
        _timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector:#selector(ViewController.timerWasFired), userInfo: nil, repeats: true)
        changeImage()
    }
    
    
    @objc func timerWasFired() {
        goToNext()
    }
}

