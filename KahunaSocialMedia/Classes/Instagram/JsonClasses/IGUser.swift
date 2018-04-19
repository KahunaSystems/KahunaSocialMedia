//
//	IGUser.swift
//
//	Create by Kahuna on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class IGUser: NSObject {

    var biography: String!
    var blockedByViewer: Bool!
    var connectedFbPage: AnyObject!
    var countryBlock: Bool!
    var externalUrl: String!
    var externalUrlLinkshimmed: String!
    var followedBy: IGFollowedBy!
    var followedByViewer: Bool!
    var follows: IGFollowedBy!
    var followsViewer: Bool!
    var fullName: String!
    var hasBlockedViewer: Bool!
    var hasRequestedViewer: Bool!
    var id: String!
    var isPrivate: Bool!
    var isVerified: Bool!
    var media: IGMedia!
    var profilePicUrl: String!
    var profilePicUrlHd: String!
    var requestedByViewer: Bool!
    var username: String!


    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromDictionary dictionary: NSDictionary) {
        biography = dictionary["biography"] as? String
        blockedByViewer = dictionary["blocked_by_viewer"] as? Bool
        connectedFbPage = dictionary["connected_fb_page"] as AnyObject
        countryBlock = dictionary["country_block"] as? Bool
        externalUrl = dictionary["external_url"] as? String
        externalUrlLinkshimmed = dictionary["external_url_linkshimmed"] as? String
        if let followedByData = dictionary["followed_by"] as? [String: Any] {
            followedBy = IGFollowedBy(fromDictionary: followedByData as NSDictionary)
        }
        followedByViewer = dictionary["followed_by_viewer"] as? Bool
        if let followsData = dictionary["follows"] as? [String: Any] {
            follows = IGFollowedBy(fromDictionary: followsData as NSDictionary)
        }
        followsViewer = dictionary["follows_viewer"] as? Bool
        fullName = dictionary["full_name"] as? String
        hasBlockedViewer = dictionary["has_blocked_viewer"] as? Bool
        hasRequestedViewer = dictionary["has_requested_viewer"] as? Bool
        id = dictionary["id"] as? String
        isPrivate = dictionary["is_private"] as? Bool
        isVerified = dictionary["is_verified"] as? Bool
        if let mediaData = dictionary["media"] as? [String: Any] {
            media = IGMedia(fromDictionary: mediaData as NSDictionary)
        }
        profilePicUrl = dictionary["profile_pic_url"] as? String
        profilePicUrlHd = dictionary["profile_pic_url_hd"] as? String
        requestedByViewer = dictionary["requested_by_viewer"] as? Bool
        username = dictionary["username"] as? String
    }

    /**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if biography != nil {
            dictionary["biography"] = biography
        }
        if blockedByViewer != nil {
            dictionary["blocked_by_viewer"] = blockedByViewer
        }
        if connectedFbPage != nil {
            dictionary["connected_fb_page"] = connectedFbPage
        }
        if countryBlock != nil {
            dictionary["country_block"] = countryBlock
        }
        if externalUrl != nil {
            dictionary["external_url"] = externalUrl
        }
        if externalUrlLinkshimmed != nil {
            dictionary["external_url_linkshimmed"] = externalUrlLinkshimmed
        }
        if followedBy != nil {
            dictionary["followed_by"] = followedBy.toDictionary()
        }
        if followedByViewer != nil {
            dictionary["followed_by_viewer"] = followedByViewer
        }
        if follows != nil {
            dictionary["follows"] = follows.toDictionary()
        }
        if followsViewer != nil {
            dictionary["follows_viewer"] = followsViewer
        }
        if fullName != nil {
            dictionary["full_name"] = fullName
        }
        if hasBlockedViewer != nil {
            dictionary["has_blocked_viewer"] = hasBlockedViewer
        }
        if hasRequestedViewer != nil {
            dictionary["has_requested_viewer"] = hasRequestedViewer
        }
        if id != nil {
            dictionary["id"] = id
        }
        if isPrivate != nil {
            dictionary["is_private"] = isPrivate
        }
        if isVerified != nil {
            dictionary["is_verified"] = isVerified
        }
        if media != nil {
            dictionary["media"] = media.toDictionary()
        }
        if profilePicUrl != nil {
            dictionary["profile_pic_url"] = profilePicUrl
        }
        if profilePicUrlHd != nil {
            dictionary["profile_pic_url_hd"] = profilePicUrlHd
        }
        if requestedByViewer != nil {
            dictionary["requested_by_viewer"] = requestedByViewer
        }
        if username != nil {
            dictionary["username"] = username
        }
        return dictionary
    }

}
