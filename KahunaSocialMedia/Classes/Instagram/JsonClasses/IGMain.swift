//
//	IGMain.swift
//
//	Create by Kahuna on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGMain: NSObject {

    var loggingPageId: String!
    var user: IGUser!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        loggingPageId = dictionary["logging_page_id"] as? String
        if let userData = dictionary["user"] as? NSDictionary {
            user = IGUser(fromDictionary: userData)
        }
    }

    /**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if loggingPageId != nil {
            dictionary["logging_page_id"] = loggingPageId
        }
        if user != nil {
            dictionary["user"] = user.toDictionary()
        }
        return dictionary
    }

}

