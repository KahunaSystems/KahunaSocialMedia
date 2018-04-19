//
//	IGNode.swift
//
//	Create by Kahuna on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGNode: NSObject {

    var typename: String!
    var caption: String!
    var code: String!
    var comments: IGFollowedBy!
    var commentsDisabled: Bool!
    var date: Int!
    var dimensions: IGDimension!
    var displaySrc: String!
    var gatingInfo: AnyObject!
    var id: String!
    var isVideo: Bool!
    var likes: IGFollowedBy!
    var mediaPreview: String!
    var owner: IGOwner!
    var thumbnailResources: [IGThumbnailResource]!
    var thumbnailSrc: String!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        typename = dictionary["__typename"] as? String
        caption = dictionary["caption"] as? String
        code = dictionary["code"] as? String
        if let commentsData = dictionary["comments"] as? [String: Any] {
            comments = IGFollowedBy(fromDictionary: commentsData as NSDictionary)
        }
        commentsDisabled = dictionary["comments_disabled"] as? Bool
        date = dictionary["date"] as? Int
        if let dimensionsData = dictionary["dimensions"] as? [String: Any] {
            dimensions = IGDimension(fromDictionary: dimensionsData as NSDictionary)
        }
        displaySrc = dictionary["display_src"] as? String
        gatingInfo = dictionary["gating_info"] as AnyObject
        id = dictionary["id"] as? String
        isVideo = dictionary["is_video"] as? Bool
        if let likesData = dictionary["likes"] as? [String: Any] {
            likes = IGFollowedBy(fromDictionary: likesData as NSDictionary)
        }
        mediaPreview = dictionary["media_preview"] as? String
        if let ownerData = dictionary["owner"] as? [String: Any] {
            owner = IGOwner(fromDictionary: ownerData as NSDictionary)
        }
        thumbnailResources = [IGThumbnailResource]()
        if let thumbnailResourcesArray = dictionary["thumbnail_resources"] as? [[String: Any]] {
            for dic in thumbnailResourcesArray {
                let value = IGThumbnailResource(fromDictionary: dic as NSDictionary)
                thumbnailResources.append(value)
            }
        }
        thumbnailSrc = dictionary["thumbnail_src"] as? String
    }

    /**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if typename != nil {
            dictionary["__typename"] = typename
        }
        if caption != nil {
            dictionary["caption"] = caption
        }
        if code != nil {
            dictionary["code"] = code
        }
        if comments != nil {
            dictionary["comments"] = comments.toDictionary()
        }
        if commentsDisabled != nil {
            dictionary["comments_disabled"] = commentsDisabled
        }
        if date != nil {
            dictionary["date"] = date
        }
        if dimensions != nil {
            dictionary["dimensions"] = dimensions.toDictionary()
        }
        if displaySrc != nil {
            dictionary["display_src"] = displaySrc
        }
        if gatingInfo != nil {
            dictionary["gating_info"] = gatingInfo
        }
        if id != nil {
            dictionary["id"] = id
        }
        if isVideo != nil {
            dictionary["is_video"] = isVideo
        }
        if likes != nil {
            dictionary["likes"] = likes.toDictionary()
        }
        if mediaPreview != nil {
            dictionary["media_preview"] = mediaPreview
        }
        if owner != nil {
            dictionary["owner"] = owner.toDictionary()
        }
        if thumbnailResources != nil {
            var dictionaryElements = [NSDictionary]()
            for thumbnailResourcesElement in thumbnailResources {
                dictionaryElements.append(thumbnailResourcesElement.toDictionary())
            }
            dictionary["thumbnail_resources"] = dictionaryElements
        }
        if thumbnailSrc != nil {
            dictionary["thumbnail_src"] = thumbnailSrc
        }
        return dictionary
    }

}
