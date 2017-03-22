//
//  YouTubePublicFeedsHandler.swift
//  MyCity311
//
//  Created by Piyush on 6/14/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit

@objc protocol YouTubeFeedDelegate: class {
    @objc optional func youTubeFeedFetchSuccess(_ feedArray: NSArray?)
    @objc optional func youTubeFeedFetchError(_ error: NSError?)
}

class YouTubePublicFeedsHandler: NSObject {

    weak var youTubeDelegate: YouTubeFeedDelegate!
    static let sharedInstance = YouTubePublicFeedsHandler()
    let userDefault = UserDefaults.standard

    override init() {
    }

    deinit {
        print("** YouTubePublicFeedsHandler deinit called **")
    }

    func getYouTubeFeedListFromURL(stringURL: String) {
        let basePath = SocialOperationHandler.sharedInstance.serverBaseURL
        let paramString = basePath + stringURL
        let loadURL = NSURL(string: paramString)
        let request = NSURLRequest(url: loadURL! as URL)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error != nil {
                if self.youTubeDelegate != nil {
                    self.youTubeDelegate!.youTubeFeedFetchError!(error! as NSError?)
                }
            } else if data != nil {
                let parserArray = NSMutableArray()
                let parcer = YouTubeJSONParser()
                let parsedArray = parcer.parseYoutubeData(feedsData: data! as NSData, parserArray: parserArray) as NSMutableArray
                DispatchQueue.main.async {
                    if self.youTubeDelegate != nil {
                        self.youTubeDelegate!.youTubeFeedFetchSuccess!(parsedArray)
                    }
                }
            }
        })
        task.resume()
    }

    func getYouTubeFeedsFromURL(stringURL: String?) {
        if stringURL != nil {
            var paramString = "" as NSString
            let range = stringURL?.range(of: "?")
            paramString = String(format: "%@/alt=json", stringURL!) as NSString
            paramString = paramString.replacingOccurrences(of: " ", with: "%20") as NSString
            let loadURL = NSURL(string: paramString as String)
            let request = NSURLRequest(url: loadURL! as URL)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if error != nil {
                    if self.youTubeDelegate != nil {
                        self.youTubeDelegate!.youTubeFeedFetchError!(error! as NSError?)
                    }
                } else if data != nil {
                    let parserArray = NSMutableArray()
                    let parcer = YouTubeJSONParser()
                    let parsedArray = parcer.parseYoutubeData(feedsData: data! as NSData, parserArray: parserArray) as NSMutableArray
                    DispatchQueue.main.async {
                        if self.youTubeDelegate != nil {
                            self.youTubeDelegate!.youTubeFeedFetchSuccess!(parsedArray)
                        }
                    }
                }
            })
            task.resume()
        }
    }

    func getUsersSubscriptionsData() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            self.getUploadsForEachSubscription()
        }
    }

    func getUploadsForEachSubscription() {
        let subsciptionArray = self.getCurrentUsersSubscriptions()
        var numberOfVideos = "5"
        if SocialOperationHandler.sharedInstance.videosCountForSubscriptionChannel.characters.count > 0 {
            numberOfVideos = SocialOperationHandler.sharedInstance.videosCountForSubscriptionChannel
        }
        var parserArray = NSMutableArray()
        if subsciptionArray != nil {
            for i in 0 ..< subsciptionArray!.count {
                let subsciptionChannelURL = String(format: "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=%@&maxResults=%@&order=date&type=video&fields=items&key=%@", (subsciptionArray![i] as! String), numberOfVideos, SocialOperationHandler.sharedInstance.youTubeAPIKey)
                let urlToLoad = NSURL(string: subsciptionChannelURL)
                var response: URLResponse?
                do {
                    let data = try NSURLConnection.sendSynchronousRequest(NSURLRequest(url: urlToLoad! as URL) as URLRequest, returning: &response)
                    let parcer = YouTubeJSONParser()
                    let parsedArray = parcer.parseYoutubeData(feedsData: data as NSData, parserArray: parserArray)
                    parserArray = NSMutableArray(array: parsedArray)
                } catch (let e) {
                    print(e)
                    if self.youTubeDelegate != nil {
                        self.youTubeDelegate!.youTubeFeedFetchError!(nil)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            if self.youTubeDelegate != nil {
                self.youTubeDelegate!.youTubeFeedFetchSuccess!(parserArray)
            }
        }
    }

    func getCurrentUsersSubscriptions() -> NSArray? {
        if SocialOperationHandler.sharedInstance.userChannelOnly {
            return [SocialOperationHandler.sharedInstance.userChannelId]
        } else {
            //Static content
            let channelID = self.getUserChannelID()
            if channelID != nil {
                var numberOfChannels = "50"
                if SocialOperationHandler.sharedInstance.countForSubscribedChannel.characters.count > 0 {
                    numberOfChannels = SocialOperationHandler.sharedInstance.countForSubscribedChannel
                }
                var urlString = String(format: "https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&channelId=%@&maxResults=%@&order=relevance&fields=items/snippet&key=%@", channelID!, numberOfChannels, SocialOperationHandler.sharedInstance.youTubeAPIKey) as NSString
                urlString = urlString.replacingOccurrences(of: " ", with: "%20") as NSString
                let urlToLoad = NSURL(string: urlString as String)
                var response: URLResponse?
                do {
                    let data = try NSURLConnection.sendSynchronousRequest(NSURLRequest(url: urlToLoad! as URL) as URLRequest, returning: &response)
                    let subscriptionArray = self.arrayOfParsedSubscriptionsData(subscriptionsData: data as NSData)
                    return subscriptionArray
                }
                catch (let e) {
                    print(e)
                    if self.youTubeDelegate != nil {
                        self.youTubeDelegate?.youTubeFeedFetchError!(nil)
                    }
                }
            }
        }
        return nil
    }

    func arrayOfParsedSubscriptionsData(subscriptionsData: NSData) -> NSMutableArray {
        let subscriptionsArray = NSMutableArray()
        let stringData = String(data: subscriptionsData as Data, encoding: String.Encoding.utf8)
        let parseDict = self.readFileFromPathAndSerializeIt(stringData: stringData!, errorMessage: "arrayOfParsedSubscriptionsData")
        if let myArray = parseDict!["items"] {
            let items: NSArray = (myArray as? NSArray)!
            for i in 0 ..< items.count {
                if let dict = items[i] as? NSDictionary, let arrayFeed = dict["snippet"] as? NSDictionary, let tempDic = arrayFeed["resourceId"] as? NSDictionary {
                    if tempDic.count > 0 {
                        if let feedUrl = tempDic["channelId"] {
                            subscriptionsArray.add(feedUrl)
                        }
                    }
                }
            }
        }
        return subscriptionsArray
    }

    //MARK: GET CHANNEL ID FOR YOUTUBE
    func getUserChannelID() -> String? {
        print("Fetching Current Users Channel ID")
        let userName = SocialOperationHandler.sharedInstance.youTubeUser
        var urlString = String(format: "https://www.googleapis.com/youtube/v3/channels?part=id&forUsername=  %@&fields=items(id,statistics,status,topicDetails)&key=%@", userName, SocialOperationHandler.sharedInstance.youTubeAPIKey) as NSString
        urlString = urlString.replacingOccurrences(of: " ", with: "%20") as NSString
        let url = NSURL(string: urlString as String)
        var response: URLResponse?
        do {
            let data = try NSURLConnection.sendSynchronousRequest(NSURLRequest(url: url! as URL) as URLRequest, returning: &response)
            let stringData = String(data: data, encoding: String.Encoding.utf8)
            let parseDict = self.readFileFromPathAndSerializeIt(stringData: stringData!, errorMessage: "Fetching Current Users Channel ID")
            if parseDict != nil {
                if let myArray = parseDict!["items"] {
                    let items: NSArray = (myArray as? NSArray)!
                    if items.count > 0 {
                        if let dict = items[0] as? NSDictionary, let channelID = dict["id"] {
                            return channelID as? String
                        }
                    }
                }
            }
        } catch (let e) {
            print(e)
            if self.youTubeDelegate != nil {
                self.youTubeDelegate?.youTubeFeedFetchError!(nil)
            }
        }
        return nil
    }


    //MARK:- Read file from path and Serialize it
    func readFileFromPathAndSerializeIt(stringData: String, errorMessage: String) -> AnyObject? {
        let data = stringData.data(using: String.Encoding.utf8)
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            return jsonArray as AnyObject?
        } catch let error as NSError {
            print("Error in \(errorMessage) fetch JSON File\(error.description)")
        }
        return nil
    }

}
