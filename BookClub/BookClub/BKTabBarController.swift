//
//  BKTabBarController.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit
import Atlas
import Parse
import ParseUI

class BKTabBarController: UITabBarController {
    
    lazy var exploreViewController: ExploreViewController = ExploreViewController()
    //lazy var scanViewController: ScanViewController = ScanViewController()
    lazy var scannerViewController: ScannerViewController = ScannerViewController()
    lazy var profileViewController: ProfileViewController = ProfileViewController()
    lazy var messageViewController: MessageViewController = MessageViewController()
    
    var msgViewController: UIViewController!
    lazy var moreViewController: MoreViewController = MoreViewController()
    
    //lazy var loginViewController: LoginViewController = LoginViewController()
    
    
    
    
    var layerClient: LYRClient!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.view.backgroundColor = Constants.backgroundColor
        self.view.tintColor = Constants.appColor
        print("self.layerClient -> \(self.layerClient)")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        
        print("appDelegate - \(appDelegate.layerClient)")
        //self.msgViewController = ConversationListViewController(layerClient: appDelegate.layerClient)
        
        //self.msgViewController.displaysAvatarItem = true
        
        viewControllers = [exploreViewController, scannerViewController, profileViewController,moreViewController]
        
        viewControllers![0].tabBarItem.title = "Explore"
        viewControllers![0].tabBarItem.image = UIImage(named: "explore")
        
        viewControllers![1].tabBarItem.title = "Scan"
        viewControllers![1].tabBarItem.image = UIImage(named: "scan")
        
        viewControllers![2].tabBarItem.title = "Profile"
        viewControllers![2].tabBarItem.image = UIImage(named: "profile")
        
        viewControllers![3].tabBarItem.title = "Message"
        viewControllers![3].tabBarItem.image = UIImage(named: "messages")
        
        viewControllers![4].tabBarItem.title = "More"
        viewControllers![4].tabBarItem.image = UIImage(named: "more")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        
        
    
     //End
    }
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
        
        
        
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

}
