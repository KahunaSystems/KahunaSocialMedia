//
//  SocialDataHandler.swift
//  Pods
//
//  Created by Kahuna on 3/22/17.
//
//

import SQLite

public class SocialDataHandler: NSObject {

    let table = Table("TweetInfo")
    let profileIcon = Expression<String>("profileIcon")
    let tweetDate = Expression<String>("tweetDate")
    let tweetText = Expression<String>("tweetText")
    let tweeterUserId = Expression<String>("tweeterUserId")
    let tweeterUserName = Expression<String>("tweeterUserName")
    let tweetId = Expression<String>("tweetId")

    public override init() {

    }

    public static let sharedInstance = SocialDataHandler()

    //=================================================
    /** Fetch data from twitter table from database
     *@return nearByArray contains the array of twitter feeds
     */
    //=================================================
    public func fetchedTwitterFeedsFromDB() -> [TwitterDataInfo] {
        var twitterArray = [TwitterDataInfo]()
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            let items = try database.prepare(table)
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
        }
        catch let error as NSError {
            print(error)
        }
        return twitterArray
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
                try database.run(table.delete())
                for twitterInfo in twitterFeedArray {
                    if let info = twitterInfo as? TwitterDataInfo {
                        let insert = table.insert(profileIcon <- info.profileIcon!, tweetDate <- info.tweetDate!, tweetText <- info.tweetText!, tweeterUserId <- info.tweeterUserId!, tweeterUserName <- info.tweeterUserName!, tweetId <- info.tweetId!)
                        let rowId = try database.run(insert)
                    }
                }
            }
        }
        catch let error as NSError {
            print(error)
            return 0
        }
        return 1
    }

    public func deleteDataInSqlite(deleteSqlite: NSArray) {
        let writableDBPath = self.getDatabasePath()
        var database: Connection
        do {
            database = try Connection(writableDBPath)
            for twId in deleteSqlite {
                let twIdValue = twId as! String
                let query = table.filter(tweetId == twIdValue)
                try database.run(query.delete())
            }
        }
        catch let error as NSError {
            print(error)
        }
    }

    func getDatabasePath() -> String {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let writableDBPath = documentsDirectory.appending("/MyCity311.sqlite")
        self.checkAndCopyDbIfRequired(databasePath: writableDBPath)
        return writableDBPath
    }

    func checkAndCopyDbIfRequired(databasePath: String) {
        var success: Bool
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: databasePath)
        if success == false {
            let defaultDBPath = Bundle.main.resourcePath?.appending("/MyCity311.sqlite")
            do {
                try fileManager.copyItem(atPath: defaultDBPath!, toPath: databasePath)
            }
            catch {
                // Catch fires here, with an NSError being thrown
                print("error occurred")
            }

        }
    }
}
