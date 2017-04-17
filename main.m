#import <Foundation/Foundation.h>
#import "LBLReader.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        LBLReader *reader = [[LBLReader alloc] init];

        for (int i = 1; i < argc; i += 1) {
            NSString *path = [NSString stringWithUTF8String:argv[i]];
            reader.path = path;

            if (!reader.canRead) {
                NSLog(@"Cannot read path: %@", path);
                continue;
            }

            NSLog(@"Can read path: %@", path);
            NSString *line;
            while ( (line = [reader readLine]) ) {
                NSLog(@"%lu => '%@'", reader.lineNumber, line);
            }
        }

    }
    return 0;
}
