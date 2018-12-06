//
//  LogoutViewController.swift
//  Instagram
//
//  Created by Trustin Harris on 2/24/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var PicsTableView: UITableView!
    
    
    var posts: [PFObject] = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PicsTableView.delegate = self
        PicsTableView.dataSource = self
        
        ActivityIndicator.hidesWhenStopped = true
        ActivityIndicator.startAnimating()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        PicsTableView.insertSubview(refreshControl, at: 0)
        
        refresh()
        

    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        refresh()
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        
        // Logout the current user
        PFUser.logOutInBackground(block: { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.dismiss(animated: true, completion: nil)
                print("Successful loggout")
            }
        })

    }
    
    @IBAction func PostPicture(_ sender: Any) {
    }
    
    func refresh() {
        
        let query = PFQuery(className: "Post")
        
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
                self.PicsTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.PicsTableView.reloadData()
        self.ActivityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
        
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PicsTableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoTableViewCell
        let post = self.posts[indexPath.row]
        cell.IGPost = post
        return cell
    }

}
