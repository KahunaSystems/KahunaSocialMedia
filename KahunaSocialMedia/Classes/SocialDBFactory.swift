//
//  SocialDBOperation.swift
//  KahunaSocialMedia
//
//  Created by Siddharth Chopra on 15/02/18.
//

import UIKit
import FMDB

/// Factory of a data access objects.
class SocialDBFactory: NSObject {

    /// Path of the database file.
    private let filePath: String

    /// Initialize the instance.
    override init() {
        self.filePath = SocialDBFactory.databaseFilePath()
        super.init()
        // For debug
        print(self.filePath)
    }

    /// Initialize the instance with the path of the database file.
    ///
    /// - Parameter filePath: the path of the database file.
    init(filePath: String) {
        self.filePath = filePath
        super.init()
    }

    /// Create the data access object of the SocialDBOperation.
    ///
    /// - Returns: Instance of the data access object.
    func socialDBOperation() -> SocialDBOperation? {
        if let db = self.connect() {
            return SocialDBOperation(db: db)
        }
        return nil
    }

    /// Connect to the database.
    ///
    /// - Returns: Connection instance if successful, nil otherwise.
    private func connect() -> FMDatabase? {
        let db = FMDatabase(path: self.filePath)
        return (db.open()) ? db : nil
    }

    /// Get the path of database file.
    ///
    /// - Returns: Path of the database file.
    private static func databaseFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dir = paths[0] as NSString
        return dir.appendingPathComponent("KahunaSocialMedia.db")
    }
}
