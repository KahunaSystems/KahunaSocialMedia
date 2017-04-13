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
            let stringData = String(data: feedsData, encoding: NSUTF8StringEncoding)
            let feedsDict = readFileFromPathAndSerializeIt(stringData!)
            var fbFromName = SocialOperationHandler.sharedInstance.fbFromName as NSString
            fbFromName = fbFromName.stringByReplacingOccurrencesOfString("\\u2019", withString: "'")
            fbFromName = fbFromName.stringByReplacingOccurrencesOfString("\\u2019", withString: "'")
            if let myArray = feedsDict!["data"] where myArray != nil , let arrayFeeds = myArray as? NSArray {
                for i in 0 ..< arrayFeeds.count {
                    let innerFeedsDict = arrayFeeds[i] as! NSDictionary
                    let fromDict = innerFeedsDict["from"] as! NSDictionary
                    var message = innerFeedsDict["message"] as? String
                    if message == nil {
                        message = innerFeedsDict["description"] as? String
                    }
                    if message != nil && (message?.characters.count)! > 0 {
                        var coreDataObj: FacebookFeedDataInfo? = FacebookFeedDataInfo()
                        var authorName = fromDict["name"] as! NSString
                        authorName = authorName.stringByReplacingOccurrencesOfString("\\u2019", withString: "'")
                        authorName = authorName.stringByReplacingOccurrencesOfString("\\u2019", withString: "'")
                        coreDataObj?.fbAuthorName = authorName as String
                        if let userId = fromDict["id"] as? String {
                            coreDataObj?.fbUserId = userId
                        }
                        if let msg = message as? String? {
                            let returnDescString = self.replaceOccuranceOfString(msg!)
                            coreDataObj?.fbDescription = returnDescString
                            coreDataObj?.fbMessage = returnDescString
                        }
                        if let picture = innerFeedsDict["picture"] as? String {
                            coreDataObj?.fbPostPictureLink = picture
                        }
                        if let link = innerFeedsDict["link"] as? String {
                            coreDataObj?.fbVideoLink = link
                        }
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
                        feedsArray.addObject(coreDataObj!)
                    }
                }
            }
        }
        return feedsArray
    }


    //MARK:- Read file from path and Serialize it
    func readFileFromPathAndSerializeIt(stringData: String) -> AnyObject? {
        let data = stringData.dataUsingEncoding(NSUTF8StringEncoding)
        do {
            let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            return jsonArray
        } catch let error as NSError {
            print("Error in reading JSON File\(error.description)")
        }
        return nil
    }

    func replaceOccuranceOfString(inputString: String?) -> String {
        print("\n ************* FB Desc Input  \(inputString)")
        if inputString != nil {
            var replaceString = inputString
            
            var myRange = NSMakeRange(0, (replaceString?.characters.count)!)
            var newRange = inputString!.startIndex.advancedBy(myRange.location)..<inputString!.startIndex.advancedBy(myRange.location + myRange.length)
            replaceString = replaceString?.stringByReplacingOccurrencesOfString("&amp;", withString: "&", options: NSStringCompareOptions.LiteralSearch, range: newRange)
            
            myRange = NSMakeRange(0, (replaceString?.characters.count)!)
            newRange = inputString!.startIndex.advancedBy(myRange.location)..<inputString!.startIndex.advancedBy(myRange.location + myRange.length)
            replaceString = replaceString?.stringByReplacingOccurrencesOfString("&apos;", withString: "'", options: NSStringCompareOptions.LiteralSearch, range: newRange)
            
            myRange = NSMakeRange(0, (replaceString?.characters.count)!)
            newRange = inputString!.startIndex.advancedBy(myRange.location)..<inputString!.startIndex.advancedBy(myRange.location + myRange.length)
            replaceString = replaceString?.stringByReplacingOccurrencesOfString("&quot;", withString: "\"", options: NSStringCompareOptions.LiteralSearch, range: newRange)
            
            myRange = NSMakeRange(0, (replaceString?.characters.count)!)
            newRange = inputString!.startIndex.advancedBy(myRange.location)..<inputString!.startIndex.advancedBy(myRange.location + myRange.length)
            replaceString = replaceString?.stringByReplacingOccurrencesOfString("&gt;", withString: ">", options: NSStringCompareOptions.LiteralSearch, range: newRange)
            
            myRange = NSMakeRange(0, (replaceString?.characters.count)!)
            newRange = inputString!.startIndex.advancedBy(myRange.location)..<inputString!.startIndex.advancedBy(myRange.location + myRange.length)
            replaceString = replaceString?.stringByReplacingOccurrencesOfString("&lt;", withString: "<", options: NSStringCompareOptions.LiteralSearch, range: newRange)
            
            myRange = NSMakeRange(0, (replaceString?.characters.count)!)
            newRange = inputString!.startIndex.advancedBy(myRange.location)..<inputString!.startIndex.advancedBy(myRange.location + myRange.length)
            replaceString = replaceString?.stringByReplacingOccurrencesOfString("&#39;", withString: "'", options: NSStringCompareOptions.LiteralSearch, range: newRange)
            //             print("\n ************* FB Desc Output  \(replaceString)")
            return replaceString!
        }
        return ""
    }
}
