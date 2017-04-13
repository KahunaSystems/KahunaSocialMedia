//
//	IGFrom.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGFrom: NSObject {

    var fullName: String!
    var id: String!
    var profilePicture: String!
    var username: String!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        fullName = dictionary["full_name"] as? String
        id = dictionary["id"] as? String
        profilePicture = dictionary["profile_picture"] as? String
        username = dictionary["username"] as? String
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if fullName != nil {
            dictionary["full_name"] = fullName
        }
        if id != nil {
            dictionary["id"] = id
        }
        if profilePicture != nil {
            dictionary["profile_picture"] = profilePicture
        }
        if username != nil {
            dictionary["username"] = username
        }
        return dictionary
    }

}
