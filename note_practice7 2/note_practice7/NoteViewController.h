//
//  NoteViewController.h
//  note_practice7
//
//  Created by user37 on 2018/1/4.
//  Copyright © 2018年 user37. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@protocol NoteViewControllerDelegate
-(void)update;
@end
@interface NoteViewController : UIViewController
@property (nonatomic) Note* note;
@property (nonatomic,weak) id <NoteViewControllerDelegate> delegate;
@end
