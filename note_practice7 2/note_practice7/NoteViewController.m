//
//  NoteViewController.m
//  note_practice7
//
//  Created by user37 on 2018/1/4.
//  Copyright © 2018年 user37. All rights reserved.
//

#import "NoteViewController.h"
#import "ListViewController.h"
@interface NoteViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation NoteViewController
{
    BOOL isNewImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isNewImage = NO;
    self.textView.text = self.note.text;
    self.imageView.image = [self.note image];
}
- (IBAction)camera:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    self.imageView.image = image;
    isNewImage = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender {
    self.note.text = self.textView.text;
    if (isNewImage){
        NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *imagePath = [docPath stringByAppendingPathComponent:self.note.imageName];
        NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.1);
        [imageData writeToFile:imagePath atomically:YES];
    }
    [self.delegate update];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
