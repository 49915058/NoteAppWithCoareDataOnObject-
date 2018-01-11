//
//  Note.h
//  note_practice7
//
//  Created by user37 on 2018/1/4.
//  Copyright © 2018年 user37. All rights reserved.
//

#import <CoreData/CoreData.h>
@import UIKit;
@interface Note : NSManagedObject
@property NSString* text;
@property NSString* imageName;
-(UIImage*) image;
@end
