//
//  Constants.swift
//  MyCity311
//
//  Created by Piyush on 6/2/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

    static let k_AllowToSendServerLogs = true

    static let AllowSRSubmitDetailsView: Bool = false
    static let kTweetUrl = "https://api.twitter.com/1.1/lists/statuses.json";
    static let kYoutubeUrl = "http://gdata.youtube.com/feeds/base/users/antoniovillaraigosa/uploads?orderby=updated&max-results=15"
    static let kFacebookURL = "https://graph.facebook.com/oauth/access_token?client_id=%@&client_secret=%@&grant_type=client_credentials"

    enum ServiceEndPoints {

        static let getFacebookList = "rest/soc/socf/1/feeds/all"
        static let getTwitterList = "rest/soc/soct/1/feeds/all"
        static let getYoutubeList = "rest/soc/socy/1/feeds/all"

        static let getFacebookListFunctionSourceName = "FacebookList"
        static let getTwitterListFunctionSourceName = "TwitterList"
        static let getYoutubeListFunctionSourceName = "YoutubeList"
    }

    enum coreDataTableKeys {
        static let kFacebookFeedInfo = "FacebookFeedInfo"
        static let kTwitterFeedInfor = "TweetInfo"
        static let kYoutubeInterface = "YoutubeInterface"
    }

    enum TimeOutIntervals {

        static let kSRRetryCount = 3
        static let kMaxRetryCount = 3
        static let kSRTimeoutInterval = 60
        static let kMaxTimeoutInterval = 240
        static let cacheImageTimeOut = 30.0

        static let kMaxLocationWaitTime = 10
        static let kMinHorizontalAccuracy = 100

        static let horizontalLocationAccuracy = 70
        static let maximumWaitTimeForLocation = 10
        static let defaultImageCompressionValue = 0.7

        static let queryPageSize = 10
    }

    enum UnidentifiedError: ErrorType {
        case emptyHTTPResponse
    }

    enum ServerResponseCodes {
        static let successCode: Int = 200
        static let noRecordFoundSocialUser = 224
        static let emailVerificationPending: Int = 229

        static let emailAlreadyExist: Int = 233
        static let tokenExpireCode: Int = 234
        static let SessionExpireCode: Int = 234

        static let generalExceptionCode: Int = 520
        static let invalidGISAddress: Int = 535

        static let multipleServiceCallError: Int = -999

        static let invalidCredential: Int = 210
        static let emailNotExist: Int = 301
        static let inappropriateDataCode: Int = 400

    }

}
