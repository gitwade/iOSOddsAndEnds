//
//  UIViewController+IconInTitle.m
//
//    Copyright (c) 2012 Wade Simmons
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//    and associated documentation files (the "Software"), to deal in the Software without restriction,
//    including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial
//    portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "UIViewController+IconInTitle.h"

#define kTitleFontSize 18.0
#define kMinTitleFontSize 15.0
#define kFontSizeDecrement 1.0
#define kMaxTitleWidth 200.0
#define kIconTitleSpacing 4.0
#define kViewHeightPadding 4.0
#define kLabelHeightPadding 2.0

@implementation UIViewController (IconInTitle)

- (void)addIconToTitle:(NSString *)iconName
{
	if (iconName && [iconName isKindOfClass:[NSString class]])
	{
		UIImage *iconImage = [UIImage imageNamed:iconName];
		CGSize iconSize = [iconImage size];
		CGFloat viewHeight = fmax(iconSize.height, kTitleFontSize) + kViewHeightPadding;
		CGFloat labelHeight = kTitleFontSize + kLabelHeightPadding;
		
		UIView *newTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconSize.width + 10.0, viewHeight)];
		UIImageView *iconView = [[UIImageView alloc] initWithImage:iconImage];
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconSize.width, 2.0, 10.0, labelHeight)];
		titleLabel.font = [UIFont boldSystemFontOfSize:kTitleFontSize];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.text = self.navigationItem.title;
		
		CGSize textSize = [titleLabel.text sizeWithFont:titleLabel.font];
        while (textSize.width + iconSize.width + kIconTitleSpacing > kMaxTitleWidth)
        {
            CGFloat fontSize = titleLabel.font.pointSize - kFontSizeDecrement;
            if (fontSize < kMinTitleFontSize)
            {
                break;
            }
            titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
            textSize = [titleLabel.text sizeWithFont:titleLabel.font];
        }
        
        labelHeight = titleLabel.font.pointSize + kLabelHeightPadding;
		
        double totalWidth = fmin(textSize.width + iconSize.width + kIconTitleSpacing, kMaxTitleWidth);
		newTitleView.bounds = CGRectMake(0, 0, totalWidth, viewHeight);
		double textOffset = (newTitleView.frame.size.height - labelHeight) / 2.0;
		if (textOffset < 0) textOffset = 0;
		double textWidth = fmin(textSize.width, kMaxTitleWidth - iconSize.width - kIconTitleSpacing);
		titleLabel.frame = CGRectMake(iconSize.width + kIconTitleSpacing, textOffset, textWidth, labelHeight);
		
		[newTitleView addSubview:iconView];
		[iconView release];
		[newTitleView addSubview:titleLabel];
		[titleLabel release];
		
		[self.navigationItem setTitleView:newTitleView];
		[newTitleView release];
	}
}

@end
