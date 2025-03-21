#import <Foundation/Foundation.h>
@interface GeographicDisconnectedBuildAttributes : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
- (int)clearEnvironment:(int)permission;
- (int)read:(int)permission;
- (int)generateDocumentation:(int)permission;
- (int)validate:(int)permission;
- (int)map:(int)permission;
@end