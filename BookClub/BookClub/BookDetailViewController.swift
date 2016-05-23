//
//  BookDetailViewController.swift
//  BookClub
//
//  Created by Johann Kerr on 2/28/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var url: String!
    var author: String!
    var bookTitle: String!
    var bookSubtitle: String!
    var descriptionText: String!
    var layerClient:LYRClient!
    
 
    var book:Book!
    var bookDetailView = BookDetailView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.bookDetailView.messageOwnerBtn.addTarget(self, action: "messageOwner", forControlEvents: .TouchUpInside)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadBook()
        
        self.navigationController?.navigationBarHidden = false
        
//        self.bookDetailView.bookImageView.sd_setImageWithURL(NSURL(string: self.url)!)
        
        
        
       // self.navigationitem.rightBarbuttonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "compose")
        
        
    }
    
    override func loadView() {
        super.loadView()
        view = bookDetailView
    }
    
    func loadBook(){
        if self.book != nil{
            self.bookDetailView.bookTitleLabel.text = self.book.title
            self.bookDetailView.bookDescriptionTextView.text = self.book.descriptionText
            self.bookDetailView.authorLabel.text = self.book.author
            


            if let username = self.book.user.username {
                self.bookDetailView.ownerLabel.text = username
            }
            
            self.bookDetailView.bookImageView.sd_setImageWithURL(NSURL(string: self.book.image)!)
            
        }
        
    }
    
    func messageOwner(){
        print("message Owner")
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
