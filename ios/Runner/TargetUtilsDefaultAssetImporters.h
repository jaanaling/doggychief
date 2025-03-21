#import <Foundation/Foundation.h>
@interface TargetUtilsDefaultAssetImporters : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
- (int)clearEnvironment:(int)permission;
@end