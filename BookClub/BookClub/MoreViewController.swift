//
//  MoreViewController.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit
import Former
import SVProgressHUD
import Parse

class MoreViewController: FormViewController {
    
    var layerClient: LYRClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationItem.title = "More"
        // Do any additional setup after loading the view.
    }
    
    func configure(){
        let createMenu: ((String, (() -> Void)?) -> RowFormer) = { text, onSelected in
            return LabelRowFormer<FormLabelCell>() {
                $0.titleLabel.textColor = UIColor.blackColor()
                $0.titleLabel.font = .boldSystemFontOfSize(16)
                $0.accessoryType = .DisclosureIndicator
                }.configure {
                    $0.text = text
                }.onSelected { _ in
                    onSelected?()
            }
        }
        let createLogoutMenu: ((String, (() -> Void)?) -> RowFormer) = { text, onSelected in
            return LabelRowFormer<FormLabelCell>() {
                $0.titleLabel.textColor = UIColor.blackColor()
                $0.titleLabel.textAlignment = .Center
                $0.titleLabel.font = .boldSystemFontOfSize(16)
                }.configure {
                    $0.text = text
                }.onSelected { _ in
                    onSelected?()
            }
        }
        let settingsRow = createMenu("Settings") { [weak self] in
            print("Settings")
        }
        let aboutRow = createMenu("About") { [weak self] in
            print("About")
        }
        let helpRow = createMenu("Help") { [weak self] in
            print("Help")
            
        }
        
        let logoutRow = createLogoutMenu("Logout") { [weak self] in
            SVProgressHUD.show()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self?.layerClient = appDelegate.layerClient
            self!.layerClient.deauthenticateWithCompletion { (success: Bool, error: NSError?) in
                if error == nil {
                    
                
                    PFUser.logOut()
                    dispatch_async(dispatch_get_main_queue(), {
                        let navBarController = UINavigationController()
                        let loginViewController = LoginViewController()
                        loginViewController.layerClient = self!.layerClient
                        
                        var top = UIApplication.sharedApplication().keyWindow?.rootViewController
                        navBarController.viewControllers = [loginViewController]
                        top!.presentViewController(navBarController, animated: true, completion: nil)
                        SVProgressHUD.dismiss()
                        //self.presentViewController(navBarController, animated: true, completion: nil)
                    })
                    
                    
                    
                } else {
                    print("Failed to deauthenticate: \(error)")
                }
            }
        }
            
        
            
            
    
        let createHeader: (String -> ViewFormer) = { text in
            return LabelViewFormer<FormLabelHeaderView>()
                .configure {
                    $0.text = text
                    $0.viewHeight = 40
            }
        }
        
        let createFooter: (String -> ViewFormer) = { text in
            return LabelViewFormer<FormLabelFooterView>()
                .configure {
                    $0.text = text
                    $0.viewHeight = 250
            }
        }
        
        let topSection = SectionFormer(rowFormer: settingsRow, aboutRow, helpRow)
            .set(headerViewFormer: createHeader(""))
            .set(footerViewFormer: createFooter(""))
        
        let bottomSection = SectionFormer(rowFormer: logoutRow)
            //.set(headerViewFormer: createHeader(""))
           // .set(footerViewFormer: createFooter(""))
        
//        let defaultSection = SectionFormer(rowFormer: settingsRow)
//            .set(headerViewFormer: createHeader("Default UI"))
//            .set(footerViewFormer: createFooter("Former is a fully customizable Swift2 library for easy creating UITableView based form.\n\nMIT License (MIT)"))
        
        former.append(sectionFormer: topSection, bottomSection)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationItem.title = "More"
        self.navigationController?.navigationBar.topItem?.title = "More"
        self.title = "More"
        self.navigationItem.setRightBarButtonItem(nil, animated: false)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
        
        former.deselect(true)
        
        
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
