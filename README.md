MSPageViewController
====================

## Description:
Did you ever want to implement a simple ```UIPageViewController``` and realized that you had to do it all by code?
With ```MSPageViewController``` you will be able to design each page from a single storyboard!

![Example Storyboard](Images/image1.png "Example Storyboard")

## How to Use:

Create a storyboard, add a ```UIPageViewController``` object and change its class to ```MSPageViewController```.
Add a user-defined runtime attribute called ``ms_pages``` of type NSString. Provide a comma-separated list of ```pageIdentifiers```.
Then you can add the controllers, setting their ```Storyboard ID```s to what you provided in ```pageIdentifiers```.
Each of them must be a class that conforms to ```MSPageViewControllerChild``` (if you don't need to add any extra functionality to it you can use [```MSPageViewControllerPage```](MSPageViewController/Source/MSPageViewControllerPage.h)).

When your controller is instantiated, it will use these controllers to create each page.

Optionally, you can create a [subclass of ```MSPageViewController```](MSPageViewController/Source/MSPageViewController+Protected.h) and override ```-pageIdentifiers```. This will override the ```self.ms_pages``` property. Example:
```objc
- (NSArray *)pageIdentifiers {
	return @[@"page1", @"page2"];
}
```

There is also the ```BOOL``` ```ms_transparentControl``` runtime attribute, it allows for full-screen view controllers, with a translucent UIPageControl on top of it instead of a fixed bar on the bottom.

Make sure you also check out the sample project in this repo.

## Alternate use:
If you need all your pages to look the same, but providing different data, you can create a single page in the storyboard and return it as many times as you need:
```objc
- (NSArray *)pageIdentifiers {
	return @[@"page1", @"page1", @"page1"];
}
```

Then in your ```MSPageViewController``` subclass you can override this method to configure each page:
```objc
- (void)setUpViewController:(MyCustomControllerPage *)page
                    atIndex:(NSInteger)index  {
	[super setUpViewController:page atIndex:index];

	page.customData = [self dataForPageAtIndex:index];
}
```

## Instalation:
- Using [Cocoapods](http://cocoapods.org/):

Just add this line to your `Podfile`:

```
pod 'MSPageViewController', '~> 1.0.0'
```

- Manually:

Simply add the files under [Source](MSPageViewController/Source) to your project.

## Compatibility

- Requires ARC. If you want to use it in a project without ARC, mark the implementation files with the linker flag ```-fobjc-arc```.
- Supports iOS iOS6+.

## License
`MSPageViewController` is available under the WTFPL license. See the [LICENSE file](LICENSE) for more info.
