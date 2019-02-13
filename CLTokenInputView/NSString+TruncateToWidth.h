//
//  NSString+NSString_TruncateToWidth.h
//  CLTokenInputView
//
//  Created by Alex Nolasco on 2/13/19.
//

@import Foundation;
@import UIKit;

@interface NSString (NSString_TruncateToWidth)
- (NSString*)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font;
@end


