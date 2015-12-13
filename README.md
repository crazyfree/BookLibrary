# Introduction
For this demonistration, i created a book library that will display your books and their relevant information. 
Following is the design patterns that i've used for this exam:
* MVC: to manage whole project stucture
* Singleton: used in LibraryAPI 
* Facade: used in PersistencyManager to manage logic behind the API
* Category: to present Book detail
* Delegation: to present data to table view and scroll view
* Adapter: helping incompatible view like horizontal scrollView works together with Book detail view
* Observer: for loading book cover from internet
 * Notification: to notice when downloading done
 * KVO(Key Value Observing):  to observe when book  cover image changes
* Memento: saving app state for next time when user opens app again
* Archiving: saving data in local
* Command: to use for deletion and undo deletion

Note: In this project, HTTP client doesn't make with real server.

### Device stability
That project build on xcode 7.2 for all devices that use iOS 7 and higher

### Testing
Project just imports unit test for API and UI test (undone yet)

### License
This project under MIT license, you can do what ever you want :P
