//
//	IGOwner.swift
//
//	Create by Kahuna on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGOwner: NSObject {

    var id: String!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        id = dictionary["id"] as? String
    }

    /**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if id != nil {
            dictionary["id"] = id
        }
        return dictionary
    }

}
