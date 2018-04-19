//
//  InstagramFeedHandler.swift
//  MyCity311
//
//  Created by Nehru on 3/17/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

import UIKit

@objc protocol InstagramFeedDelegate: class {
    @objc optional func instagramFeedFetchSuccess(_ feedArray: NSArray?)
    @objc optional func instagramFeedFetchError(_ errorType: NSError)
}

class InstagramFeedHandler: NSObject {

    static let sharedInstance = InstagramFeedHandler()
    weak var instaFeedFetchDelegate: InstagramFeedDelegate?

    override init() {
    }

    deinit {
        print("** InstagramFeedHandler deinit called **")
    }

    func getInstaFeedsFromURL(stringURL: String?) {
        if stringURL != nil {
            let paramString = stringURL!
            let loadURL = NSURL(string: paramString)
            let request = NSURLRequest(url: loadURL! as URL)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if error != nil {
                    if self.instaFeedFetchDelegate != nil {
                        self.instaFeedFetchDelegate?.instagramFeedFetchError!(error! as NSError)
                    }
                } else if data != nil {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                        DispatchQueue.main.async {
                            let instagramFeeds = IGMain(fromDictionary: jsonObject as! NSDictionary)
                            if instagramFeeds.user != nil && instagramFeeds.user.media != nil && instagramFeeds.user.media.nodes.count > 0 && self.instaFeedFetchDelegate != nil {
                                SocialOperationHandler.sharedInstance.socialDBStore.saveAllFetchedInstagramFeedsToDB(instagramFeedArray: instagramFeeds.user.media.nodes! as NSArray, userData: instagramFeeds.user)
                                self.instaFeedFetchDelegate?.instagramFeedFetchSuccess!(instagramFeeds.user.media.nodes as NSArray?)
                            }
                        }
                    } catch let Error as NSError {
                        print(Error.description)
                        self.instaFeedFetchDelegate?.instagramFeedFetchError!(Error)
                    }
                }
            })
            task.resume()
        }
    }

    func setValueToInstaFeedObject(item: IGNode, userData: IGUser) -> InstagramFeedDataInfo {
        let coreDataObject = InstagramFeedDataInfo()
        if let fullName = userData.fullName {
            coreDataObject.userFullName = fullName
        }
        if let userName = userData.username {
            coreDataObject.userName = userName
        }
        if let userID = userData.id {
            coreDataObject.userID = userID
        }
        if let weblink = item.code, coreDataObject.userName.count > 0 {
            coreDataObject.webLink = "https://www.instagram.com/p/\(weblink)/?taken-by=\(coreDataObject.userName)"
        }
        if let likes = item.likes.count {
            coreDataObject.likeCount = String(likes)
        }
        if let CommentCount = item.comments.count {
            coreDataObject.commentCount = String(CommentCount)
        }
        if let caption = item.caption {
            coreDataObject.feedText = caption
        } else {
            coreDataObject.feedText = "N/A"
        }
        if let interval = item.date {
            let Timeinterval: TimeInterval = Double(interval)
            let date = NSDate(timeIntervalSince1970: Timeinterval)
            coreDataObject.createdDate = date
        }
        if let thumbImg = item.thumbnailSrc {
            coreDataObject.thumbnailImg = thumbImg
        }
        if let stdImg = item.displaySrc {
            coreDataObject.standardImg = stdImg
        }
        return coreDataObject
    }

}
