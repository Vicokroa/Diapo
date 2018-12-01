//
//  OptionsViewController.swift
//  Diapo
//
//  Created by Victorien Houry on 01/12/2018.
//  Copyright © 2018 Victorien Houry. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    @IBOutlet weak var showControlsSwitch: UISwitch!
    @IBOutlet weak var delaySlider: UISlider!
    @IBOutlet weak var delayLabel: UILabel!
    static let USER_DEFAULT_SHOW_CONTROL_KEY:String = "showControl"
    static let USER_DEFAULT_DELAY_KEY:String = "delay"
    
    var userDefault:UserDefaults = UserDefaults.standard
    
    fileprivate func loadValuesFromUserDefaults() {
        self.delaySlider.setValue(userDefault.float(forKey: USER_DEFAULT_DELAY_KEY), animated: false)
        self.showControlsSwitch.isOn = self.userDefault.bool(forKey: USER_DEFAULT_SHOW_CONTROL_KEY)
    }


    fileprivate func saveValuesToUserDefaults() {
        self.userDefault.set(self.delaySlider.value, forKey: USER_DEFAULT_DELAY_KEY)
        self.userDefault.set(self.showControlsSwitch.isOn, forKey: USER_DEFAULT_SHOW_CONTROL_KEY)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadValuesFromUserDefaults()
        self.changeDelayLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func changeDelayLabel() {
        self.delayLabel.text = "Durée : \(self.delaySlider.value) s"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.saveValuesToUserDefaults()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func closeButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func delaySliderValueChange(_ sender: Any) {
        self.changeDelayLabel()
    }
}
