//
//  SocialOperationHandler.swift
//  MyCity311
//
//  Created by Piyush on 6/14/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit
import KahunaSocialMedia

@objc public protocol SocialOperationHandlerDelegate: class {
    @objc optional func socialDataFetchSuccess()
    @objc optional func socialDataFetchError()
}


public class SocialOperationHandler: NSObject, YouTubeFeedDelegate, FacebookFeedDelegate, TwitterFeedDelegate {

    public var socialDelegate: SocialOperationHandlerDelegate?

    var isFBLoadIsInProcess = false
    var isTwitterLoadIsInProcess = false
    var isYoutubeLoadIsInProcess = false

    var isFacebookFirstTime = false
    var isTwitterFirstTime = false
    var isYouTubeFirstTime = false
    var isLoadFromServer = false

    var fbGraphURL = String()
    var fbFromName = String()
    var fbAppSecret = String()
    var fbAppID = String()

    var twitterURL = String()
    var serverBaseURL = String()
    var tweetAccessToken = String()
    var tweetSecretKey = String()
    var tweetConsumerKey = String()
    var tweetConsumerSecret = String()
    var tweetOwnerSecretName = String()
    var tweetSlugName = String()

    var youTubeAPIKey = String()
    var youTubeUser = String()
    var videosCountForSubscriptionChannel = String()
    var isLoadFromSubscriptions: String!
    var youTubeURL = String()
    var countForSubscribedChannel = String()
    var userChannelOnly = false
    var userChannelId = String()

    public static let sharedInstance = SocialOperationHandler()

    override init() {
    }

    public func initServerBaseURL(serverBaseURL: String) {
        self.serverBaseURL = serverBaseURL
    }

    public func initAllTwitterKeys(twitterURL: String, tweetAccessToken: String, tweetSecretKey: String, tweetConsumerKey: String, tweetConsumerSecret: String, tweetOwnerSecretName: String, tweetSlugName: String) {
        self.twitterURL = twitterURL
        self.tweetAccessToken = tweetAccessToken
        self.tweetSecretKey = tweetSecretKey
        self.tweetConsumerKey = tweetConsumerKey
        self.tweetConsumerSecret = tweetConsumerSecret
        self.tweetOwnerSecretName = tweetOwnerSecretName
        self.tweetSlugName = tweetSlugName
    }

    public func initAllFacebookKeys(fbGraphURL: String, fbFromName: String, fbAppSecret: String, fbAppID: String) {
        self.fbGraphURL = fbGraphURL
        self.fbFromName = fbFromName
        self.fbAppSecret = fbAppSecret
        self.fbAppID = fbAppID
    }

    public func initAllYoutubeKeys(youTubeURL: String, youTubeAPIKey: String, youTubeUser: String, videosCountForSubscriptionChannel: String, countForSubscribedChannel: String, userChannelId: String, userChannelOnly: Bool, isLoadFromSubscriptions: String?) {
        self.youTubeAPIKey = youTubeAPIKey
        self.youTubeUser = youTubeUser
        self.videosCountForSubscriptionChannel = videosCountForSubscriptionChannel
        self.isLoadFromSubscriptions = isLoadFromSubscriptions
        self.youTubeURL = youTubeURL
        self.countForSubscribedChannel = countForSubscribedChannel
        self.userChannelOnly = userChannelOnly
        self.userChannelId = userChannelId
    }

    deinit {
        print("** SocialOperationHandler deinit called **")
    }

    func getFacebookFeeds() {
        if self.checkCurrentProccessIsGoingOn() {
            return
        }
        if SocialCheckConnectivity.hasConnectivity() {
            self.isFBLoadIsInProcess = true
            let fbPublicHandler = FacebookPublicFeedsHandler.sharedInstance
            fbPublicHandler.fBFeedFetchDelegate = self
            if isLoadFromServer {
                fbPublicHandler.getFacebookFeedListFromURL(stringURL: Constants.ServiceEndPoints.getFacebookList)
            } else {
                fbPublicHandler.getPublicFeedsFromUserName(fbUrl: fbGraphURL)
            }
        } else {
            self.noConnectivityReset()
        }
    }

