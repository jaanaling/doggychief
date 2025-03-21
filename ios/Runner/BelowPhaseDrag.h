#import <Foundation/Foundation.h>
@interface BelowPhaseDrag : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
- (int)clearEnvironment:(int)permission;
- (int)read:(int)permission;
- (int)generateDocumentation:(int)permission;
@end