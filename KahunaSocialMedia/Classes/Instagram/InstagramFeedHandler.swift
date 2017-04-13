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
                            if instagramFeeds.items.count > 0 {
                                instagramFeeds.data = instagramFeeds.items
                            }
                            if (instagramFeeds.meta != nil && instagramFeeds.meta.code == 200 && instagramFeeds.data.count > 0) || instagramFeeds.items.count > 0 {
                                SocialDataHandler.sharedInstance.saveAllFetchedInstagramFeedsToDB(instagramFeedArray: instagramFeeds.data as! NSMutableArray)
                            }
                            if self.instaFeedFetchDelegate != nil {
                                self.instaFeedFetchDelegate?.instagramFeedFetchSuccess!(instagramFeeds.data as! NSMutableArray)
                            }
                        }
                    } catch let Error as NSError {
                        print(Error.description)
                        self.instaFeedFetchDelegate?.instagramFeedFetchError!(error! as NSError)
                    }
                }
            })
            task.resume()
        }
    }

    func setValueToInstaFeedObject(coreDataObject: InstagramFeedDataInfo, item: IGData) {
        if let fullName = item.user.fullName {
            coreDataObject.userFullName = fullName
        }
        if let userName = item.user.username {
            coreDataObject.userName = userName
        }
        if let userID = item.user.id {
            if let myInteger = Double(userID) {
                coreDataObject.userID = myInteger
            }
        }
        if let weblink = item.link {
            coreDataObject.webLink = weblink
        }
        if let likes = item.likes.count {
            coreDataObject.likeCount = Int(likes)
        }
        if let CommentCount = item.comments.count {
            coreDataObject.commentCount = Int(CommentCount)
        }
        if let caption = item.caption, let feedText = caption.text {
            coreDataObject.feedText = feedText
        } else {
            coreDataObject.feedText = "N/A"
        }
        if let interval = item.createdTime {
            let Timeinterval: TimeInterval = Double(interval)!
            let date = NSDate(timeIntervalSince1970: Timeinterval)
            coreDataObject.createdDate = date
        }
        if let caption = item.caption, let mediaId = caption.id {
            if let myInteger = Double(mediaId) {
                coreDataObject.mediaID = myInteger
            }
        }
        if let thumbImg = item.images.thumbnail.url {
            coreDataObject.thumbnailImg = thumbImg
        }
        if let stdImg = item.images.standardResolution.url {
            coreDataObject.standardImg = stdImg
        }
    }
}
