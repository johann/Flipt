//
//  LoginViewController.swift
//  BookClub
//
//  Created by Johann Kerr on 3/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit
import Atlas
import Parse
import ParseUI
import SnapKit


class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {

    
    var logInViewController: PFLogInViewController!
    var layerClient: LYRClient!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = UIScreen.mainScreen().bounds
        
        // Do any additional setup after loading the view.
    }
    
    func createConstraints(){
        self.view.snp_makeConstraints{(make) -> Void in
            make.edges.equalTo(self.view)
            
        }

    }
    
    func setupUI(){
        let signupButtonBackgroundImage: UIImage = getImageWithColor(Constants.appColor, size: CGSize(width: 10.0, height: 10.0))
        
        // Create the log in view controller
        self.logInViewController = PFLogInViewController()
        
        self.logInViewController.logInView!.passwordForgottenButton!.setTitleColor(Constants.appColor, forState: UIControlState.Normal)
        self.logInViewController.logInView!.signUpButton!.setBackgroundImage(signupButtonBackgroundImage, forState: UIControlState.Normal)
        self.logInViewController.logInView!.signUpButton!.backgroundColor = ATLBlueColor()
        self.logInViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.logInViewController.fields = ([PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.SignUpButton, PFLogInFields.PasswordForgotten])
        self.logInViewController.delegate = self
        
        
        let logoImageView: UIImageView = UIImageView(image: UIImage(named:"LayerParseLogin"))
        logoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.logInViewController.logInView!.logo = logoImageView;
        
        // Create the sign up view controller
        let signUpViewController: PFSignUpViewController = PFSignUpViewController()
        signUpViewController.signUpView!.signUpButton!.setBackgroundImage(signupButtonBackgroundImage, forState: UIControlState.Normal)
        self.logInViewController.signUpController = signUpViewController
        signUpViewController.delegate = self
        let signupImageView: UIImageView = UIImageView(image: UIImage(named:"LayerParseLogin"))
        signupImageView.contentMode = UIViewContentMode.ScaleAspectFit
        signUpViewController.signUpView!.logo = signupImageView
        
        self.presentViewController(self.logInViewController,  animated: true, completion:nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK - PFLogInViewControllerDelegate
    
    // Sent to the delegate to determine whether the log in request should be submitted to the server.
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username:String, password: String) -> Bool {
        if (!username.isEmpty && !password.isEmpty) {
            return true // Begin login process
        }
        
        let title = NSLocalizedString("Missing Information", comment: "")
        let message = NSLocalizedString("Make sure you fill out all of the information!", comment: "")
        let cancelButtonTitle = NSLocalizedString("OK", comment: "")
        UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle).show()
        
        return false // Interrupt login process
    }
    
    // Sent to the delegate when a PFUser is logged in.
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        print("logging in")
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.loginLayer()
        let bkTabBarController = BKTabBarController()
        let navBarController = UINavigationController()
        
        navBarController.viewControllers = [bkTabBarController]
        self.presentViewController(navBarController, animated: true, completion: nil)
        
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        if let description = error?.localizedDescription {
            let cancelButtonTitle = NSLocalizedString("OK", comment: "")
            UIAlertView(title: description, message: nil, delegate: nil, cancelButtonTitle: cancelButtonTitle).show()
        }
        print("Failed to log in...")
    }
    
    // MARK: - PFSignUpViewControllerDelegate
    
    // Sent to the delegate to determine whether the sign up request should be submitted to the server.
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        var informationComplete: Bool = true
        
        // loop through all of the submitted data
        for (key, _) in info {
            if let field = info[key] as? String {
                if field.isEmpty {
                    informationComplete = false
                    break
                }
            }
        }
        
        // Display an alert if a field wasn't completed
        if (!informationComplete) {
            let title = NSLocalizedString("Signup Failed", comment: "")
            let message = NSLocalizedString("All fields are required", comment: "")
            let cancelButtonTitle = NSLocalizedString("OK", comment: "")
            UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle).show()
        }
        
        return informationComplete;
    }
    
    // Sent to the delegate when a PFUser is signed up.
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.loginLayer()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Failed to sign up...")
    }
    
    func loginLayer(){
        self.layerClient.connectWithCompletion { success, error in
            if (!success) {
                print("Error code \(error?.code)")
                print("Failed to connect to Layer: \(error)")
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                    let bkTabBarController = BKTabBarController()
                    let navBarController = UINavigationController()
                    var top = UIApplication.sharedApplication().keyWindow?.rootViewController
                    navBarController.viewControllers = [bkTabBarController]
                    top!.presentViewController(navBarController, animated: true, completion: nil)
                })
                
                
            } else {
                let userID: String = PFUser.currentUser()!.objectId!
                // Once connected, authenticate user.
                // Check Authenticate step for authenticateLayerWithUserID source
                
                
//                self.authenticateLayerWithUserID(userID, completion: { success, error in
//                    if (!success) {
//                        print("Failed Authenticating Layer Client with error:\(error)")
//                    } else {
//                        print("Johann -> ")
//                        print("Authenticated")
//                        dispatch_async(dispatch_get_main_queue(), {
//                            
//                            
//                            self.dismissViewControllerAnimated(true, completion: nil)
//                            let bkTabBarController = BKTabBarController()
//                            let navBarController = UINavigationController()
//                            var top = UIApplication.sharedApplication().keyWindow?.rootViewController
//                            navBarController.viewControllers = [bkTabBarController]
//                            top!.presentViewController(navBarController, animated: true, completion: nil)
//                            //self.presentViewController(navBarController, animated: true, completion: nil)
//                        })
// 
//                        //self.presentConversationListViewController()
//                    }
//                })
            }
        }
        
    }

    /*
    func authenticateLayerWithUserID(userID: NSString, completion: ((success: Bool , error: NSError!) -> Void)!) {
        // Check to see if the layerClient is already authenticated.
        if self.layerClient.authenticatedUserID != nil {
            // If the layerClient is authenticated with the requested userID, complete the authentication process.
            if self.layerClient.authenticatedUserID == userID {
                print("Layer Authenticated as User \(self.layerClient.authenticatedUserID)")
                if completion != nil {
                    completion(success: true, error: nil)
                }
                return
            } else {
                //If the authenticated userID is different, then deauthenticate the current client and re-authenticate with the new userID.
                self.layerClient.deauthenticateWithCompletion { (success: Bool, error: NSError?) in
                    if error != nil {
                        self.authenticationTokenWithUserId(userID, completion: { (success: Bool, error: NSError?) in
                            if (completion != nil) {
                                completion(success: success, error: error)
                            }
                        })
                    } else {
                        if completion != nil {
                            completion(success: true, error: error)
                        }
                    }
                }
            }
        } else {
            // If the layerClient isn't already authenticated, then authenticate.
            self.authenticationTokenWithUserId(userID, completion: { (success: Bool, error: NSError!) in
                if completion != nil {
                    completion(success: success, error: error)
                }
            })
        }
    }
    */
    
    func authenticationTokenWithUserId(userID: NSString, completion:((success: Bool, error: NSError!) -> Void)!) {
        /*
        * 1. Request an authentication Nonce from Layer
        */
        self.layerClient.requestAuthenticationNonceWithCompletion { (nonceString: String?, error: NSError?) in
            guard let nonce = nonceString else {
                if (completion != nil) {
                    completion(success: false, error: error)
                }
                return
            }
            
            if (nonce.isEmpty) {
                if (completion != nil) {
                    completion(success: false, error: error)
                }
                return
            }
            
            /*
            * 2. Acquire identity Token from Layer Identity Service
            */
            PFCloud.callFunctionInBackground("generateToken", withParameters: ["nonce": nonce, "userID": userID]) { (object:AnyObject?, error: NSError?) -> Void in
                if error == nil {
                    let identityToken = object as! String
//                    self.layerClient.authenticateWithIdentityToken(identityToken) { authenticatedUserID, error in
//                        guard let userID = authenticatedUserID else {
//                            if (completion != nil) {
//                                completion(success: false, error: error)
//                            }
//                            return
//                        }
//                        
//                        if (userID.isEmpty) {
//                            if (completion != nil) {
//                                completion(success: false, error: error)
//                            }
//                            return
//                        }
//                        
//                        if (completion != nil) {
//                            completion(success: true, error: nil)
//                        }
//                        print("Layer Authenticated as User: \(userID)")
//                    }
//                    
//                    
                    
                } else {
                    print("Parse Cloud function failed to be called to generate token with error: \(error)")
                }
            }
        }
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
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
