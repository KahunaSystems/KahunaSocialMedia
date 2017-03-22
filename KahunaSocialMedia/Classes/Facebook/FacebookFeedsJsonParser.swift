//
//  FacebookFeedsJsonParser.swift
//  MyCity311
//
//  Created by Piyush on 6/10/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit

class FacebookFeedsJsonParser: NSObject {

    override init() {
    }

    deinit {
        print("** FacebookFeedsJsonParser deinit called **")
    }

    func parseData(feedsData: NSData) -> NSArray? {
        autoreleasepool() {
            let stringData = String(data: feedsData as Data, encoding: String.Encoding.utf8)
            let feedsArray = NSMutableArray()
            let feedsDict = readFileFromPathAndSerializeIt(stringData: stringData!)
            var fbFromName = SocialOperationHandler.sharedInstance.fbFromName as NSString
            fbFromName = fbFromName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
            fbFromName = fbFromName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
            if let myArray = feedsDict!["data"] {
                let arrayFeeds: NSArray = (myArray as? NSArray)!
                for i in 0 ..< arrayFeeds.count {
                    let innerFeedsDict = arrayFeeds[i] as! NSDictionary
                    let fromDict = innerFeedsDict["from"] as! NSDictionary
                    var message = innerFeedsDict["message"] as? String
                    if message == nil {
                        message = innerFeedsDict["description"] as? String
                    }
                    if (message?.characters.count)! > 0 {
                        var coreDataObj: FacebookFeedDataInfo? = FacebookFeedDataInfo()
                        var authorName = fromDict["name"] as! NSString
                        authorName = authorName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
                        authorName = authorName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
                        coreDataObj?.fbAuthorName = authorName as String
                        coreDataObj?.fbUserId = fromDict["id"] as? String
                        if let msg = message as? String? {
                            let returnDescString = self.replaceOccuranceOfString(inputString: msg!)
                            coreDataObj?.fbDescription = returnDescString
                            coreDataObj?.fbMessage = returnDescString
                        }
                        coreDataObj?.fbPostPictureLink = innerFeedsDict["picture"] as? String
                        coreDataObj?.fbVideoLink = innerFeedsDict["link"] as? String
                        coreDataObj?.fbUserIcon = innerFeedsDict["icon"] as? String
                        coreDataObj?.fbPostType = innerFeedsDict["type"] as? String
                        if innerFeedsDict["updated_time"] != nil {
                            coreDataObj?.fbUpdatedTime = innerFeedsDict["updated_time"] as? String
                        } else {
                            coreDataObj?.fbUpdatedTime = innerFeedsDict["created_time"] as? String
                        }
                        coreDataObj?.fbCreatedTime = innerFeedsDict["created_time"] as? String
                        coreDataObj?.fbFeedId = innerFeedsDict["id"] as? String
                        if let tempDic = innerFeedsDict["shares"] as? NSDictionary {
                            if let count = tempDic["count"] as? String {
                                coreDataObj?.fbLikesCount = count
                            }
                            if let count = tempDic["count"] as? String {
                                coreDataObj?.fbCommentsCount = count
                            }
                        }
                        feedsArray.add(coreDataObj!)
                    }
                }
            }
        }
        return nil
    }


    //MARK:- Read file from path and Serialize it
    func readFileFromPathAndSerializeIt(stringData: String) -> AnyObject? {
        let data = stringData.data(using: String.Encoding.utf8)
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            return jsonArray as AnyObject?
        } catch let error as NSError {
            print("Error in reading Facebook fetch JSON File\(error.description)")
        }
        return nil
    }

    func replaceOccuranceOfString(inputString: String) -> String {
        print("\n ************* FB Desc Input  \(inputString)")
        if inputString != nil {
            var replaceString = inputString as NSString
            var myRange = NSMakeRange(0, (replaceString.length))
            replaceString = replaceString.replacingOccurrences(of: "&amp;", with: "&") as NSString
            replaceString = replaceString.replacingOccurrences(of: "&apos;", with: "'") as NSString
            replaceString = replaceString.replacingOccurrences(of: "&quot;", with: "\"") as NSString
            replaceString = replaceString.replacingOccurrences(of: "&gt;", with: ">") as NSString
            replaceString = replaceString.replacingOccurrences(of: "&lt;", with: "<") as NSString
            replaceString = replaceString.replacingOccurrences(of: "&#39;", with: "'") as NSString
            return replaceString as String
        }
        return ""
    }

}
