//
//	IGFollowedBy.swift
//
//	Create by Kahuna on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGFollowedBy: NSObject {

    var count: Int!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        count = dictionary["count"] as? Int
    }

    /**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if count != nil {
            dictionary["count"] = count
        }
        return dictionary
    }

}
