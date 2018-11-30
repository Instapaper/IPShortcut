Pod::Spec.new do |s|
  s.name             = 'IPShortcut'
  s.version          = '0.1.0'
  s.summary          = 'Easily setup shortcuts for tables and collections for iPad Smart Keyboards.'

  s.description      = <<-DESC
IPShortcut lets you easily add UIKeyCommand shortcuts for view controllers displaying information in UITableView, UICollectionView, and UIScrollView. Integration is really straightforward, just make your view controller a subclass of IPShortcutTableViewController, IPShortcutCollectionViewController, or IPShortcutScrollViewController.
                       DESC

  s.homepage         = 'https://github.com/Instapaper/IPShortcut'
  s.screenshots     = 'https://i.imgur.com/LZAafLt.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Brian Donohue' => 'brian@team.instapaper.com' }
  s.source           = { :git => 'https://github.com/Instapaper/IPShortcut.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/instapaper'

  s.ios.deployment_target = '9.0'

  s.source_files = 'IPShortcut/Classes/**/*'
  s.frameworks = 'UIKit'
end
