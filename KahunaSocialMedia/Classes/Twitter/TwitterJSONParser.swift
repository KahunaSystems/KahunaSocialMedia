//
//  TwitterJSONParser.swift
//  MyCity311
//
//  Created by Piyush on 6/14/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit

class TwitterJSONParser: NSObject {


    override init() {
    }

    deinit {
        print("** TwitterJSONParser deinit called **")
    }

    func parseTwitterFeedData(_ feedsData: Data, parserArray: NSMutableArray) -> NSMutableArray {
        let stringData = String(data: feedsData, encoding: String.Encoding.utf8)
        var tweetsArray = NSMutableArray()
        if parserArray.count > 0 {
            tweetsArray = NSMutableArray(array: parserArray)
        }
        autoreleasepool() {
            let feedsDict = readFileFromPathAndSerializeIt(stringData!)
            if (feedsDict?.isKind(of: NSDictionary.self))! {
                let dataArray = feedsDict!["data"] as! NSArray
                if dataArray.isKind(of: NSArray.self) {
                    tweetsArray = self.parseTwitterInfo(dataArray, tweetsArray: tweetsArray)
                }
            }
        }
        return tweetsArray
    }

    fileprivate func getDate(_ unixdate: Int, timezone: String) -> String {
        if unixdate == 0 { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(unixdate / 1000))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        dayTimePeriodFormatter.timeZone = TimeZone(identifier: timezone) as TimeZone!
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }

    func parseTwitterInfo(_ dataArray: NSArray, tweetsArray: NSMutableArray) -> NSMutableArray {
        for dic in dataArray {
            let coreDataObj: TwitterDataInfo? = TwitterDataInfo()
            let dict = dic as! NSDictionary
            if let tweetID = dict["id_str"], tweetID as? String != nil {
                coreDataObj?.tweetId = tweetID as? String
            }
            if let tweetID = dict["id"], tweetID as? String != nil {
                coreDataObj?.tweetId = tweetID as? String
            }
            if var tweetText = dict["text"] {
                tweetText = self.replaceOccuranceOfString(tweetText as? String) ?? ""
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
            tweetsArray.add(coreDataObj!)
        }
        return tweetsArray
    }

    //MARK:- Read file from path and Serialize it
    func readFileFromPathAndSerializeIt(_ stringData: String) -> AnyObject? {
        let data = stringData.data(using: String.Encoding.utf8)
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            return jsonArray as AnyObject?
        } catch let error as NSError {
            print("Error in reading YouTube fetch JSON File\(error.description)")
        }
        return nil
    }

    func parseTwitterData(_ dataArray: NSArray?) -> NSMutableArray {
        var tweetsArray = NSMutableArray()
        if dataArray != nil && dataArray!.isKind(of: NSArray.self) {
            tweetsArray = self.parseTwitterInfo(dataArray!, tweetsArray: tweetsArray)
        }
        return tweetsArray
    }

    func replaceOccuranceOfString(_ inputString: String?) -> String? {
        if inputString != nil {
            var replaceString = inputString

            var myRange = NSMakeRange(0, (replaceString?.count)!)
            var newRange = inputString!.index(inputString!.startIndex, offsetBy: myRange.location)..<inputString!.index(inputString!.startIndex, offsetBy: myRange.location + myRange.length)
            replaceString = replaceString?.replacingOccurrences(of: "&amp;", with: "&", options: NSString.CompareOptions.literal, range: newRange)

            myRange = NSMakeRange(0, (replaceString?.count)!)
            newRange = inputString!.index(inputString!.startIndex, offsetBy: myRange.location)..<inputString!.index(inputString!.startIndex, offsetBy: myRange.location + myRange.length)
            replaceString = replaceString?.replacingOccurrences(of: "&apos;", with: "'", options: NSString.CompareOptions.literal, range: newRange)

            myRange = NSMakeRange(0, (replaceString?.count)!)
            newRange = inputString!.index(inputString!.startIndex, offsetBy: myRange.location)..<inputString!.index(inputString!.startIndex, offsetBy: myRange.location + myRange.length)
            replaceString = replaceString?.replacingOccurrences(of: "&quot;", with: "\"", options: NSString.CompareOptions.literal, range: newRange)

            myRange = NSMakeRange(0, (replaceString?.count)!)
            newRange = inputString!.index(inputString!.startIndex, offsetBy: myRange.location)..<inputString!.index(inputString!.startIndex, offsetBy: myRange.location + myRange.length)
            replaceString = replaceString?.replacingOccurrences(of: "&gt;", with: ">", options: NSString.CompareOptions.literal, range: newRange)

            myRange = NSMakeRange(0, (replaceString?.count)!)
            newRange = inputString!.index(inputString!.startIndex, offsetBy: myRange.location)..<inputString!.index(inputString!.startIndex, offsetBy: myRange.location + myRange.length)
            replaceString = replaceString?.replacingOccurrences(of: "&lt;", with: "<", options: NSString.CompareOptions.literal, range: newRange)

            myRange = NSMakeRange(0, (replaceString?.count)!)
            newRange = inputString!.index(inputString!.startIndex, offsetBy: myRange.location)..<inputString!.index(inputString!.startIndex, offsetBy: myRange.location + myRange.length)
            replaceString = replaceString?.replacingOccurrences(of: "&#39;", with: "'", options: NSString.CompareOptions.literal, range: newRange)
            return replaceString!
        }
        return nil
    }

}
