//
//	IGDimension.swift
//
//	Create by Kahuna on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGDimension: NSObject {

    var height: Int!
    var width: Int!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        height = dictionary["height"] as? Int
        width = dictionary["width"] as? Int
    }

    /**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if height != nil {
            dictionary["height"] = height
        }
        if width != nil {
            dictionary["width"] = width
        }
        return dictionary
    }

}
