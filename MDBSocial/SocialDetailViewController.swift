//
//  SocialDetailViewController.swift
//  MDBSocial
//
//  Created by Kristin Ho on 3/9/16.
//  Copyright © 2016 Kristin Ho. All rights reserved.
//

import UIKit

class SocialDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var socialsArray =  []
    var index = 0
    var goingNames: NSMutableArray = []


    @IBOutlet weak var goingTable: UITableView!

    @IBOutlet weak var socialTitle: UILabel!
    @IBOutlet weak var socialTime: UILabel!
    @IBOutlet weak var socialLocation: UILabel!
    @IBOutlet weak var socialEventDetails: UILabel!
    
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // in future 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goingTable.delegate = self
        goingTable.dataSource = self



        // Do any additional setup after loading the view.
        socialTitle.text = socialsArray[index]["socialTitle"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM d, yyyy hh:mm a"
        let date = socialsArray[index]["socialTime"] as! NSDate
        let dateString = formatter.stringFromDate(date)
        socialTime.text = "Date: " + dateString
        
        socialLocation.text = String("Location: " + (socialsArray[index]["socialLocation"] as? String)!)
        socialEventDetails.text = String("Event details: " + (socialsArray[index]["socialInformation"] as? String)!)
        let goingIds = socialsArray[index]["goingUserObjectIds"] as! NSArray
        
        
        if (goingIds.count > 0){
            
            
            let query = PFQuery(className: "_User")
            query.whereKey("objectId", containedIn: goingIds as [AnyObject])
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    if let objects = objects {
                        for object in objects {
                            
                            self.goingNames.addObject(String(object["username"]))
                            self.goingTable.reloadData()
                            print("going: " + String(object["username"]))
                            
                            
                        }
                    }
                }
            }
            
            
        }

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goingNames.count
    }
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = goingTable.dequeueReusableCellWithIdentifier("tableCell") as! TableCell
        cell.name.text = goingNames[indexPath.row] as! String
            
        return cell
    }
    
    
    
    @IBAction func goingClicked(sender: AnyObject) {
        

        let social = socialsArray[index] as! PFObject
        
        social.addUniqueObject((PFUser.currentUser()?.objectId)!, forKey: "goingUserObjectIds")
   
        social.saveInBackground()
        
        // print(socialsArray[index]["goingUserObjectIds"])
        
        goingTable.reloadData()
   
    }
   

    @IBAction func notGoingClicked(sender: AnyObject) {
        let social = socialsArray[index] as! PFObject
        social.addUniqueObject((PFUser.currentUser()?.objectId)!, forKey: "notGoingUserObjectIds")
        social.saveInBackground()
        
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
