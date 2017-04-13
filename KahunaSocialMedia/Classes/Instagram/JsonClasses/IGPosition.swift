//
//	IGPosition.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGPosition: NSObject {

    var x: Float!
    var y: Float!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        x = dictionary["x"] as? Float
        y = dictionary["y"] as? Float
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if x != nil {
            dictionary["x"] = x
        }
        if y != nil {
            dictionary["y"] = y
        }
        return dictionary
    }

}
