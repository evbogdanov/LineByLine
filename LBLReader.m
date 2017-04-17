#import "LBLReader.h"

static const NSUInteger defaultBufferSize = 8*1024;

@interface LBLReader ()

@property (nonatomic, readwrite) BOOL canRead;
@property (nonatomic, readwrite) NSUInteger lineNumber;
@property (nonatomic) FILE *file;

@end

@implementation LBLReader

- (instancetype)init {
    return [self initWithPath:@""];
}

- (instancetype)initWithPath:(NSString *)path {
    return [self initWithPath:path bufferSize:defaultBufferSize];
}

- (instancetype)initWithPath:(NSString *)path bufferSize:(NSUInteger)bufferSize {
    self = [super init];
    if (self) {
        _bufferSize = bufferSize;

        // No initial file
        _file = NULL;

        // Does much more than just sets a path.
        self.path = path;
    }
    return self;
}

- (void)setPath:(NSString *)path {
    [self closeFile];

    _path = path;
    _lineNumber = 0;
    _canRead = NO;

    if (![[NSFileManager defaultManager] isReadableFileAtPath:path])
        return;

    _file = fopen([path UTF8String], "r");
    if (_file != NULL)
        _canRead = YES;
}

- (void)closeFile {
    if (self.file != NULL)
        fclose(self.file);
}

- (void)dealloc {
    [self closeFile];
}

- (NSString *)readLine {
    // Nothing to read? No line to return.
    if (!self.canRead)
        return nil;

    NSUInteger bufferIndex = 0;
    const NSUInteger bufferSize = self.bufferSize;
    char buffer[bufferSize];
    char ch;

    while (YES) {
        ch = fgetc(self.file);

        // This line is the last.
        if (ch == EOF)
            self.canRead = NO;

        if (ch == EOF || ch == '\n' || bufferIndex == bufferSize-1)
            break;

        buffer[bufferIndex] = ch;
        bufferIndex += 1;
    }
    buffer[bufferIndex] = '\0';

    self.lineNumber += 1;

    return [NSString stringWithUTF8String:buffer];
}

@end
