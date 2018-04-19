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
        let feedsArray = NSMutableArray()
        autoreleasepool() {
            let stringData = String(data: feedsData as Data, encoding: String.Encoding.utf8)
            let feedsDict = readFileFromPathAndSerializeIt(stringData: stringData!)
            var fbFromName = SocialOperationHandler.sharedInstance.fbFromName as NSString
            fbFromName = fbFromName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
            fbFromName = fbFromName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
            if let myArray = feedsDict!["data"], myArray != nil, let arrayFeeds = myArray as? NSArray {
                for i in 0 ..< arrayFeeds.count {
                    let innerFeedsDict = arrayFeeds[i] as! NSDictionary
                    let fromDict = innerFeedsDict["from"] as! NSDictionary
                    var message = innerFeedsDict["message"] as? String
                    if message == nil {
                        message = innerFeedsDict["description"] as? String
                    }
                    var pictureURL = ""
                    var linkURL = ""
                    if let picture = innerFeedsDict["picture"] as? String {
                        pictureURL = picture
                    }
                    if let link = innerFeedsDict["link"] as? String {
                        linkURL = link
                    }
                    if (message != nil && (message?.count)! > 0) || pictureURL.count > 0 || linkURL.count > 0 {
                        let coreDataObj: FacebookFeedDataInfo? = FacebookFeedDataInfo()
                        var authorName = fromDict["name"] as! NSString
                        authorName = authorName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
                        authorName = authorName.replacingOccurrences(of: "\\u2019", with: "'") as NSString
                        coreDataObj?.fbAuthorName = authorName as String
                        if let userId = fromDict["id"] as? String {
                            coreDataObj?.fbUserId = userId
                        }
                        if let msg = message {
                            let returnDescString = self.replaceOccuranceOfString(inputString: msg)
                            coreDataObj?.fbDescription = returnDescString
                            coreDataObj?.fbMessage = returnDescString
                        }
                        coreDataObj?.fbPostPictureLink = pictureURL
                        coreDataObj?.fbVideoLink = linkURL
                        if let icon = innerFeedsDict["icon"] as? String {
                            coreDataObj?.fbUserIcon = icon
                        }
                        if let type = innerFeedsDict["type"] as? String {
                            coreDataObj?.fbPostType = type
                        }
                        if innerFeedsDict["updated_time"] != nil {
                            if let updated_time = innerFeedsDict["updated_time"] as? String {
                                coreDataObj?.fbUpdatedTime = updated_time
                            }
                        } else {
                            if let created_time = innerFeedsDict["created_time"] as? String {
                                coreDataObj?.fbUpdatedTime = created_time
                            }
                        }
                        if let created_time = innerFeedsDict["created_time"] as? String {
                            coreDataObj?.fbCreatedTime = created_time
                        }
                        if let fbFeedId = innerFeedsDict["id"] as? String {
                            coreDataObj?.fbFeedId = fbFeedId
                        }
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
        return feedsArray
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
        var replaceString = inputString as NSString
        _ = NSMakeRange(0, (replaceString.length))
        replaceString = replaceString.replacingOccurrences(of: "&amp;", with: "&") as NSString
        replaceString = replaceString.replacingOccurrences(of: "&apos;", with: "'") as NSString
        replaceString = replaceString.replacingOccurrences(of: "&quot;", with: "\"") as NSString
        replaceString = replaceString.replacingOccurrences(of: "&gt;", with: ">") as NSString
        replaceString = replaceString.replacingOccurrences(of: "&lt;", with: "<") as NSString
        replaceString = replaceString.replacingOccurrences(of: "&#39;", with: "'") as NSString
        return replaceString as String
    }

}
