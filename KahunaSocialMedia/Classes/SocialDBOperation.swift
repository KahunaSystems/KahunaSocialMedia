//
//  SocialDBOperation.swift
//  KahunaSocialMedia
//
//  Created by Siddharth Chopra on 15/02/18.
//

import Foundation
import FMDB

/// Manage for the SocialDBOperation data table.
public class SocialDBOperation: NSObject {

    /// Query for the create table.
    private static let FacebookSQLCreate = "" +
        "CREATE TABLE IF NOT EXISTS FacebookFeedInfo (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "fbAuthorName VARCHAR, " +
        "fbCommentsCount VARCHAR, " +
        "fbCreatedTime VARCHAR, " +
        "fbDescription VARCHAR, " +
        "fbFeedId VARCHAR, " +
        "fbLikesCount VARCHAR, " +
        "fbMessage VARCHAR, " +
        "fbPostPictureLink VARCHAR, " +
        "fbPostType VARCHAR, " +
        "fbSharesCount VARCHAR, " +
        "fbTitle VARCHAR, " +
        "fbUpdatedTime VARCHAR, " +
        "fbUserIcon VARCHAR, " +
        "fbUserId VARCHAR, " +
        "fbVideoLink VARCHAR" +
        ");"

    private static let InstagramSQLCreate = "" +
        "CREATE TABLE IF NOT EXISTS InstagramFeedInfo (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "commentCount VARCHAR, " +
        "feedText VARCHAR, " +
        "userFullName VARCHAR, " +
        "likeCount VARCHAR, " +
        "mediaID VARCHAR, " +
        "standardImg VARCHAR, " +
        "thumbnailImg VARCHAR, " +
        "userID VARCHAR, " +
        "userName VARCHAR, " +
        "webLink VARCHAR, " +
        "createdDate TIMESTAMP " +
        ");"

    private static let TwitterSQLCreate = "" +
        "CREATE TABLE IF NOT EXISTS TweetInfo (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "profileIcon VARCHAR, " +
        "tweetDate VARCHAR, " +
        "tweetText VARCHAR, " +
        "tweeterUserId VARCHAR, " +
        "tweeterUserName VARCHAR, " +
        "tweetId VARCHAR " +
        ");"

    private static let YoutubeSQLCreate = "" +
        "CREATE TABLE IF NOT EXISTS YoutubeInterface (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "updatedDateTime VARCHAR, " +
        "youtubeAuthor VARCHAR, " +
        "youtubeDescription VARCHAR, " +
        "youtubeImage VARCHAR, " +
        "youtubeLink VARCHAR, " +
        "youtubeTime VARCHAR, " +
        "youtubeTitle VARCHAR, " +
        "youtubeViews VARCHAR " +
        ");"

    /// Query for the inssert row.
    private static let YoutubeSQLSelect = "" +
        "SELECT * " +
        "FROM " +
        "YoutubeInterface;"
    private static let TwitterSQLSelect = "" +
        "SELECT * " +
        "FROM " +
        "TweetInfo;"
    private static let InstagramSQLSelect = "" +
        "SELECT * " +
        "FROM " +
        "InstagramFeedInfo;"
    private static let FacebookSQLSelect = "" +
        "SELECT * " +
        "FROM " +
        "FacebookFeedInfo;"

    /// Query for the delete row.
    private static let YoutubeSQLDelete = "DELETE FROM YoutubeInterface;"
    private static let TwitterSQLDelete = "DELETE FROM TweetInfo;"
    private static let InstagramSQLDelete = "DELETE FROM InstagramFeedInfo;"
    private static let FacebookSQLDelete = "DELETE FROM FacebookFeedInfo;"

    /// Query for the inssert row.
    private static let FacebookSQLInsert = "" +
        "INSERT INTO " +
        "FacebookFeedInfo (fbAuthorName, fbCommentsCount, fbCreatedTime, fbDescription, fbFeedId, fbLikesCount, fbMessage, fbPostPictureLink, fbPostType, fbSharesCount, fbTitle, fbUpdatedTime, fbUserIcon, fbUserId, fbVideoLink) " +
        "VALUES " +
        "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
    private static let InstagramSQLInsert = "" +
        "INSERT INTO " +
        "InstagramFeedInfo (commentCount, feedText, userFullName, likeCount, mediaID, standardImg, thumbnailImg, userID, userName, webLink, createdDate) " +
        "VALUES " +
        "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
    private static let TwitterSQLInsert = "" +
        "INSERT INTO " +
        "TweetInfo (profileIcon, tweetDate, tweetText, tweeterUserId, tweeterUserName, tweetId) " +
        "VALUES " +
        "(?, ?, ?, ?, ?, ?);"
    private static let YoutubeSQLInsert = "" +
        "INSERT INTO " +
        "YoutubeInterface (updatedDateTime, youtubeAuthor, youtubeDescription, youtubeImage, youtubeLink, youtubeTime, youtubeTitle, youtubeViews) " +
        "VALUES " +
        "(?, ?, ?, ?, ?, ?, ?, ?);"

