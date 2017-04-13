//
//	IGCaption.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class IGCaption: NSObject {

    var createdTime: String!
    var from: IGFrom!
    var id: String!
    var text: String!

    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        createdTime = dictionary["created_time"] as? String
        if let fromData = dictionary["from"] as? NSDictionary {
            from = IGFrom(fromDictionary: fromData)
        }
        id = dictionary["id"] as? String
        text = dictionary["text"] as? String
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if createdTime != nil {
            dictionary["created_time"] = createdTime
        }
        if from != nil {
            dictionary["from"] = from.toDictionary()
        }
        if id != nil {
            dictionary["id"] = id
        }
        if text != nil {
            dictionary["text"] = text
        }
        return dictionary
    }

}
