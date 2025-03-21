#import <Foundation/Foundation.h>
@interface CheckCacheCallbackFunctionAsRef : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
@end