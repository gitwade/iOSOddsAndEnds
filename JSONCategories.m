//
//  JSONCategories.m
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



#import "JSONCategories.h"

@implementation NSObject (NSObject_NSJSONSerialization)
- (NSString *)JSONString
{
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        NSString *json = [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSData *)JSONData
{
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *jsonParsingError = nil;
        NSData *json = [NSJSONSerialization dataWithJSONObject:self options:0 error:&jsonParsingError];
        if (jsonParsingError)
        {
            NSLog(@"JSON Parsing Error: %@", jsonParsingError);
        }
        return json;
    }
    return nil;
    
}

- (NSString *)JSONRepresentation
{
    return [self JSONString];
}
@end

@implementation NSString (NSString_NSJSONSerialization)
- (id)JSONValue
{
    NSError *jsonParsingError = nil;
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:JSONData
                                              options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                                error:&jsonParsingError];
    if (jsonParsingError)
    {
        NSLog(@"JSON Parsing Error: %@", jsonParsingError);
    }
    return json;
}
@end

@implementation NSData (NSData_NSJSONSerialization)
- (id)JSONValue
{
    NSError *jsonParsingError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:self
                                              options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                                error:&jsonParsingError];
    if (jsonParsingError)
    {
        NSLog(@"JSON Parsing Error: %@", jsonParsingError);
    }
    return json;
}
@end
