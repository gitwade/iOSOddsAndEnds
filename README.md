iOSOddsAndEnds
==============

Odds and ends that might be useful for iOS apps
They are typically useful as-is, but could use some refining.

UIViewController (IconInTitle) category:
 * UIViewController+IconInTitle.h
 * UIViewController+IconInTitle.m

	When using a UIViewController who's title appears in a Navigation Bar (like in UINavigationController), 
	this is a handy category that will add an Icon to the front of the title.
	Just call the addIconToTitle method passing in the name of the icon.

JSONCategories:
 * JSONCategories.h
 * JSONCategories.m

	Convenient categories on NSObject and NSString that use NSJSONSerialization to convert between
	JSON objects and string representations of those objects. 
