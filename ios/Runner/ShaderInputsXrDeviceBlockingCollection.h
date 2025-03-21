#import <Foundation/Foundation.h>
@interface ShaderInputsXrDeviceBlockingCollection : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
- (int)clearEnvironment:(int)permission;
- (int)read:(int)permission;
- (int)generateDocumentation:(int)permission;
- (int)validate:(int)permission;
- (int)map:(int)permission;
- (int)mapValues:(int)permission;
- (int)subtractLists:(int)permission;
- (int)slice:(int)permission;
- (int)clear:(int)permission;
- (int)resumeSubscription:(int)permission;
- (int)rotate:(int)permission;
- (int)initializeEnvironment:(int)permission;
- (int)deserialize:(int)permission;
@end