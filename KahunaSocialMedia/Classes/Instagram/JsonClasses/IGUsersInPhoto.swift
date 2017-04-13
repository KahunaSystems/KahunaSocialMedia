//
//	IGUsersInPhoto.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGUsersInPhoto: NSObject {

    var position: IGPosition!
    var user: IGFrom!

    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        if let positionData = dictionary["position"] as? NSDictionary {
            position = IGPosition(fromDictionary: positionData)
        }
        if let userData = dictionary["user"] as? NSDictionary {
            user = IGFrom(fromDictionary: userData)
        }
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if position != nil {
            dictionary["position"] = position.toDictionary()
        }
        if user != nil {
            dictionary["user"] = user.toDictionary()
        }
        return dictionary
    }

}
