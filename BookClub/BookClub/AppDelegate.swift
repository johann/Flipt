//
//  AppDelegate.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit
import LayerKit
import Parse
import Fabric
import Crashlytics
import ParseFacebookUtilsV4
import ParseTwitterUtils
import Bolts
import Atlas




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    let ParseAppIDString: String = "vcdAyMdkox1gkLg15AH43tcwfJUZ0zb5vKZ2Im1L"
    let ParseClientKeyString: String = "NR2wwBN87dSRT7t7UU3sx2yUTCkG9oD0TYXlcnax"
    let LayerAppIDString: NSURL! = NSURL(string: "layer:///apps/staging/19fdba16-aea5-11e5-8f20-999c060029bf")
    
    var layerClient: LYRClient!
    lazy var navBarController: UINavigationController! = UINavigationController()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        PFTwitterUtils.initializeWithConsumerKey("bxP5lKQMJmiGel01BnT2bE34T",  consumerSecret:"ViXuCzdD6tnT0QNzq5oROxzWEs4bqnS15uhUGwYK2o0dQhPDjE")
        
        Fabric.with([Crashlytics.self])
        
        let navBarController = UINavigationController()
        //navBarController.navigationBar.barTintColor = UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.0)
        
        setupLayer()
        setupParse()
        print( "print\(self.layerClient)")
        
        
        if (PFUser.currentUser() != nil) {
            //self.loginLayer()
            
            
        }else{
            let loginViewController = LoginViewController()
            loginViewController.layerClient = self.layerClient
            self.navBarController.viewControllers = [loginViewController]
        }
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        
        self.navBarController.view.backgroundColor = UIColor.whiteColor()
        window!.makeKeyAndVisible()
        window!.rootViewController = self.navBarController
        
        
        
        
        
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setupParse(){
        Parse.enableLocalDatastore()
        Parse.setApplicationId(ParseAppIDString, clientKey: ParseClientKeyString)
        
        
        
        // Set default ACLs
        let defaultACL: PFACL = PFACL()
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
    }
    func setupLayer() {
        layerClient = LYRClient(appID: LayerAppIDString)
        
        layerClient.autodownloadMIMETypes = NSSet(objects: ATLMIMETypeImagePNG, ATLMIMETypeImageJPEG, ATLMIMETypeImageJPEGPreview, ATLMIMETypeImageGIF, ATLMIMETypeImageGIFPreview, ATLMIMETypeLocation) as? Set<String>
    }
    

    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func presentTabBar(){
        
        let tabBarController = BKTabBarController()
        tabBarController.layerClient = self.layerClient
        self.navBarController.viewControllers = [tabBarController]
    }
    
    func loginLayer(){
        self.layerClient.connectWithCompletion { success, error in
            if (!success) {
                print("Failed to connect to Layer: \(error)")
            } else {
                let userID: String = PFUser.currentUser()!.objectId!
                // Once connected, authenticate user.
                // Check Authenticate step for authenticateLayerWithUserID source
                
                /*
                self.authenticateLayerWithUserID(userID, completion: { success, error in
                    if (!success) {
                        print("Failed Authenticating Layer Client with error:\(error)")
                    } else {
                        
                        self.presentTabBar()
                        //self.presentConversationListViewController()
                    }
                })
 
                */
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
                    self.layerClient.authenticateWithIdentityToken(identityToken) { authenticatedUserID, error in
                        guard let userID = authenticatedUserID else {
                            if (completion != nil) {
                                completion(success: false, error: error)
                            }
                            return
                        }
                        
                        if (userID.isEmpty) {
                            if (completion != nil) {
                                completion(success: false, error: error)
                            }
                            return
                        }
                        
                        if (completion != nil) {
                            completion(success: true, error: nil)
                        }
                        print("Layer Authenticated as User: \(userID)")
                    }
                } else {
                    print("Parse Cloud function failed to be called to generate token with error: \(error)")
                }
            }
        }
    }

    
    
