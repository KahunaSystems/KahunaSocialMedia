//
//	IGLowResolution.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class IGLowResolution: NSObject {

    var height: Int!
    var url: String!
    var width: Int!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        height = dictionary["height"] as? Int
        url = dictionary["url"] as? String
        width = dictionary["width"] as? Int
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if height != nil {
            dictionary["height"] = height
        }
        if url != nil {
            dictionary["url"] = url
        }
        if width != nil {
            dictionary["width"] = width
        }
        return dictionary
    }

}
