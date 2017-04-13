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

        static let fetchConfiguration = "rest/mobileconfig/1/get_mobile_configurations"
        static let loginUser = "rest/auth/1/authenticate"
        static let registerUser = "rest/contact/1/citizen_registration"
        static let socialLogin = "rest/contact/1/citizen_signup"
        static let getFAQList = "rest/faq/1/get_faqList"
        static let getFacebookList = "rest/soc/socf/1/feeds/all"
        static let getTwitterList = "rest/soc/soct/1/feeds/all"
        static let getYoutubeList = "rest/soc/socy/1/feeds/all"
        static let serviceDirecotyConfig = "rest/ecmbe/1/get_articleList"
        static let getMySRData = "rest/srapp/1/get_all_sr_data/"
        static let registerDeviceForNotification = "rest/device/1/insert_installed_device"
        static let registerUserForNotification = "rest/device/1/insert_user_device"
        static let logoutService = "rest/auth/1/logout_mobile"
        static let mySrList = "rest/srapp/1/get_SRDetails_from_userid_ir_activitynumber"
        static let mySrDetail = "rest/srapp/1/service_request"
        static let getSourceType = "rest/srapp/1/get_all_sr_sources/en"
        static let submitSR = "cdnbe/ServiceRequest"
        static let getTopSRList = "rest/srapp/1/get_top_services/en"
        static let forgotPassword = "rest/user/1/forgot_password"
        static let updateProfile = "cdnbe/1/update_user_profile"
        static let fetchUserProfile = "rest/contact/1/get_user_profile_image_mobile"
        static let fetchSRTemplate = "rest/srapp/1/retrive_sr_type_template"
        static let changePassswordURL = "rest/user/1/change_password"
        static let gisServiceUrl = "rest/srapp/1/GIS"
        static let validAddressUrl = "rest/srapp/1/GIS/embdb/address/validate"
        static let socialLogin_AuthId = "rest/contact/1/get_user_by_socialAuthId"
        static let getTokenDetails = "rest/device/1/get_token_detail"
        static let getDuplicateSRUrl = "rest/srapp/1/find_duplicate_srs"
        static let duplicateSRDetail = "rest/srapp/1/retrive_Sr_data_from_acno/"

        static let fetchConfigurationFunctionSourceName = "ConfigurationSync"
        static let loginUserFunctionSourceName = "SignIn"
        static let registerUserFunctionSourceName = "SignUp"
        static let socialLoginFunctionSourceName = "SocialSignUp"
        static let getFAQListFunctionSourceName = "FAQ"
        static let serviceDirecotyConfigFunctionSourceName = "ServiceDirectory"
        static let getMySRDataFunctionSourceName = "ServiceRequestSync"
        static let registerDeviceForNotificationFunctionSourceName = "DevicePushNotificationRegistration"
        static let registerUserForNotificationFunctionSourceName = "UserPushNotificationRegistration"
        static let logoutServiceFunctionSourceName = "SignOut"
        static let mySrListFunctionSourceName = "MyServiceRequest"
        static let mySrDetailFunctionSourceName = "MyServiceRequestDetails"
        static let getSourceTypeFunctionSourceName = "GetSourceType"
        static let submitSRFunctionSourceName = "SubmitServiceRequest"
        static let getTopSRListFunctionSourceName = "TopServiceRequestList"
        static let forgotPasswordFunctionSourceName = "ForgotPassword"
        static let updateProfileFunctionSourceName = "ProfileUpdate"
        static let fetchUserProfileFunctionSourceName = "GetUserAccountDetails"
        static let fetchSRTemplateFunctionSourceName = "RetriveServiceRequestTemplate"
        static let changePassswordURLFunctionSourceName = "ChangePassword"
        static let gisServiceUrlFunctionSourceName = "GISService"
        static let validAddressUrlFunctionSourceName = "AddressValidation"
        static let socialLogin_AuthIdFunctionSourceName = "SocialSignUp"
        static let getTokenDetailsFunctionSourceName = "GetTokenDetail"
        static let getDuplicateSRUrlFunctionSourceName = "FindDuplicateServiceRequest"
        static let duplicateSRDetailFunctionSourceName = "FindDuplicateServiceRequestDetail"
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
