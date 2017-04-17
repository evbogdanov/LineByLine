#import <Foundation/Foundation.h>

@interface LBLReader : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic) NSUInteger bufferSize;
@property (nonatomic, readonly) BOOL canRead;
@property (nonatomic, readonly) NSUInteger lineNumber;

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithPath:(NSString *)path bufferSize:(NSUInteger)bufferSize;
- (NSString *)readLine;

@end
