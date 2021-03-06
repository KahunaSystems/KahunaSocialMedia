# KahunaSocialMedia

![LogCamp](http://www.kahuna-mobihub.com/templates/ja_puresite/images/logo-trans.png)

KahunaSocialMedia is written in Swift

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

KahunaSocialMedia is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KahunaSocialMedia', :tag => '1.2.1'
```
> New development will happen exclusively on the master/Swift 3 branch.
> _Note:_ You need to update your latest xcode name by Xcode.app and it should by in your Application folder


## Set Server URL
```swift
let socialHandler = SocialOperationHandler.sharedInstance
socialHandler.socialDelegate = self
socialHandler.initServerBaseURL(serverBaseURL: kServerBaseURL)
```
## To fetch from our server or social media server 
```swift
socialHandler.isLoadFromServer = true (i.e. our server and false for social media server)
```

Note:
Add import KahunaSocialMedia into respected file
 
## Retrieve Twitter Feeds from twitter server or from our server

```swift
socialHandler.initAllTwitterKeys(twitterURL: kTwitterURL, tweetAccessToken: kTweetAccessToken, tweetSecretKey: kTweetAccessTokenSecret, tweetConsumerKey: kTweetConsumerKey, tweetConsumerSecret: kTweetConsumerSecret, tweetOwnerSecretName: kTweetOwnerScreenName, tweetSlugName: kTweetSlugName)
socialHandler.getTwitterFeeds() 
  ```
  
   
## Retrieve Facebook Feeds from facebook server or from our server

```swift
socialHandler.initAllFacebookKeys(fbGraphURL: kFbGraphURL, fbFromName: kFbFromName, fbAppSecret: kFbAppSecret, fbAppID: kFbAppID)
socialHandler.getFacebookFeeds()
  ```
   
## Retrieve Instagram Feeds from instagram server or from our server

```swift
socialHandler.initAllInstagramKeys(instaURL: instaURL)
socialHandler.getInstagramFeeds()
  ```
 
## Retrieve Youtube Feeds from youtube server or from our server
Retrieve based on user channel
```swift
socialHandler.initAllYoutubeKeys(youTubeURL: kYoutubeUrl, youTubeAPIKey: kYoutubeAPIKey, youTubeUser: kYouTubeUser, videosCountForSubscriptionChannel: kVideosCountForSubscriptionChannel, countForSubscribedChannel: kCountForSubscribedChannel, userChannelId: kUserChannelId, userChannelOnly:true , isLoadFromSubscriptions: "false")
socialHandler.getYouTubeFeeds()
  ```
Retrieve based on user subscriptions channel
```swift
socialHandler.initAllYoutubeKeys(youTubeURL: kYoutubeUrl, youTubeAPIKey: kYoutubeAPIKey, youTubeUser: kYouTubeUser, videosCountForSubscriptionChannel: kVideosCountForSubscriptionChannel, countForSubscribedChannel: kCountForSubscribedChannel, userChannelId: "", userChannelOnly:false , isLoadFromSubscriptions: isLoadFromSubscriptions)
socialHandler.getYouTubeFeeds()
  ```
  
## Fetch feeds from Kahunasocialmedia db 
```swift
SocialOperationHandler.sharedInstance.fetchedInstagramFeedsFromDB()
SocialOperationHandler.sharedInstance.fetchedTwitterFeedsFromDB()
SocialOperationHandler.sharedInstance.fetchedFacebookFeedsFromDB()
SocialOperationHandler.sharedInstance.fetchedYoutubeFeedsFromDB()
  ```
  
  ## Installation

> _Note:_ KahunaSocialMedia requires Swift 3 (and Xcode 8) or greater. If you absolutely
> need compatibility with Swift 2.3 you can use the swift2.3 branch by adding following line to your Podfile with reference code in github: https://github.com/kahunasystems/KahunaSocialMedia 
```ruby
pod 'KahunaSocialMedia', '~> 0.1.15'
```

<!--## Document URL for detail information of library
> _Note:_ https://docs.google.com/document/d/1khLshiLCzwNXeC8shuySuYqTyxZ1IOakWTRBcszacwA/edit?usp=sharing
-->
## Author

siddharthchopra, siddharth.chopra@kahunasystems.com

## License

KahunaSocialMedia is available under the MIT license. See the LICENSE file for more info.
