//
//  ExploreViewController.swift
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
//import SKPhoto
import SKPhotoBrowser
import SDWebImage
import Atlas
import SVProgressHUD


class ExploreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate{
   
    
    var exploreView = ExploreView()
    var books = [PFObject]()
    
    lazy var bookDetailViewController: BookDetailViewController = BookDetailViewController()
    
    
    var layerClient: LYRClient!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Explore loaded")


        
        
        
        
        
        
        exploreView.collectionView.delegate = self
        exploreView.collectionView.dataSource = self
        exploreView.searchBar.delegate = self
        
        self.exploreView.collectionView.backgroundColor = UIColor.clearColor()
        self.loadCollectionViewData()
        
                // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //No user logged in


        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.topItem!.title = "Explore"
        self.navigationController?.navigationBar.tintColor = Constants.appColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Constants.appColor]
        
        
        self.loadCollectionViewData()
        
        
        
        
        let bkTabBarController = self.tabBarController as! BKTabBarController
        self.layerClient = bkTabBarController.layerClient
    }
    

    
    override func loadView() {
        super.loadView()
        view = exploreView
    }
    


    
    func loadLocalCollectionViewData(){
        var query = PFQuery(className: "Book")
        query.fromLocalDatastore()
        var currentUser = PFUser.currentUser()
        
//        if searchBar.text != "" {
//            
//            //query.whereKey("user", equalTo:currentUser!)
//            
//            query.whereKey("searchText", containsString: searchBar.text!.lowercaseString)
//            
//        }
        query.includeKey("user")
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
                
                // reload our data into the collection view
                self.exploreView.collectionView.reloadData()
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
    }
    
    func loadCollectionViewData(){
        SVProgressHUD.show()
        var query = PFQuery(className: "Book")
        var currentUser = PFUser.currentUser()
        
        if self.exploreView.searchBar.text != "" {
            
            //query.whereKey("user", equalTo:currentUser!)
            
            query.whereKey("searchText", containsString: self.exploreView.searchBar.text!.lowercaseString)
            
        }
        query.includeKey("user")
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
                print(self.books.count)
                // reload our data into the collection view
                self.exploreView.collectionView.reloadData()
                SVProgressHUD.dismiss()
                //print(self.books)
                //print(self.books)
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
//        let title = ""
//        let author = ""
//        let description = ""
//        let imageUrl = ""
//        let subtitle = ""
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
        
        
        //let book = Book(
//        if let value = books[indexPath.row]["title"] as? String {
//            bookDetailViewController.bookTitle = value
//        }
//        if let description = books[indexPath.row]["description"] as? String{
//            bookDetailViewController.bookSubtitle = description
//        }
//        
//        
//        var initialThumbnail = UIImage(named: "icon")
//        
//        var urlString = books[indexPath.row]["imageUrl"] as? String
//        
//        bookDetailViewController.url = urlString
        dispatch_async(dispatch_get_main_queue(), {
            self.navigationController?.pushViewController(self.bookDetailViewController, animated: true)
            
        })
        //self.presentViewController(bookDetailViewController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(bookDetailViewController, animated: true)
        
        
        
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        // Dismiss the keyboard
        self.exploreView.searchBar.resignFirstResponder()
        
        // Reload of table data
        self.loadCollectionViewData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // Dismiss the keyboard
        self.exploreView.searchBar.resignFirstResponder()
        
        // Reload of table data
        self.loadCollectionViewData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        // Clear any search criteria
        self.exploreView.searchBar.text = ""
        
        // Dismiss the keyboard
        self.exploreView.searchBar.resignFirstResponder()
        
        // Reload of table data
        self.loadCollectionViewData()
    }
    


    
    


}