*/
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    func connectToLayer(userId: String?, completionHandler: (success:Bool, layerClient:LYRClient?, error:NSError?) -> Void) {
        
        
        if userId == nil {
            print("Error Can't connect to Layer with a user id \(userId)")
            return
        }
        
        // Layer Identity Token Authentication
        
        if self.layerClient == nil {
            //let appID = NSURL(string: Constants.LQSLayerAppIDString)
            self.layerClient = LYRClient(appID: LayerAppIDString)
            //self.layerClient.delegate = self
            layerClient.autodownloadMIMETypes = NSSet(objects: ATLMIMETypeImagePNG, ATLMIMETypeImageJPEG, ATLMIMETypeImageJPEGPreview, ATLMIMETypeImageGIF, ATLMIMETypeImageGIFPreview, ATLMIMETypeLocation) as? Set<String>
        }
        
        // Connect to Layer
        self.layerClient.connectWithCompletion { (success, error) -> Void in
            
            if error != nil {
                completionHandler(success: false, layerClient: self.layerClient, error: error)
                return
            }else {
                // Request an authentication Nonce from Layer
                self.layerClient.requestAuthenticationNonceWithCompletion {
                    (nonce, error) -> Void in
                    
                    // NB: If user is already authorized the nouce will be nil and throw and exception
                    if (nonce == nil) {
                        print("error is: \(error)")
                        print("nonce is: \(nonce)")
                        if let err = error {
                            
                            switch (err.code){
                            case 7005: // 7005
                                completionHandler(success: true, layerClient: self.layerClient, error: nil)
                                break
                            case 6002: // Network Error
                                completionHandler(success: false, layerClient: nil, error: error)
                                break
                            default:
                                break
                            }
                        }
                        return
                    }
                    
                    if let userIdExist = userId {
                        
                        // Returns a string object specifying the user ID of the currently authenticated user or `nil` if the client is not authenticated.
                        // A client is considered authenticated if it has previously established identity via the submission of an identity token
                        // and the token has not yet expired. The Layer server may at any time issue an authentication challenge and deauthenticate the client
                        let authenticatedUserID = self.layerClient.authenticatedUserID
                        
                        // Authenticate the Client
//                        if authenticatedUserID == nil {
//                            
//                            // If successful gets back an Identity Token
//                            
//                            self.layerClient.authenticateWithIdentityToken(identityToken!, completion: {
//                                (authenticatedUserID, error) -> Void in
//                                if error != nil {
//                                    print("Layer user NOT Authenticated", terminator: "")
//                                    completionHandler(success: false, layerClient: nil, error: error)
//                                } else {
//                                    print("Layer Authenticated as User: \(authenticatedUserID)", terminator: "")
//                                    
//                                    
//                                    // Register LetterMe to recieve Layer Remote Notifications
//                                    if UIApplication.sharedApplication().respondsToSelector("registerForRemoteNotifications") {
//                                        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
//                                        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
//                                        UIApplication.sharedApplication().registerForRemoteNotifications()
//                                    }
//                                    
//                                    completionHandler(success: true, layerClient: self.layerClient, error: nil)
//                                }
//                            })
//
//                            
////                            
////                            LMAuthService.layerAuthentication(userIdExist, nonce: nonce!, completionHandler: {
////                                (success, identityToken, error) -> Void in
////                                
////                                if error != nil {
////                                    print("Error getting Identity Token: \(error)")
////                                    return
////                                }
////                                
////                                if success {
////                                    self.layerClient.authenticateWithIdentityToken(identityToken!, completion: {
////                                        (authenticatedUserID, error) -> Void in
////                                        if error != nil {
////                                            print("Layer user NOT Authenticated", terminator: "")
////                                            completionHandler(success: false, layerClient: nil, error: error)
////                                        } else {
////                                            print("Layer Authenticated as User: \(authenticatedUserID)", terminator: "")
////                                            
////                                            
////                                            // Register LetterMe to recieve Layer Remote Notifications
////                                            if UIApplication.sharedApplication().respondsToSelector("registerForRemoteNotifications") {
////                                                let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
////                                                UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
////                                                UIApplication.sharedApplication().registerForRemoteNotifications()
////                                            }
////                                            
////                                            completionHandler(success: true, layerClient: self.layerClient, error: nil)
////                                        }
////                                    })
////                                } else {
////                                    print("NOT able to get an Identity Token", terminator: "")
////                                }
////                            })
//                        } else {
//                            print("Client Already Authenticated")
//                        }
                    } else {
                        print("No user id FOUND to create Identity Token", terminator: "")
                    }
                }
            }
        }
    }
    

    */



}

