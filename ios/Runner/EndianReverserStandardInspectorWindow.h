#import <Foundation/Foundation.h>
@interface EndianReverserStandardInspectorWindow : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
- (int)clearEnvironment:(int)permission;
@end