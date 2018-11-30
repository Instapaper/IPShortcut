# IPShortcut

[![Version](https://img.shields.io/cocoapods/v/IPShortcut.svg?style=flat)](https://cocoapods.org/pods/IPShortcut)
[![License](https://img.shields.io/cocoapods/l/IPShortcut.svg?style=flat)](https://cocoapods.org/pods/IPShortcut)
[![Platform](https://img.shields.io/cocoapods/p/IPShortcut.svg?style=flat)](https://cocoapods.org/pods/IPShortcut)

![IPShortcut screenshot](/screenshot.png)

## About

IPShortcut lets you easily add UIKeyCommand shortcuts for view controllers displaying information in UITableView, UICollectionView, and UIScrollView. Integration is really straightforward, just make your view controller a subclass of IPShortcutTableViewController, IPShortcutCollectionViewController, or IPShortcutScrollViewController.

After subclassing, your view controller will automatically have arrow key shortcuts to navigate cells (or scroll a scrollview), space and shiftspace to page up or down, and enter to open a cell using the appropriate delegate function.

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

IPShortcut is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IPShortcut'
```

## Author

Brian Donohue, briandonohue@team.instapaper.com

## License

IPShortcut is available under the MIT license. See the LICENSE file for more info.
