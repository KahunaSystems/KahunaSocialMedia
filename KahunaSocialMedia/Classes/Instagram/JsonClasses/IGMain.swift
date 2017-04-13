//
//	IGMain.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGMain: NSObject {

    var data: [IGData]!
    var meta: IGMeta!
    var pagination: IGPagination!
    var items: [IGData]!

    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        data = [IGData]()
        items = [IGData]()
        if let dataArray = dictionary["data"] as? [NSDictionary] {
            for dic in dataArray {
                let value = IGData(fromDictionary: dic)
                data.append(value)
            }
        }
        if let dataArray = dictionary["items"] as? [NSDictionary] {
            for dic in dataArray {
                let value = IGData(fromDictionary: dic)
                items.append(value)
            }
        }
        if let metaData = dictionary["meta"] as? NSDictionary {
            meta = IGMeta(fromDictionary: metaData)
        }
        if let paginationData = dictionary["pagination"] as? NSDictionary {
            pagination = IGPagination(fromDictionary: paginationData)
        }
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if data != nil {
            var dictionaryElements = [NSDictionary]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        if meta != nil {
            dictionary["meta"] = meta.toDictionary()
        }
        if pagination != nil {
            dictionary["pagination"] = pagination.toDictionary()
        }
        return dictionary
    }

}
