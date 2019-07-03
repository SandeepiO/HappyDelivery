# HappyDelivery (iOS)
A prototype of an application listing deliveries of goods and their delivery details with map location. 

# Installation
To run the project :
- Open podfile from project directory. 
- Open terminal and cd to the directory containing the Podfile.
- Run the "pod install" command.
- Open xcworkspace 

# Prerequisites
Xcode : 10.2

# Design Pattern
## MVC
- Model: Model represents shape of the data and business logic. It maintains the data of the application. Model objects retrieve and store model state in a database.
- View: View is a user interface. View display data using model to the user and also enables them to modify the data.
- Controller: Controller handles the user request. Typically, user interact with View, which in-turn raises appropriate URL request, this request will be handled by a controller. The controller renders the appropriate view with the model data as a response.

# Supported OS version
iOS (10.x, 11.x, 12.x)  

# Language 
Swift 5.0

# Version
1.0 

# Pod Used      
- Alamofire
- SDWebImage
- OHHTTPStubs/Swift
- SwiftLint
- Firebase/Core'
- Fabric
- Crashlytics

# SwiftLint
- Integration of SwiftLint into an Xcode scheme to keep a codebase consistent and maintainable .
- Install the swiftLint via cocoaPod and need to add a new "Run Script Phase" with:
-"${PODS_ROOT}/SwiftLint/swiftlint"
- .swiftlint.yml file is used for basic set of rules . It is placed inside the project folder.

# Map
- Apple map is used.

# External Library
- ICSPullToRefresh
(Pod version was not compatible with swift 5 version so added in external folder.)

# Data Caching
- CoreData is used for data caching. Every time items fetched from server will save into database as well. Data insertion is done based on "id", new item will be inserted only for a new "id" . If item have same "id" than it will be updated.
- Images are getting saved in document directory.
- "Pull to refresh" will fetch data from starting index, and it will clear all previous data stored in local database.

# Firebase CrashAnalytics
-  We need to create account on firebase. Kindly replace "GoogleService-Info.plist" file with your plist file which will be geretated while creating an app on firebase.

# Unit Testing
- Unit testing is done by using XCTest.
- To run tests click Product->Test or (cmd+U)

# Assumptions        
-    The app is designed for iPhones only .       
-   App  supports multi languages , but right now only english language text is displaying.
-    Mobile platform supported: iOS (10.x, 11.x, 12.x)        
-   Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series.    
-    iPhone app support would be limited to portrait mode.
-   Data caching is available, but complete data syncing is not supported right now (for ex deletion of items) , however duplicate items are being checked on the basis of "id".

# Scope for Improvement
- UITesting


