//
//  YouTubeJSONParser.swift
//  MyCity311
//
//  Created by Piyush on 6/14/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit

class YouTubeJSONParser: NSObject {

    override init() {
    }

    deinit {
        print("** YouTubeJSONParser deinit called **")
    }

    func parseYoutubeData(feedsData: NSData, parserArray: NSMutableArray) -> NSMutableArray {
        let stringData = String(data: feedsData as Data, encoding: String.Encoding.utf8)
        var feedsArray = NSMutableArray()
        if parserArray.count > 0 {
            feedsArray = NSMutableArray(array: parserArray)
        }
        autoreleasepool() {
            let feedsDict = readFileFromPathAndSerializeIt(stringData: stringData!)
            if (feedsDict?.isKind(of: NSDictionary.self))! {
                if let entries = feedsDict!["items"] as? NSArray {
                    for dic in entries {
                        let dict = dic as! NSDictionary
                        let snippet = dict["snippet"] as! NSDictionary
                        let dataObj = YouTubeInterfaceDataInfo()
                        if let publishAt = snippet["publishedAt"] {
                            dataObj.updatedDateTime = self.formatDateWithStringDate(stringDate: publishAt as! String)
                        }
                        if let title = snippet["title"] as? String {
                            dataObj.youtubeTitle = title
                        }
                        if let descriptionText = snippet["description"] as? String {
                            dataObj.youtubeDescription = descriptionText
                        }
                        if let thumb = snippet["thumbnails"] as? NSDictionary {
                            if let thumbnailDict = thumb["default"] as? NSDictionary, let url = thumbnailDict["url"] as? String {
                                dataObj.youtubeImage = url
                            } else if let thumbnailDict = thumb["medium"] as? NSDictionary, let url = thumbnailDict["url"] as? String {
                                dataObj.youtubeImage = url
                            }
                        }
                        if let channelTitle = snippet["channelTitle"] as? String {
                            dataObj.youtubeAuthor = channelTitle
                        }
                        if let idDict = dict["id"] as? NSDictionary, let videoID = idDict["videoId"] as? String {
                            let urlString = String(format: "https://www.youtube.com/watch?v=%@", videoID)
                            dataObj.youtubeLink = urlString
                        }
                        if dataObj.youtubeLink.count > 0 {
                            feedsArray.add(dataObj)
                        }
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
            print("Error in reading YouTube fetch JSON File\(error.description)")
        }
        return nil
    }

    func formatDateWithStringDate(stringDate: String) -> NSDate? {
        var dateToReturn: NSDate? = nil
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateToReturn = dateFormatter.date(from: stringDate) as NSDate?
        return dateToReturn
    }

}
