//
//	IGImage.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGImage: NSObject {

    var lowResolution: IGLowResolution!
    var standardResolution: IGLowResolution!
    var thumbnail: IGLowResolution!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        if let lowResolutionData = dictionary["low_resolution"] as? NSDictionary {
            lowResolution = IGLowResolution(fromDictionary: lowResolutionData)
        }
        if let standardResolutionData = dictionary["standard_resolution"] as? NSDictionary {
            standardResolution = IGLowResolution(fromDictionary: standardResolutionData)
        }
        if let thumbnailData = dictionary["thumbnail"] as? NSDictionary {
            thumbnail = IGLowResolution(fromDictionary: thumbnailData)
        }
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if lowResolution != nil {
            dictionary["low_resolution"] = lowResolution.toDictionary()
        }
        if standardResolution != nil {
            dictionary["standard_resolution"] = standardResolution.toDictionary()
        }
        if thumbnail != nil {
            dictionary["thumbnail"] = thumbnail.toDictionary()
        }
        return dictionary
    }

}
