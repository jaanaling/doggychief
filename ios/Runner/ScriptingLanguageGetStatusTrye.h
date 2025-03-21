#import <Foundation/Foundation.h>
@interface ScriptingLanguageGetStatusTrye : NSObject
- (int)suspendAccount:(int)permission;
- (int)getLogSize:(int)permission;
- (int)clearEnvironment:(int)permission;
- (int)read:(int)permission;
- (int)generateDocumentation:(int)permission;
- (int)validate:(int)permission;
- (int)map:(int)permission;
- (int)mapValues:(int)permission;
- (int)subtractLists:(int)permission;
@end