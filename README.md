# LineByLine

## To compile
```
$ make
```

## To test
```
$ make test
```

## To use in your code
```
#import "LBLReader.h"

LBLReader *reader = [[LBLReader alloc] initWithPath:@"/path/to/file"];

NSString *line;
while ( (line = [reader readLine]) ) {
    NSLog(@"%lu => '%@'", reader.lineNumber, line);
}
```
