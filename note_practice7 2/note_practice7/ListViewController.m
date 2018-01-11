//
//  ListViewController.m
//  note_practice7
//
//  Created by user37 on 2018/1/4.
//  Copyright © 2018年 user37. All rights reserved.
//
#import "AppDelegate.h"
#import "ListViewController.h"
#import "Note.h"
#import "NoteViewController.h"
@interface ListViewController ()<UITableViewDataSource,NoteViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray <Note*> *data;
@end

@implementation ListViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //self.data = [NSMutableArray array];
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = appdelegate.persistentContainer.viewContext;
        NSFetchRequest* fetchRquest = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
        NSError *error = nil;
        NSArray *resource=[context executeFetchRequest:fetchRquest error:&error];
        if (error) {
            self.data = [NSMutableArray array];
        }
        else{
            self.data = [NSMutableArray arrayWithArray:resource];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.tableView.dataSource = self;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}
- (IBAction)add:(id)sender {
    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appdelegate.persistentContainer.viewContext;//創物件
    Note* note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];//去撈ＳＱＬ資料
    NSString* id = [[NSUUID UUID]UUIDString];
    note.imageName = [id stringByAppendingString:@".jpg"];
    note.text = @"NEW";
    [self.data addObject:note];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.data.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self save];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"noteCell" forIndexPath:indexPath];
    Note *note = self.data[indexPath.row];
    cell.textLabel.text = note.text;
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appdelegate.persistentContainer.viewContext;
    [context deleteObject:self.data[indexPath.row]];
    [self save];
    [self.data removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}
-(void) save {
    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appdelegate.persistentContainer.viewContext;
    NSError *error = nil;
    [context save:&error];
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(void) update {
    [self.tableView reloadData];
    [self save];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toNote"]){
        NoteViewController *noteVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        noteVC.note = self.data[indexPath.row];
        noteVC.delegate = self ;
    }
}


@end
