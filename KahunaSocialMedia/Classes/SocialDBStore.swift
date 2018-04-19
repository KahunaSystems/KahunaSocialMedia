//
//  SocialDBOperation.swift
//  KahunaSocialMedia
//
//  Created by Siddharth Chopra on 15/02/18.
//

import UIKit

/// Manage for the SocialDBStore.
class SocialDBStore: NSObject {

    /// Factory of a data access objects.
    private let dbFactory: SocialDBFactory

    /// Initialize the instance.
    ///
    /// - Parameter daoFactory: Factory of a data access objects.
    init(dbFactory: SocialDBFactory) {
        self.dbFactory = dbFactory
        super.init()
        if let db = self.dbFactory.socialDBOperation() {
            db.create()
        }
    }

    //=================================================
    /** Adding twitter info data into database
     * @param twitterFeedArray contains twitter array
     * @param type checks if whole sqlite needs to be changes or some part
     */
    //=================================================
    public func saveAllFetchedTwitterFeedsToDB(twitterFeedArray: NSMutableArray) {
        if let socialDBOperation = self.dbFactory.socialDBOperation() {
            socialDBOperation.saveAllFetchedTwitterFeedsToDB(twitterFeedArray: twitterFeedArray)
        }
    }

    //=================================================
    /** Adding Facebook info data into database
     * @param fbFeedArray contains twitter array
     * @param type checks if whole sqlite needs to be changes or some part
     */
    //=================================================
    func saveAllFetchedFacebookFeedsToDB(fbFeedArray: NSMutableArray) {
        if let socialDBOperation = self.dbFactory.socialDBOperation() {
            socialDBOperation.saveAllFetchedFacebookFeedsToDB(fbFeedArray: fbFeedArray)
        }
    }

    //=================================================
    /** Adding Youtube info data into database
     * @param YoutubeFeedArray contains Youtube array
     * @param type checks if whole sqlite needs to be changes or some part
     */
    //=================================================
    func saveAllFetchedYoutubeFeedsToDB(youtubeFeedArray: NSMutableArray) {
        if let socialDBOperation = self.dbFactory.socialDBOperation() {
            socialDBOperation.saveAllFetchedYoutubeFeedsToDB(youtubeFeedArray: youtubeFeedArray)
        }
    }

    //=================================================
    /** Adding Instagram info data into database
     * @param InstagramFeedArray contains Youtube array
     * @param type checks if whole sqlite needs to be changes or some part
     */
    //=================================================
    func saveAllFetchedInstagramFeedsToDB(instagramFeedArray: NSArray, userData: IGUser) {
        if let socialDBOperation = self.dbFactory.socialDBOperation() {
            socialDBOperation.saveAllFetchedInstagramFeedsToDB(instagramFeedArray: instagramFeedArray, userData: userData)
        }
    }

    /// Get the getDBFactory sore.
    ///
    /// - Returns: Instance of the getDBFactory store.
    public func getDBFactory() -> SocialDBFactory {
        return self.dbFactory
    }
}