    /// Instance of the database connection.
    private let db: FMDatabase

    /// Initialize the instance.
    ///
    /// - Parameter db: Instance of the database connection.
    init(db: FMDatabase) {
        self.db = db
        super.init()
    }

    deinit {
        self.db.close()
    }

    /// Create the table.
    func create() {
        self.db.executeUpdate(SocialDBOperation.FacebookSQLCreate, withArgumentsIn: [])
        self.db.executeUpdate(SocialDBOperation.TwitterSQLCreate, withArgumentsIn: [])
        self.db.executeUpdate(SocialDBOperation.YoutubeSQLCreate, withArgumentsIn: [])
        self.db.executeUpdate(SocialDBOperation.InstagramSQLCreate, withArgumentsIn: [])
    }

    //=================================================
    /** Adding twitter info data into database
     * @param twitterFeedArray contains twitter array
     * @param type checks if whole sqlite needs to be changes or some part
     * @return 1 if successfully inserted else 0
     */
    //=================================================
    func saveAllFetchedTwitterFeedsToDB(twitterFeedArray: NSMutableArray) {
        do {
            if twitterFeedArray.count > 0 {
                self.db.executeUpdate(SocialDBOperation.TwitterSQLDelete, withArgumentsIn: [])
                for twitterInfo in twitterFeedArray {
                    if let info = twitterInfo as? TwitterDataInfo {
                        self.db.executeUpdate(SocialDBOperation.TwitterSQLInsert, withArgumentsIn: [info.profileIcon, info.tweetDate, info.tweetText, info.tweeterUserId, info.tweeterUserName, info.tweetId!])
                    }
                }
            }
        }
    }

    //=================================================
    /** Adding Facebook info data into database
     * @param fbFeedArray contains twitter array
     * @param type checks if whole sqlite needs to be changes or some part
     * @return 1 if successfully inserted else 0
     */
    //=================================================
    func saveAllFetchedFacebookFeedsToDB(fbFeedArray: NSMutableArray) {
        do {
            if fbFeedArray.count > 0 {
                self.db.executeUpdate(SocialDBOperation.FacebookSQLDelete, withArgumentsIn: [])
                for fbInfo in fbFeedArray {
                    if let info = fbInfo as? FacebookFeedDataInfo {
                        self.db.executeUpdate(SocialDBOperation.FacebookSQLInsert, withArgumentsIn: [info.fbAuthorName, info.fbCommentsCount, info.fbCreatedTime, info.fbDescription, info.fbFeedId, info.fbLikesCount, info.fbMessage, info.fbPostPictureLink, info.fbPostType, info.fbSharesCount, info.fbTitle, info.fbUpdatedTime, info.fbUserIcon, info.fbUserId, info.fbVideoLink])
                    }
                }
            }
        }
    }

    //=================================================
    /** Adding Youtube info data into database
     * @param YoutubeFeedArray contains Youtube array
     * @param type checks if whole sqlite needs to be changes or some part
     * @return 1 if successfully inserted else 0
     */
    //=================================================
    func saveAllFetchedYoutubeFeedsToDB(youtubeFeedArray: NSMutableArray) {
        do {
            if youtubeFeedArray.count > 0 {
                self.db.executeUpdate(SocialDBOperation.YoutubeSQLDelete, withArgumentsIn: [])
                for youtubeInfo in youtubeFeedArray {
                    if let info = youtubeInfo as? YouTubeInterfaceDataInfo {
                        self.db.executeUpdate(SocialDBOperation.YoutubeSQLInsert, withArgumentsIn: [info.updatedDateTime!, info.youtubeAuthor, info.youtubeDescription, info.youtubeImage, info.youtubeLink, info.youtubeTime, info.youtubeTitle, info.youtubeViews])
                    }
                }
            }
        }
    }

    //=================================================
    /** Adding Instagram info data into database
     * @param InstagramFeedArray contains Youtube array
     * @param type checks if whole sqlite needs to be changes or some part
     * @return 1 if successfully inserted else 0
     */
    //=================================================
    func saveAllFetchedInstagramFeedsToDB(instagramFeedArray: NSArray, userData: IGUser) {
        do {
            if instagramFeedArray.count > 0 {
                self.db.executeUpdate(SocialDBOperation.InstagramSQLDelete, withArgumentsIn: [])
                for instagramInfo in instagramFeedArray {
                    if let igdata = instagramInfo as? IGNode {
                        let info = InstagramFeedHandler.sharedInstance.setValueToInstaFeedObject(item: igdata, userData: userData)
                        self.db.executeUpdate(SocialDBOperation.InstagramSQLInsert, withArgumentsIn: [info.commentCount, info.feedText, info.userFullName, info.likeCount, info.mediaID, info.standardImg, info.thumbnailImg, info.userID, info.userName, info.webLink, info.createdDate!])
                    }
                }
            }
        }
    }

