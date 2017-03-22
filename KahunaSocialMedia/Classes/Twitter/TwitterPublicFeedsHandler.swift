//
//  TwitterPublicFeedsHandler.swift
//  MyCity311
//
//  Created by Piyush on 6/13/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit
import KahunaSocialMedia

@objc protocol TwitterFeedDelegate: class {
    @objc optional func twitterFeedFetchSuccess(_ feedArray: NSArray?)
    @objc optional func twitterFeedFetchError(_ errorType: NSError?)
}

class TwitterPublicFeedsHandler: NSObject {

    var tweetAccessToken: String!
    var tweetSecretKey: String!
    var tweetConsumerKey: String!
    var tweetConsumerSecret: String!
    var tweetOwnerSecretName: String!
    var tweetSlugName: String!
    var engine: FHSTwitterEngine!
    weak var twitterDelegate: TwitterFeedDelegate!
    static let sharedInstance = TwitterPublicFeedsHandler()

    override init() {
    }

    deinit {
        print("** TwitterPublicFeedsHandler deinit called **")
    }

    func getTwitterFeedListFromURL(_ stringURL: String) {
        autoreleasepool() {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                let basePath = SocialOperationHandler.sharedInstance.serverBaseURL
                let paramString = basePath + stringURL
                let loadURL = URL(string: paramString)
                let request = URLRequest(url: loadURL!)
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    if error != nil {
                        if self.twitterDelegate != nil {
                            self.twitterDelegate?.twitterFeedFetchError!(error! as NSError?)
                        }
                    } else if data != nil {
                        let parserArray = NSMutableArray()
                        let jsonParser = TwitterJSONParser()
                        var tweetsArray = NSMutableArray()
                        DispatchQueue.main.async {
                            tweetsArray = jsonParser.parseTwitterFeedData(data!, parserArray: parserArray) as NSMutableArray
                            if tweetsArray.count > 0 {
                                SocialDataHandler.sharedInstance.saveAllFetchedTwitterFeedsToDB(twitterFeedArray: tweetsArray)
                            }
                            if self.twitterDelegate != nil {
                                self.twitterDelegate.twitterFeedFetchSuccess!(tweetsArray)
                            }
                        }
                    }
                })
                task.resume()
            }
        }
    }

    func getLatestTweetsFromServerWithURLString(_ stringURL: String) {
        autoreleasepool() {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                // AccessToken
                self.tweetAccessToken = SocialOperationHandler.sharedInstance.tweetAccessToken
                // AccessToken Secret
                self.tweetSecretKey = SocialOperationHandler.sharedInstance.tweetSecretKey
                // TweetConsumerKey
                self.tweetConsumerKey = SocialOperationHandler.sharedInstance.tweetConsumerKey
                // ConsumerKeySecret
                self.tweetConsumerSecret = SocialOperationHandler.sharedInstance.tweetConsumerSecret
                // OwnerSecret
                self.tweetOwnerSecretName = SocialOperationHandler.sharedInstance.tweetOwnerSecretName
                // SlugName
                self.tweetSlugName = SocialOperationHandler.sharedInstance.tweetSlugName
                self.engine = FHSTwitterEngine.shared()
                self.engine.permanentlySetConsumerKey(self.tweetConsumerKey, andSecret: self.tweetConsumerSecret)
                let token = FHSToken()
                token.key = self.tweetAccessToken
                token.secret = self.tweetSecretKey
                self.engine.accessToken = token
                var tweetsArray = NSMutableArray()
                var isNoError = false
                if let tweets = self.engine.getTimelineForList(withID: self.tweetSlugName, self.tweetOwnerSecretName, count: 30, tweetURL: stringURL) as? NSArray {
                    isNoError = true
                    let jsonParser = TwitterJSONParser()
                    DispatchQueue.main.async {
                        tweetsArray = jsonParser.parseTwitterData(tweets as? NSArray)
                        if self.twitterDelegate != nil {
                            self.twitterDelegate.twitterFeedFetchSuccess!(tweetsArray)
                        }
                    }
                }
                if !isNoError {
                    DispatchQueue.main.async {
                        if self.twitterDelegate != nil {
                            self.twitterDelegate.twitterFeedFetchError!(nil)
                        }
                    }
                }
            }
        }
    }

}
