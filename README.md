For this section, i created a book library that will display your books and their relevant information. 
Following is the design patterns that i've used for this exam:
* MVC: to manage whole project stucture
* Singleton: used in LibraryAPI 
* Facade: used in PersistencyManager to manage logic behind the API
* Category: to present Book detail
* Delegation: to present data to table view and scroll view
* Adapter: help incompatible view like horizontal scrollView work together with Book detail view
* Observer: for loading book cover from internet
 * Notification: to notice when downloading done
 * KVO(Key Value Observing):  to observe when book  cover image changes
* Memento: save app state for next time when user opens app again
* Archiving: save data in local
* Command: use for delete and undo deletion

Note: In this project, HTTP client doesn't make with real server.

#3 Device stability
That project build on xcode 7.2 for iOS 7 and higher

#3 License
This project under MIT license, you can do what ever you want :P
