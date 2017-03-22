//
//  SocialDataHandler.swift
//  Pods
//
//  Created by Kahuna on 3/22/17.
//
//

import SQLite

public class SocialDataHandler: NSObject {

    var sqliteName = String()

    let twitterTable = Table("TweetInfo")
    let fbTable = Table("FacebookFeedInfo")
    let youtTubeTable = Table("YoutubeInterface")

    //Column name of twitter
    let profileIcon = Expression<String>("profileIcon")
    let tweetDate = Expression<String>("tweetDate")
    let tweetText = Expression<String>("tweetText")
    let tweeterUserId = Expression<String>("tweeterUserId")
    let tweeterUserName = Expression<String>("tweeterUserName")
    let tweetId = Expression<String>("tweetId")

    //Column name of facebook
    let fbAuthorName = Expression<String>("fbAuthorName")
    let fbCommentsCount = Expression<String>("fbCommentsCount")
    let fbCreatedTime = Expression<String>("fbCreatedTime")
    let fbDescription = Expression<String>("fbDescription")
    let fbFeedId = Expression<String>("fbFeedId")
    let fbLikesCount = Expression<String>("fbLikesCount")
    let fbMessage = Expression<String>("fbMessage")
    let fbPostPictureLink = Expression<String>("fbPostPictureLink")
    let fbPostType = Expression<String>("fbPostType")
    let fbTitle = Expression<String>("fbTitle")
    let fbUpdatedTime = Expression<String>("fbUpdatedTime")
    let fbUserIcon = Expression<String>("fbUserIcon")
    let fbUserId = Expression<String>("fbUserId")
    let fbVideoLink = Expression<String>("fbVideoLink")
    let fbSharesCount = Expression<String>("fbSharesCount")

    //Column name of twitter
    let updatedDateTime = Expression<Date>("updatedDateTime")
    let youtubeAuthor = Expression<String>("youtubeAuthor")
    let youtubeDescription = Expression<String>("youtubeDescription")
    let youtubeLink = Expression<String>("youtubeLink")
    let youtubeTime = Expression<String>("youtubeTime")
    let youtubeTitle = Expression<String>("youtubeTitle")
    let youtubeViews = Expression<String>("youtubeViews")
    let youtubeImage = Expression<String>("youtubeImage")

    public override init() {

    }

    public static let sharedInstance = SocialDataHandler()

    public func initSqliteName(sqliteName: String) {
        self.sqliteName = sqliteName + ".sqlite"
    }