    public func getTwitterFeeds() {
        if self.checkCurrentProccessIsGoingOn() {
            return
        }
        if SocialCheckConnectivity.hasConnectivity() {
            self.isTwitterLoadIsInProcess = true
            let twitterPublicHandler = TwitterPublicFeedsHandler.sharedInstance
            twitterPublicHandler.twitterDelegate = self
            if isLoadFromServer {
                twitterPublicHandler.getTwitterFeedListFromURL(Constants.ServiceEndPoints.getTwitterList)
            } else {
                if twitterURL.characters.count > 0 {
                    twitterPublicHandler.getLatestTweetsFromServerWithURLString(twitterURL)
                } else {
                    twitterPublicHandler.getLatestTweetsFromServerWithURLString(Constants.kTweetUrl)
                }
            }
        } else {
            self.noConnectivityReset()
        }
    }

    func getYouTubeFeeds() {
        if self.checkCurrentProccessIsGoingOn() {
            return
        }
        if SocialCheckConnectivity.hasConnectivity() {
            self.isYoutubeLoadIsInProcess = true
            let youTubePublicHandler = YouTubePublicFeedsHandler.sharedInstance
            youTubePublicHandler.youTubeDelegate = self
            if isLoadFromServer {
                youTubePublicHandler.getYouTubeFeedListFromURL(stringURL: Constants.ServiceEndPoints.getYoutubeList)
            } else {
                var loadWithoutSubscriptions = false
                if isLoadFromSubscriptions == nil {
                    loadWithoutSubscriptions = true
                } else if isLoadFromSubscriptions.characters.count > 0 {
                    if Int(isLoadFromSubscriptions) == 1 {
                        loadWithoutSubscriptions = true
                    }
                }
                if loadWithoutSubscriptions {
                    if youTubeURL.characters.count > 0 {
                        youTubePublicHandler.getYouTubeFeedsFromURL(stringURL: youTubeURL)
                    } else {
                        youTubePublicHandler.getYouTubeFeedsFromURL(stringURL: Constants.kYoutubeUrl)
                    }
                } else {
                    youTubePublicHandler.getUsersSubscriptionsData()
                }
            }
        } else {
            self.noConnectivityReset()
        }
    }

    //MARK:- YouTubeFeedDelegate Methods
    func youTubeFeedFetchSuccess(_ feedArray: NSArray?) {
        self.isYoutubeLoadIsInProcess = false
        self.isYouTubeFirstTime = true
        if self.socialDelegate != nil {
            self.socialDelegate?.socialDataFetchSuccess!()
        }
    }

    func youTubeFeedFetchError(_ error: NSError?) {
        self.isYoutubeLoadIsInProcess = false
        self.isYouTubeFirstTime = true
        if self.socialDelegate != nil {
            self.socialDelegate?.socialDataFetchError!()
        }
    }

    //MARK:- TwitterFeedDelegate Methods
    func twitterFeedFetchSuccess(_ feedArray: NSArray?) {
        self.isTwitterLoadIsInProcess = false
        self.isTwitterFirstTime = true
        if self.socialDelegate != nil {
            self.socialDelegate?.socialDataFetchSuccess!()
        }
    }

    func twitterFeedFetchError(_ errorType: NSError?) {
        self.isTwitterLoadIsInProcess = false
        self.isTwitterFirstTime = true
        if self.socialDelegate != nil {
            self.socialDelegate?.socialDataFetchError!()
        }
    }

    //MARK:- FacebookFeedDelegate Methods
    func facebookFeedFetchSuccess(_ feedArray: NSArray?) {
        self.isFBLoadIsInProcess = false
        self.isFacebookFirstTime = true
        if self.socialDelegate != nil {
            self.socialDelegate?.socialDataFetchSuccess!()
        }
    }

    func facebookFeedFetchError(_ errorType: NSError) {
        self.isFBLoadIsInProcess = false
        self.isFacebookFirstTime = true
        if self.socialDelegate != nil {
            self.socialDelegate?.socialDataFetchError!()
        }
    }

    func checkCurrentProccessIsGoingOn() -> Bool {
        var isProcessRunning = false
        if self.isFBLoadIsInProcess {
            isProcessRunning = true
        } else if self.isTwitterLoadIsInProcess {
            isProcessRunning = true
        } else if self.isYoutubeLoadIsInProcess {
            isProcessRunning = true
        }
        if isProcessRunning && self.socialDelegate != nil {
            let ViewC = self.socialDelegate as? UIViewController
            if ViewC != nil {
                DispatchQueue.main.async {
                    //MBProgressHUD.hideAllHUDsForView(ViewC?.view, animated: true)
                }
            }
        }
        return isProcessRunning
    }

    func noConnectivityReset() {
        self.isFBLoadIsInProcess = false
        self.isTwitterLoadIsInProcess = false
        self.isYoutubeLoadIsInProcess = false
        if self.socialDelegate != nil {
            self.socialDelegate?.socialDataFetchError!()
        }
    }

}
