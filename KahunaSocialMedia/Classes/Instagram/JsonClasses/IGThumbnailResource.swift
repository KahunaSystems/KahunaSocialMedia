//
//	IGThumbnailResource.swift
//
//	Create by Kahuna on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGThumbnailResource: NSObject {

    var configHeight: Int!
    var configWidth: Int!
    var src: String!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        configHeight = dictionary["config_height"] as? Int
        configWidth = dictionary["config_width"] as? Int
        src = dictionary["src"] as? String
    }

    /**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if configHeight != nil {
            dictionary["config_height"] = configHeight
        }
        if configWidth != nil {
            dictionary["config_width"] = configWidth
        }
        if src != nil {
            dictionary["src"] = src
        }
        return dictionary
    }

}