    //=================================================
    /** Fetch data from twitter table from database
     *@return twitterArray contains the array of twitter feeds
     */
    //=================================================
    public func fetchedTwitterFeedsFromDB() -> [TwitterDataInfo] {
        var twitterArray = [TwitterDataInfo]()
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            let items = try database.prepare(twitterTable)
            for item in items {
                let info = TwitterDataInfo()
                info.profileIcon = item[profileIcon]
                info.tweetDate = item[tweetDate]
                info.tweetText = item[tweetText]
                info.tweeterUserId = item[tweeterUserId]
                info.tweeterUserName = item[tweeterUserName]
                info.tweetId = item[tweetId]
                twitterArray.append(info)
            }
            return twitterArray
        } catch let error as NSError {
            print(error)
        }
        return twitterArray
    }

    //=================================================
    /** Fetch data from twitter table from database
     *@return twitterArray contains the array of twitter feeds
     */
    //=================================================
    public func fetchedYoutubeFeedsFromDB() -> [YouTubeInterfaceDataInfo] {
        var youtubeArray = [YouTubeInterfaceDataInfo]()
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            let items = try database.prepare(youtTubeTable)
            for item in items {
                let info = YouTubeInterfaceDataInfo()
                info.updatedDateTime = item[updatedDateTime] as NSDate?
                info.youtubeDescription = item[youtubeDescription]
                info.youtubeAuthor = item[youtubeAuthor]
                info.youtubeImage = item[youtubeImage]
                info.youtubeLink = item[youtubeLink]
                info.youtubeTime = item[youtubeTime]
                info.youtubeTitle = item[youtubeTitle]
                info.youtubeViews = item[youtubeViews]
                youtubeArray.append(info)
            }
            return youtubeArray
        } catch let error as NSError {
            print(error)
        }
        return youtubeArray
    }

    //=================================================
    /** Fetch data from facebook table from database
     *@return fbArray contains the array of twitter feeds
     */
    //=================================================
    public func fetchedFacebookFeedsFromDB() -> [FacebookFeedDataInfo] {
        var fbArray = [FacebookFeedDataInfo]()
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            let items = try database.prepare(fbTable)
            for item in items {
                let info = FacebookFeedDataInfo()
                info.fbAuthorName = item[fbAuthorName]
                info.fbCommentsCount = item[fbCommentsCount]
                info.fbCreatedTime = item[fbCreatedTime]
                info.fbDescription = item[fbDescription]
                info.fbFeedId = item[fbFeedId]
                info.fbLikesCount = item[fbLikesCount]
                info.fbMessage = item[fbMessage]
                info.fbPostPictureLink = item[fbPostPictureLink]
                info.fbPostType = item[fbPostType]
                info.fbSharesCount = item[fbSharesCount]
                info.fbTitle = item[fbTitle]
                info.fbUpdatedTime = item[fbUpdatedTime]
                info.fbUserIcon = item[fbUserIcon]
                info.fbUserId = item[fbUserId]
                info.fbVideoLink = item[fbVideoLink]
                fbArray.append(info)
            }
            return fbArray
        } catch let error as NSError {
            print(error)
        }
        return fbArray
    }

    //=================================================
    /** Adding twitter info data into database
     * @param twitterFeedArray contains twitter array
     * @param type checks if whole sqlite needs to be changes or some part
     * @return 1 if successfully inserted else 0
     */
    //=================================================
    public func saveAllFetchedTwitterFeedsToDB(twitterFeedArray: NSMutableArray) -> Int {
        let nearbyArray = NSMutableArray()
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            if twitterFeedArray.count > 0 {
                try database.run(twitterTable.delete())
                for twitterInfo in twitterFeedArray {
                    if let info = twitterInfo as? TwitterDataInfo {
                        let insert = twitterTable.insert(profileIcon <- info.profileIcon, tweetDate <- info.tweetDate, tweetText <- info.tweetText, tweeterUserId <- info.tweeterUserId, tweeterUserName <- info.tweeterUserName, tweetId <- info.tweetId!)
                        let rowId = try database.run(insert)
                    }
                }
            }
        } catch let error as NSError {
            print(error)
            return 0
        }
        return 1
    }

    //=================================================
    /** Adding Facebook info data into database
     * @param fbFeedArray contains twitter array
     * @param type checks if whole sqlite needs to be changes or some part
     * @return 1 if successfully inserted else 0
     */
    //=================================================
    public func saveAllFetchedFacebookFeedsToDB(fbFeedArray: NSMutableArray) -> Int {
        let nearbyArray = NSMutableArray()
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            if fbFeedArray.count > 0 {
                try database.run(fbTable.delete())
                for fbInfo in fbFeedArray {
                    if let info = fbInfo as? FacebookFeedDataInfo {
                        let insert = fbTable.insert(fbAuthorName <- info.fbAuthorName, fbCommentsCount <- info.fbCommentsCount, fbCreatedTime <- info.fbCreatedTime, fbDescription <- info.fbDescription, fbFeedId <- info.fbFeedId, fbLikesCount <- info.fbLikesCount, fbMessage <- info.fbMessage, fbPostPictureLink <- info.fbPostPictureLink, fbPostType <- info.fbPostType, fbSharesCount <- info.fbSharesCount, fbTitle <- info.fbTitle, fbUpdatedTime <- info.fbUpdatedTime, fbUserIcon <- info.fbUserIcon, fbUserId <- info.fbUserId, fbVideoLink <- info.fbVideoLink)
                        let rowId = try database.run(insert)
                    }
                }
            }
        } catch let error as NSError {
            print(error)
            return 0
        }
        return 1
    }

    //=================================================
    /** Adding Youtube info data into database
     * @param YoutubeFeedArray contains Youtube array
     * @param type checks if whole sqlite needs to be changes or some part
     * @return 1 if successfully inserted else 0
     */
    //=================================================
    public func saveAllFetchedYoutubeFeedsToDB(youtubeFeedArray: NSMutableArray) -> Int {
        let nearbyArray = NSMutableArray()
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            if youtubeFeedArray.count > 0 {
                try database.run(youtTubeTable.delete())
                for youtubeInfo in youtubeFeedArray {
                    if let info = youtubeInfo as? YouTubeInterfaceDataInfo {
                        let insert = youtTubeTable.insert(updatedDateTime <- info.updatedDateTime as! Date, youtubeAuthor <- info.youtubeAuthor, youtubeDescription <- info.youtubeDescription, youtubeImage <- info.youtubeImage, youtubeLink <- info.youtubeLink, youtubeTime <- info.youtubeTime, youtubeTitle <- info.youtubeTitle, youtubeViews <- info.youtubeViews)
                        let rowId = try database.run(insert)
                    }
                }
            }
        } catch let error as NSError {
            print(error)
            return 0
        }
        return 1
    }

    public func deleteTwitterDataInSqlite(deleteSqlite: NSArray) {
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            for twId in deleteSqlite {
                let twIdValue = twId as! String
                let query = twitterTable.filter(tweetId == twIdValue)
                try database.run(query.delete())
            }
        } catch let error as NSError {
            print(error)
        }
    }

    public func deleteFacebookDataInSqlite(deleteSqlite: NSArray) {
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            for twId in deleteSqlite {
                let twIdValue = twId as! String
                let query = fbTable.filter(tweetId == twIdValue)
                try database.run(query.delete())
            }
        } catch let error as NSError {
            print(error)
        }
    }

    public func deleteYoutubeDataInSqlite(deleteSqlite: NSArray) {
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            for twId in deleteSqlite {
                let twIdValue = twId as! String
                let query = youtTubeTable.filter(tweetId == twIdValue)
                try database.run(query.delete())
            }
        } catch let error as NSError {
            print(error)
        }
    }

    func getDatabasePath() -> String {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let writableDBPath = documentsDirectory.appending("/" + self.sqliteName)
        self.checkAndCopyDbIfRequired(databasePath: writableDBPath)
        return writableDBPath
    }

    func checkAndCopyDbIfRequired(databasePath: String) {
        var success: Bool
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: databasePath)
        if success == false {
            let defaultDBPath = Bundle.main.resourcePath?.appending("/" + self.sqliteName)
            do {
                try fileManager.copyItem(atPath: defaultDBPath!, toPath: databasePath)
            } catch {
                // Catch fires here, with an NSError being thrown
                print("error occurred")
            }

        }
    }
}
