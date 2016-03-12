//
//  NewSocialViewController.swift
//  MDBSocial
//
//  Created by Kristin Ho on 3/9/16.
//  Copyright © 2016 Kristin Ho. All rights reserved.
//

import UIKit

class NewSocialViewController: UIViewController {
        
    @IBOutlet weak var fromDate: UITextField!
    
    @IBOutlet weak var socialName: UITextField!
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var additionalInfo: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelNewSocial(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postSocial(sender: AnyObject) {
        
        // extract NSDate
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM d, yyyy hh:mm a"
        let from = formatter.dateFromString(fromDate.text!)
        
        // make social object
        let social = PFObject(className:"Socials")
        social["socialTime"] = from
        social["socialTitle"] = socialName.text!
        social["socialLocation"] = location.text!
        social["socialInformation"] = additionalInfo.text!
        social["goingUserObjectIds"] = []
        social["notGoingUserObjectIds"] = []
        
        
        
        social.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                // incorrect fields
            }
        }
    }
    
   
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */


}
