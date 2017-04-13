//
//  TwitterJSONParser.swift
//  MyCity311
//
//  Created by Piyush on 6/14/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit
import KahunaSocialMedia

class TwitterJSONParser: NSObject {


    override init() {
    }

    deinit {
        print("** TwitterJSONParser deinit called **")
    }

    func parseTwitterFeedData(_ feedsData: NSData, parserArray: NSMutableArray) -> NSMutableArray {
        let stringData = String(data: feedsData, encoding: NSUTF8StringEncoding)
        var tweetsArray = NSMutableArray()
        if parserArray.count > 0 {
            tweetsArray = NSMutableArray(array: parserArray)
        }
        autoreleasepool() {
            let feedsDict = readFileFromPathAndSerializeIt(stringData!)
            if (feedsDict?.isKindOfClass(NSDictionary)) != nil {
                let dataArray = feedsDict!["data"] as! NSArray
                if dataArray.isKindOfClass(NSArray) {
                    tweetsArray = self.parseTwitterInfo(dataArray, tweetsArray: tweetsArray)
                }
            }
        }
        return tweetsArray
    }

    private func getDate(unixdate: Int, timezone: String) -> String {
        if unixdate == 0 { return "" }
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(unixdate / 1000))
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        dayTimePeriodFormatter.timeZone = NSTimeZone(name: timezone) as NSTimeZone!
        let dateString = dayTimePeriodFormatter.stringFromDate(date as NSDate)
        return dateString
    }

    func parseTwitterInfo(_ dataArray: NSArray, tweetsArray: NSMutableArray) -> NSMutableArray {
        for dic in dataArray {
            let coreDataObj: TwitterDataInfo? = TwitterDataInfo()
            let dict = dic as! NSDictionary
            if let tweetID = dict["id_str"] where tweetID as? String != nil {
                coreDataObj?.tweetId = tweetID as? String
            }
            if let tweetID = dict["id"] where tweetID as? String != nil {
                coreDataObj?.tweetId = tweetID as? String
            }
            if var tweetText = dict["text"] {
                tweetText = self.replaceOccuranceOfString(tweetText as? String)!
                if let tempStr = tweetText as? String {
                    coreDataObj?.tweetText = tempStr
                }
            }
            if let createAt = dict["created_at"] {
                if createAt as? String != nil {
                    coreDataObj?.tweetDate = createAt as! String
                } else {
                    coreDataObj?.tweetDate = getDate(createAt as! Int, timezone: "UTC")
                }
            }
            if let userInfo = dict["user"] as? NSDictionary {
                if let screenName = userInfo["screen_name"] as? String {
                    coreDataObj?.tweeterUserId = screenName
                }
                if let name = userInfo["name"] as? String {
                    coreDataObj?.tweeterUserName = name
                }
                if let imageURL = userInfo["profile_image_url"] as? String {
                    coreDataObj?.profileIcon = imageURL
                }
            }
            tweetsArray.addObject(coreDataObj!)
        }
        return tweetsArray
    }

    //MARK:- Read file from path and Serialize it
    func readFileFromPathAndSerializeIt(_ stringData: String) -> AnyObject? {
        let data = stringData.dataUsingEncoding(NSUTF8StringEncoding)
        do {
            let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            return jsonArray
        } catch let error as NSError {
            print("Error in reading YouTube fetch JSON File\(error.description)")
        }
        return nil
    }

    func parseTwitterData(dataArray: NSArray?) -> NSMutableArray {
        var tweetsArray = NSMutableArray()
        if dataArray != nil && dataArray!.isKindOfClass(NSArray) {
            tweetsArray = self.parseTwitterInfo(dataArray!, tweetsArray: tweetsArray)
        }
        return tweetsArray
    }

    func replaceOccuranceOfString(inputString: String?) -> String? {
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
            return replaceString!
        }
        return nil
    }


}
