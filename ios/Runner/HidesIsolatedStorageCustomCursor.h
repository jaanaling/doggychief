#import <Foundation/Foundation.h>
@interface HidesIsolatedStorageCustomCursor : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
- (int)clearEnvironment:(int)permission;
- (int)read:(int)permission;
@end