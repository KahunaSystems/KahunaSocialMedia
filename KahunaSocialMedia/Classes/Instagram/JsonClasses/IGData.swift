//
//	IGData.swift
//
//	Create by Kahuna on 13/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class IGData: NSObject {

    var attribution: String!
    var caption: IGCaption!
    var comments: IGComment!
    var createdTime: String!
    var filter: String!
    var id: String!
    var images: IGImage!
    var likes: IGComment!
    var link: String!
    var location: IGLocation!
    var tags: [AnyObject]!
    var type: String!
    var user: IGFrom!
    var userHasLiked: Bool!
    var usersInPhoto: [IGUsersInPhoto]!

    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        if let attribute = dictionary["attribution"] as? String {
            attribution = attribute
        }
        if let captionData = dictionary["caption"] as? NSDictionary {
            caption = IGCaption(fromDictionary: captionData)
        }
        if let commentsData = dictionary["comments"] as? NSDictionary {
            comments = IGComment(fromDictionary: commentsData)
        }
        createdTime = dictionary["created_time"] as? String
        filter = dictionary["filter"] as? String
        id = dictionary["id"] as? String
        if let imagesData = dictionary["images"] as? NSDictionary {
            images = IGImage(fromDictionary: imagesData)
        }
        if let likesData = dictionary["likes"] as? NSDictionary {
            likes = IGComment(fromDictionary: likesData)
        }
        link = dictionary["link"] as? String
        if let locationData = dictionary["location"] as? NSDictionary {
            location = IGLocation(fromDictionary: locationData)
        }
        tags = dictionary["tags"] as? [AnyObject]
        type = dictionary["type"] as? String
        if let userData = dictionary["user"] as? NSDictionary {
            user = IGFrom(fromDictionary: userData)
        }
        userHasLiked = dictionary["user_has_liked"] as? Bool
        usersInPhoto = [IGUsersInPhoto]()
        if let usersInPhotoArray = dictionary["users_in_photo"] as? [NSDictionary] {
            for dic in usersInPhotoArray {
                let value = IGUsersInPhoto(fromDictionary: dic)
                usersInPhoto.append(value)
            }
        }
    }

    /**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if attribution != nil {
            dictionary["attribution"] = attribution
        }
        if caption != nil {
            dictionary["caption"] = caption.toDictionary()
        }
        if comments != nil {
            dictionary["comments"] = comments.toDictionary()
        }
        if createdTime != nil {
            dictionary["created_time"] = createdTime
        }
        if filter != nil {
            dictionary["filter"] = filter
        }
        if id != nil {
            dictionary["id"] = id
        }
        if images != nil {
            dictionary["images"] = images.toDictionary()
        }
        if likes != nil {
            dictionary["likes"] = likes.toDictionary()
        }
        if link != nil {
            dictionary["link"] = link
        }
        if location != nil {
            dictionary["location"] = location.toDictionary()
        }
        if tags != nil {
            dictionary["tags"] = tags
        }
        if type != nil {
            dictionary["type"] = type
        }
        if user != nil {
            dictionary["user"] = user.toDictionary()
        }
        if userHasLiked != nil {
            dictionary["user_has_liked"] = userHasLiked
        }
        if usersInPhoto != nil {
            var dictionaryElements = [NSDictionary]()
            for usersInPhotoElement in usersInPhoto {
                dictionaryElements.append(usersInPhotoElement.toDictionary())
            }
            dictionary["users_in_photo"] = dictionaryElements
        }
        return dictionary
    }

}
