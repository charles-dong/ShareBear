//
//  SignUpVC.swift
//  ShareBear
//
//  Created by Charles Dong on 1/18/15.
//  Copyright (c) 2015 Charles Dong. All rights reserved.
//

import Foundation

class SignUpVC: UIViewController, FBLoginViewDelegate {
    
    // MARK: - UI Elements & Actions
    
    // Facebook - Login Button
    @IBOutlet weak var fbLoginView: FBLoginView!
    
    
    
    
    
    
    // MARK: - UIViewController SuperClass
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Facebook
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Facebook Delegate Methods
    
    // Facebook - fetched user info
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        println("User First Name: \(user.first_name)")
        println("User Last Name: \(user.last_name)")
    }
    
    // Facebook - notification that user logged in
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
    }
    
    // Facebook - notification that user logged out
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    // Facebook - error handling
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
        
        // vars to store potential alerts in
        var alertTitle: String?
        var alertMessage: String?
        
        // If the user should perform an action outside of you app to recover,
        // the SDK will provide a message for the user, you just need to surface it.
        // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
        if FBErrorUtility.shouldNotifyUserForError(handleError) {
            alertTitle = "Facebook error";
            alertMessage = FBErrorUtility.userMessageForError(handleError)
            
            // This code will handle session closures that happen outside of the app
            // You can take a look at our error handling guide to know more about it
            // https://developers.facebook.com/docs/ios/errors
        } else if FBErrorUtility.errorCategoryForError(handleError) == FBErrorCategory.AuthenticationReopenSession {
            alertTitle = "Session Error"
            alertMessage = "Your current session is no longer valid. Please log in again."
            
            // If the user has cancelled a login, we will do nothing.
            // You can also choose to show the user a message if cancelling login will result in
            // the user not being able to complete a task they had initiated in your app
            // (like accessing FB-stored information or posting to Facebook)
        } else if FBErrorUtility.errorCategoryForError(handleError) == FBErrorCategory.UserCancelled {
            println("User cancelled login")
            
            // For simplicity, this sample handles other errors with a generic message
            // You can checkout our error handling guide for more detailed information
            // https://developers.facebook.com/docs/ios/errors
        } else {
            alertTitle  = "Oh no! Something went wrong"
            alertMessage = "Please try again later!"
            println("Unexpected error: \(handleError.localizedDescription)")
        }
        
        if let title = alertTitle {
            var alert = UIAlertController(title: title, message: alertMessage!, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
}