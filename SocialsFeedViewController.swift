//
//  SocialsFeedViewController.swift
//  MDBSocial
//
//  Created by Kristin Ho on 3/9/16.
//  Copyright © 2016 Kristin Ho. All rights reserved.
//

import UIKit

class SocialsFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    
    var socialsArray = []
    var index = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let query = PFQuery(className: "Socials")
        do {
            try socialsArray = query.findObjects()
        } catch {
            print("Error")
        }
        
        collectionView.reloadData()

        
    }
    override func viewDidAppear(animated: Bool) {

        self.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return socialsArray.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        // Configure the cell
        cell.socialName.text = socialsArray[indexPath.row]["socialTitle"] as? String
        cell.socialDate.text = socialsArray[indexPath.row]["socialTime"] as? String
        
     

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        index = indexPath.row
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ToDetails", sender: indexPath)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ToDetails"){
           
            
            let vc = (segue.destinationViewController as! SocialDetailViewController)
            vc.socialsArray = socialsArray
            vc.index = index
            
        }
        
    }
    

}
