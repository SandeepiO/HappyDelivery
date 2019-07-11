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
-CoreDataHelper: CoreDataHelper is used to save, retrive and delete the data in core data.
-DataManager: DataManager is used to check the data is available on local storage then share it with controller and if not available then request it from Webservices to get the data from server.
-WebServices: WebServices is used to fetch the data from the server using alamofire.

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

# Assumptions        
-    The app is designed for iPhones only .       
-   App  supports multi languages , but right now only english language text is displaying.
-    Mobile platform supported: iOS (10.x, 11.x, 12.x)        
-   Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series.    
-    iPhone app support would be limited to portrait mode.
-   Data caching is available, but complete data syncing is not supported right now (for ex deletion of items) , however duplicate items are being checked on the basis of "id".

# Features
- Showing the list of delivery data, and on click on it shows the detail of delivery data with map.
- Used core data to store the data on local storage.
- Used pull to refresh to fetch new data from server and if data is not available or internet connectivity is unavailable then show the previous stored data, if data is fetched then remove the previous store data from model and core data and populate the new list.
- Pagination is used to fetch the new page data from server and if data is available then store the new data in model and core data, populate the list with new data. If data is not availble then keep the list as it is.

# SwiftLint
- Integration of SwiftLint into an Xcode scheme to keep a codebase consistent and maintainable .
- Install the swiftLint via cocoaPod and need to add a new "Run Script Phase" with:
-"${PODS_ROOT}/SwiftLint/swiftlint"
- .swiftlint.yml file is used for basic set of rules . It is placed inside the project folder.

# Map
- Apple map is used.

# Data Caching
- CoreData is used for data caching. Every time items fetched from server will save into database as well. Data insertion is done based on "id", new item will be inserted only for a new "id" . If item have same "id" than it will not perform any action.
- "Pull to refresh" will fetch data from starting index, and it will clear all previous data stored in local database, and if internet is not available then show the pop up alert and keep the previous data.

# Firebase CrashAnalytics
-  We need to create account on firebase. Kindly replace "GoogleService-Info.plist" file with your plist file which will be geretated while creating an app on firebase.

# Unit Testing
- Unit testing is done by using XCTest.
- To run tests click Product->Test or (cmd+U)

# Scope for Improvement
- UITesting

# ScreenShot

![Simulator Screen Shot - iPhone Xʀ - 2019-07-04 at 12 09 22](https://user-images.githubusercontent.com/46416595/60644834-d46f0d80-9e54-11e9-84a1-d5f22ece9085.png)
![Simulator Screen Shot - iPhone Xʀ - 2019-07-04 at 12 09 48](https://user-images.githubusercontent.com/46416595/60644850-df29a280-9e54-11e9-8269-91f14f4a669e.png)
![Simulator Screen Shot - iPhone Xʀ - 2019-07-04 at 12 09 42](https://user-images.githubusercontent.com/46416595/60644843-db961b80-9e54-11e9-9901-4d8faf45452a.png)
