//
//  DWTWaveListInfoChunk.m
//  WaveTools
//
//  Created by Ben Cox on 7/17/12.
//  Copyright 2012 Ben Cox. All rights reserved.
//


#import "DWTWaveListInfoChunk.h"
#import "NSData+WaveToolsExtensions.h"
#import "WaveToolsLocalization.h"


@implementation DWTWaveListInfoChunk

+ (NSData*) emptyChunkData
{
    static unsigned char s_emptyChunkBytes[] = {
        'L', 'I', 'S', 'T', 4, 0, 0, 0,
        'I', 'N', 'F', 'O'
    };
    static NSData* s_emptyChunkData = nil;
    static dispatch_once_t s_emptyChunkOnce;
    dispatch_once(&s_emptyChunkOnce, ^{
        s_emptyChunkData = [[NSData alloc] initWithBytesNoCopy:&s_emptyChunkBytes[0] length:sizeof(s_emptyChunkBytes) freeWhenDone:NO];
    });
    return s_emptyChunkData;
}

+ (BOOL) canHandleChunkWithData:(NSData*)data
{
    NSString* subtype = [data read4CharAtOffset:kDWTWaveChunkHeaderSize];
    return ([subtype caseInsensitiveCompare:@"INFO"] == NSOrderedSame);
}

+ (NSUInteger) autoProcessSubchunkOffset
{
    // The first bit is INFO and then subchunks.
    return 4;
}

- (NSString*) moreInfo
{
    return DWTLocalizedString(@"INFO", @"list-info chunk subtype name");
}

@end
