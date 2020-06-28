# Movies

### Description
*Movies* is an iOS application built with __MVP (Model View Presenter)__ and __Clean Architecture__ concepts.
Each scene presentation logics is divided into 4 separate layers.

*MVP concepts*: 

* __View__ - __ViewController__ is presented as a dummy view. No business logics go inside it.
* __Presenter__ contains the presentation logic and tells the View what to present.
* __Configurator__ injects the dependency object graph into the scene (view controller).
* __Router__ contains navigation / flow logic from one scene (view controller) to another.

*Clean Architecture__ concepts*: 

* __Use Case__ contains the application / business logic for a specific use case in application.
* __Gateway__  contains actual implementation of the protocols defined in the Application Logic layer.

### Run Requirements

* Xcode 10.2.1
* Swift 5

### Target iOS Version

* iOS 10

### 3rd Party Libraries

* SDWebImage
