//
//  FacebookPublicFeedsHandler.swift
//  MyCity311
//
//  Created by Piyush on 6/9/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit

@objc protocol FacebookFeedDelegate: class {
    @objc optional func facebookFeedFetchSuccess(_ feedArray: NSArray?)
    @objc optional func facebookFeedFetchError(_ errorType: NSError)
}

class FacebookPublicFeedsHandler: NSObject {

    static let sharedInstance = FacebookPublicFeedsHandler()
    weak var fBFeedFetchDelegate: FacebookFeedDelegate!
    let userDefault = NSUserDefaults.standardUserDefaults()

    override init() {
    }

    deinit {
        print("** FacebookPublicFeedsHandler deinit called **")
    }

    func getFacebookFeedListFromURL(stringURL: String) {
        autoreleasepool() {
            let basePath = SocialOperationHandler.sharedInstance.serverBaseURL
            let paramString = basePath + stringURL
            let loadURL = NSURL(string: paramString)
            let request = NSURLRequest(URL: loadURL!)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                if error != nil && self.fBFeedFetchDelegate != nil {
                    self.fBFeedFetchDelegate.facebookFeedFetchError!(error! as NSError)
                } else if data != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        let parcer = FacebookFeedsJsonParser()
                        let parsedArray = parcer.parseData(data! as NSData)
                        if parsedArray != nil && (parsedArray?.count)! > 0 {
                            SocialDataHandler.sharedInstance.saveAllFetchedFacebookFeedsToDB(parsedArray as! NSMutableArray)
                        }
                        if self.fBFeedFetchDelegate != nil {
                            self.fBFeedFetchDelegate.facebookFeedFetchSuccess!(parsedArray)
                        }
                    }
                }
            })
            task.resume()
        }
    }

    func getPublicFeedsFromUserName(fbUrl: String) -> NSArray? {
        autoreleasepool() {
            var paramFBUrl = fbUrl as NSString
            paramFBUrl = paramFBUrl.stringByReplacingOccurrencesOfString(" ", withString: "+")
            paramFBUrl = paramFBUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            var appID = SocialOperationHandler.sharedInstance.fbAppID
            var appSecret = SocialOperationHandler.sharedInstance.fbAppSecret
            var accessToken = ""
            let accessDataURLString = String(format: Constants.kFacebookURL, appID, appSecret)
            let loadURL = NSURL(string: accessDataURLString)
            let request = NSURLRequest(URL: loadURL!)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                if error != nil && self.fBFeedFetchDelegate != nil {
                    self.fBFeedFetchDelegate?.facebookFeedFetchError!(error! as NSError)
                } else if data != nil {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        if let jsonDictionary = json as? NSDictionary, let tempToken = jsonDictionary["access_token"] as? String {
                            accessToken = tempToken
                        } else {
                            if let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                                var seperateArray = jsonString.componentsSeparatedByString("=")
                                if seperateArray.count > 1 {
                                    accessToken = seperateArray[1]
                                }
                            }
                        }
                    } catch let error as NSError {
                        print(error.debugDescription)
                    }
                    self.loadFacebookFeedsWithAccessToken(accessToken, facebookURL: paramFBUrl as String)
                }
            })
            task.resume()
        }
        return nil
    }

    func loadFacebookFeedsWithAccessToken(accessToken: String, facebookURL: String) {
        let accessDataURLString = String(format: facebookURL, accessToken) as NSString
        var paramFBUrl = accessDataURLString.stringByReplacingOccurrencesOfString(" ", withString: "+")
        paramFBUrl = paramFBUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let loadURL = NSURL(string: paramFBUrl as String)
        let request = NSURLRequest(URL: loadURL!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            if error != nil && self.fBFeedFetchDelegate != nil {
                self.fBFeedFetchDelegate?.facebookFeedFetchError!(error! as NSError)
            } else if data != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    let parcer = FacebookFeedsJsonParser()
                    let parsedArray = parcer.parseData(data! as NSData)
                    if parsedArray != nil && (parsedArray?.count)! > 0 {
                        SocialDataHandler.sharedInstance.saveAllFetchedFacebookFeedsToDB(parsedArray as! NSMutableArray)
                    }
                    if self.fBFeedFetchDelegate != nil {
                        self.fBFeedFetchDelegate?.facebookFeedFetchSuccess!(parsedArray)
                    }
                }
            }
        })
        task.resume()
    }

}
