//
//  RefsViewController.h
//  CC Madrid Sur
//
//  Created by José Carlos on 29/7/15.
//
//

#import <UIKit/UIKit.h>

@interface RefsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *events;

-(IBAction)goBack:(id)sender;

@end
