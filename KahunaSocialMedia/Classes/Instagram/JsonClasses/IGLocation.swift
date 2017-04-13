//
//	IGLocation.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGLocation: NSObject {

    var id: Int!
    var latitude: Float!
    var longitude: Float!
    var name: String!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        latitude = dictionary["latitude"] as? Float
        longitude = dictionary["longitude"] as? Float
        name = dictionary["name"] as? String
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if id != nil {
            dictionary["id"] = id
        }
        if latitude != nil {
            dictionary["latitude"] = latitude
        }
        if longitude != nil {
            dictionary["longitude"] = longitude
        }
        if name != nil {
            dictionary["name"] = name
        }
        return dictionary
    }

}
