//
//  Note.m
//  note_practice7
//
//  Created by user37 on 2018/1/4.
//  Copyright © 2018年 user37. All rights reserved.
//

#import "Note.h"

@implementation Note
@dynamic text;
@dynamic imageName;
-(UIImage *)image{
    NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *imagePath = [docPath stringByAppendingPathComponent:self.imageName];
    return [UIImage imageWithContentsOfFile:imagePath];
}
@end
