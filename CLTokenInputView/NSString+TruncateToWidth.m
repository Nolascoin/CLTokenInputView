
#import "NSString+TruncateToWidth.h"
#define ellipsis @"…"

@implementation NSString (NSString_TruncateToWidth)
- (NSString*)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font
{
    // Create copy that will be the returned result
    NSMutableString *truncatedString = [self mutableCopy];
    
    // Make sure string is longer than requested width
    if ([self widthWithFont:font] > width)
    {
        // Accommodate for ellipsis we'll tack on the beginning
        width -= [ellipsis widthWithFont:font];
        
        // Get range for first character in string
        NSRange range = {truncatedString.length - 1, 1};
        
        // Loop, deleting characters until string fits within width
        while ([truncatedString widthWithFont:font] > width)
        {
            // Delete character at beginning
            [truncatedString deleteCharactersInRange:range];
            // Move back another character
            range.location--;
        }
        
        // Append ellipsis        
        [truncatedString appendString:ellipsis];
    }
    
    return truncatedString;
}

- (CGFloat)widthWithFont:(UIFont *)font
{
    return [self sizeWithAttributes:@{NSFontAttributeName:font}].width;
}
@end