    //=================================================
    /** Fetch data from twitter table from database
     *@return twitterArray contains the array of twitter feeds
     */
    //=================================================
    func fetchedTwitterFeedsFromDB() -> [TwitterDataInfo] {
        var twitterArray = [TwitterDataInfo]()
        if let results = self.db.executeQuery(SocialDBOperation.TwitterSQLSelect, withArgumentsIn: []) {
            while results.next() {
                let info = TwitterDataInfo()
                info.profileIcon = results.string(forColumnIndex: 1) ?? ""
                info.tweetDate = results.string(forColumnIndex: 2) ?? ""
                info.tweetText = results.string(forColumnIndex: 3) ?? ""
                info.tweeterUserId = results.string(forColumnIndex: 4) ?? ""
                info.tweeterUserName = results.string(forColumnIndex: 5) ?? ""
                info.tweetId = results.string(forColumnIndex: 6) ?? ""
                twitterArray.append(info)
            }
        }
        return twitterArray
    }

    //=================================================
    /** Fetch data from twitter table from database
     *@return twitterArray contains the array of twitter feeds
     */
    //=================================================
    func fetchedYoutubeFeedsFromDB() -> [YouTubeInterfaceDataInfo] {
        var youtubeArray = [YouTubeInterfaceDataInfo]()
        if let results = self.db.executeQuery(SocialDBOperation.YoutubeSQLSelect, withArgumentsIn: []) {
            while results.next() {
                let info = YouTubeInterfaceDataInfo()
                info.updatedDateTime = results.date(forColumnIndex: 1) as NSDate?
                info.youtubeDescription = results.string(forColumnIndex: 3) ?? ""
                info.youtubeAuthor = results.string(forColumnIndex: 2) ?? ""
                info.youtubeImage = results.string(forColumnIndex: 4) ?? ""
                info.youtubeLink = results.string(forColumnIndex: 5) ?? ""
                info.youtubeTime = results.string(forColumnIndex: 6) ?? ""
                info.youtubeTitle = results.string(forColumnIndex: 7) ?? ""
                info.youtubeViews = results.string(forColumnIndex: 8) ?? ""
                youtubeArray.append(info)
            }
        }
        return youtubeArray
    }

    //=================================================
    /** Fetch data from facebook table from database
     *@return fbArray contains the array of twitter feeds
     */
    //=================================================
    func fetchedFacebookFeedsFromDB() -> [FacebookFeedDataInfo] {
        var fbArray = [FacebookFeedDataInfo]()
        if let results = self.db.executeQuery(SocialDBOperation.FacebookSQLSelect, withArgumentsIn: []) {
            while results.next() {
                let info = FacebookFeedDataInfo()
                info.fbAuthorName = results.string(forColumnIndex: 1) ?? ""
                info.fbCommentsCount = results.string(forColumnIndex: 2) ?? ""
                info.fbCreatedTime = results.string(forColumnIndex: 3) ?? ""
                info.fbDescription = results.string(forColumnIndex: 4) ?? ""
                info.fbFeedId = results.string(forColumnIndex: 5) ?? ""
                info.fbLikesCount = results.string(forColumnIndex: 6) ?? ""
                info.fbMessage = results.string(forColumnIndex: 7) ?? ""
                info.fbPostPictureLink = results.string(forColumnIndex: 8) ?? ""
                info.fbPostType = results.string(forColumnIndex: 9) ?? ""
                info.fbSharesCount = results.string(forColumnIndex: 10) ?? ""
                info.fbTitle = results.string(forColumnIndex: 11) ?? ""
                info.fbUpdatedTime = results.string(forColumnIndex: 12) ?? ""
                info.fbUserIcon = results.string(forColumnIndex: 13) ?? ""
                info.fbUserId = results.string(forColumnIndex: 14) ?? ""
                info.fbVideoLink = results.string(forColumnIndex: 15) ?? ""
                fbArray.append(info)
            }
        }
        return fbArray
    }

    //=================================================
    /** Fetch data from facebook table from database
     *@return fbArray contains the array of twitter feeds
     */
    //=================================================
    func fetchedInstagramFeedsFromDB() -> [InstagramFeedDataInfo] {
        var instaArray = [InstagramFeedDataInfo]()
        if let results = self.db.executeQuery(SocialDBOperation.InstagramSQLSelect, withArgumentsIn: []) {
            while results.next() {
                let info = InstagramFeedDataInfo()
                info.createdDate = results.date(forColumnIndex: 11) as NSDate?
                info.webLink = results.string(forColumnIndex: 10) ?? ""
                info.userFullName = results.string(forColumnIndex: 3) ?? ""
                info.userName = results.string(forColumnIndex: 9) ?? ""
                info.userID = results.string(forColumnIndex: 8) ?? ""
                info.likeCount = results.string(forColumnIndex: 4) ?? ""
                info.commentCount = results.string(forColumnIndex: 1) ?? ""
                info.feedText = results.string(forColumnIndex: 2) ?? ""
                info.mediaID = results.string(forColumnIndex: 5) ?? ""
                info.thumbnailImg = results.string(forColumnIndex: 7) ?? ""
                info.standardImg = results.string(forColumnIndex: 6) ?? ""
                instaArray.append(info)
            }
        }
        return instaArray
    }

}
