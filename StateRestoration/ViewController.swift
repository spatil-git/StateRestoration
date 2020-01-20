//
//  ViewController.swift
//  StateRestoration
//
//  Created by Sanjay Patil on 1/18/20.
//  Copyright © 2020 Sanjay Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model:String? {
        didSet {
            updateView()
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateView()
    }
    // Used to construct an NSUserActivity instance for state restoration.
    var vcUserActivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: ViewController.activityType)
        userActivity.title = "Restore Item"
        applyUserActivityEntries(userActivity)
        return userActivity
    }
    
    func updateView() -> Void {
        if (self.textView != nil) {
            self.textView.text = model
        }
    }
    
    class var activityType: String {
        let activityType = ""
        
        // Load our activity type from our Info.plist.
        if let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] {
            if let activityArray = activityTypes as? [String] {
                return activityArray[0]
            }
        }
        return activityType
    }
    
    @objc override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        if textView.isFirstResponder {
            coder.encode(textView.text, forKey: "VCState")
        }
    }

    @objc override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let editedText = coder.decodeObject(forKey: "VCState") as? String {
            textView.text = editedText
        }
    }
    override func applicationFinishedRestoringState() {
        print("Finished resoring the state....")
    }
}

// MARK: User activity magic!!
extension ViewController {
    override func updateUserActivityState(_ activity: NSUserActivity) {
        super.updateUserActivityState(activity)
        applyUserActivityEntries(activity)
    }
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        super.restoreUserActivityState(activity)
        if let activityUserInfo = activity.userInfo {
            self.model = (activityUserInfo["VCState"] as? String)!
        }
    }
    func applyUserActivityEntries(_ activity:NSUserActivity) {
        activity.addUserInfoEntries(from: ["VCState":textView.text!])
    }
}

extension ViewController {
    // Used by our scene delegate to return an instance of this class from our storyboard.
       static func loadFromStoryboard() -> ViewController? {
           let storyboard = UIStoryboard(name: "Main", bundle: .main)
           return storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
       }
}

