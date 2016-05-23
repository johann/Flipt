//
//  ProfileViewController.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit
import Haneke
import Parse
import Bolts
import ParseUI
import SDWebImage
import SVProgressHUD

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    
    var profileView = ProfileView()
    var books = [PFObject]()
    
    lazy var bookDetailViewController: BookDetailViewController = BookDetailViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
        self.profileView.collectionView.backgroundColor = UIColor.clearColor()
        self.loadCollectionViewData()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.topItem!.title = "Profile"
    }
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    func loadCollectionViewData(){
        SVProgressHUD.show()
        var query = PFQuery(className: "Book")
        var currentUser = PFUser.currentUser()
        query.whereKey("user", equalTo:currentUser!)
        
        //        if searchBar.text != "" {
        //
        //            //query.whereKey("user", equalTo:currentUser!)
        //
        //            query.whereKey("searchText", containsString: searchBar.text!.lowercaseString)
        //
        //        }
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            // The find succeeded now rocess the found objects into the countries array
            if error == nil {
                
                // Clear existing country data
                self.books.removeAll(keepCapacity: true)
                
                // Add country objects to our array
                if let objects = objects {
                    self.books = Array(objects.generate())
                }
                self.profileView.booksNumLabel.text = "\(self.books.count)"
                // reload our data into the collection view
                self.profileView.collectionView.reloadData()
                SVProgressHUD.dismiss()
                print(self.books)
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BookCell", forIndexPath: indexPath) as! BookCollectionCell
        
        if let value = books[indexPath.row]["title"] as? String {
            
        }
        
        
        var initialThumbnail = UIImage(named: "icon")
        
        var urlString = books[indexPath.row]["imageUrl"] as? String
        
        let URL = NSURL(string:urlString!)
        
        
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
            print(self)
        }
        
        //let url = NSURL(string: "http://placehold.it/350x150")
        cell.bookImageView.backgroundColor = Constants.appColor
        cell.bookImageView.sd_setImageWithURL(URL, completed: block)
        
        
        //cell.bookImageView.hnk_setImageFromURL(URL!)
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BookCell", forIndexPath: indexPath) as! BookCollectionCell
        
        let book = Book()
        if let title = books[indexPath.row]["title"] as? String{
            book.title = title
        }
        if let author = books[indexPath.row]["author"] as? String{
            book.author = author
        }
        if let descriptionText = books[indexPath.row]["description"] as? String{
            book.descriptionText = descriptionText
        }
        if let imageUrl = books[indexPath.row]["imageUrl"] as? String{
            book.image = imageUrl
        }
        if let subtitle = books[indexPath.row]["subtitle"] as? String{
            book.subtitle = subtitle
        }
        if let owner = books[indexPath.row]["user"] as? PFUser{
            book.user = owner
        }
        bookDetailViewController.book = book
        

        dispatch_async(dispatch_get_main_queue(), {
            self.navigationController?.pushViewController(self.bookDetailViewController, animated: true)
            
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
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
