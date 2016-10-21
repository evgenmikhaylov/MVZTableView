# RSBTableViewManager #

* This manager encapsulate all `UITableView` stuff and allow you to work only with section items - objects that adopt `RSBTableViewSectionItemProtocol` and represent sections of `UITableView`. This section items contains cell items - objects that adopt `RSBTableViewCellItemProtocol` and represent cells of `UITableView`. You will never need to write any `UITableViewDelegate` or `UITableViewDataSource` methods in your `UIViewController` class.
* Version 0.0.2

### Install via Cocoapods ###

You need to add source first.
```
source 'https://bitbucket.org/rosberryteam/cocoapodsspecs.git'
```
Then add
```
pod 'RSBTableViewManager'
```
to your `Podfile` and run
```
pod install
```

### How to use ###
Download repo and run example project.

RSBTableViewManager works with section items, which contains cell items. So you need to do next steps for beginning:

1. Subclass `RSBTableViewSectionItem` or create/use your own class which will adopt `RSBTableViewSectionItemProtocol` for section items
2. Subclass `RSBTableViewCellItem` or create/use your own class which will adopt `RSBTableViewCellItemProtocol` for cell items.

Each cell item represents one cell class at time and contains all related datasource and delegate methods for right displaying it. 

When you will finish with setting up your section and (or) cell items you will need to create instance of `RSBTableViewManager` with your `UITableView` and set your section items to property `sectionItems` and thats it.