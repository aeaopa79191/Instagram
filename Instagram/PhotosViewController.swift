//
//  PhotosViewController.swift
//  Instagram
//
//  Created by KaKin Chiu on 1/21/16.
//  Copyright © 2016 KaKinChiu. All rights reserved.
//

import UIKit
import AFNetworking

//UITableViewDataSource, UITableViewDelegate

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var media: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)

        
        tableView.dataSource = self
        tableView.delegate = self
     

        // Do any additional setup after loading the view.
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.media = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                             self.tableView.insertSubview(refreshControl, atIndex: 0)
                    }
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let media = media{
            return media.count
        }else{
            return 0
    }
    }
    
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
            let element = media![indexPath.row]

            let path = element.valueForKeyPath("images.low_resolution.url") as! String
            let imageUrl = NSURL(string: path)
            
            cell.photo.setImageWithURL(imageUrl!)

            print("row \(indexPath.row)")
            return cell
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl){
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

            var vc = segue.destinationViewController as! PhotoDetailsViewController
            
            var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
    }
    

}
