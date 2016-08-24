//
//  RefsViewController.m
//  CC Madrid Sur
//
//  Created by José Carlos on 29/7/15.
//
//

#import "RefsViewController.h"
#import "REFS.h"
#import "REFSElement.h"
#import "REFSCell.h"

@interface RefsViewController ()

@end

@implementation RefsViewController

-(id)init{
    self = [super initWithNibName:@"RefsViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    self.events = [REFS windowElements];
    if (self.events != nil && self.events.count != 0) {
        [self.tableView reloadData];
        self.tableView.backgroundView = nil;
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:self.tableView.backgroundView.bounds];
        label.numberOfLines = 0;
        label.text = @"No hay ofertas\nactivas";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        
        self.tableView.backgroundView = label;
    }
    NSLog(@"events = %@", self.events);}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(IBAction)goBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark JSON Parser
-(NSMutableDictionary*)getDictionaryFromJsonString:(NSString*)jsonString{
    NSError *error;
    NSMutableDictionary * jsonObj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    return jsonObj;
}


#pragma mark tableViewDelegate
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *dealIdentifier = @"cellDeal";
    REFSCell *cell = (REFSCell*)[tableView dequeueReusableCellWithIdentifier:dealIdentifier];
    if (cell==nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"REFSCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    REFSElement *elementREFS = [self.events objectAtIndex:indexPath.row];
    cell.REFSTitle.text = [[self getDictionaryFromJsonString:elementREFS.params ] objectForKey:@"wndw_title"];
    cell.REFSSubtitle.text = [[self getDictionaryFromJsonString:elementREFS.params ] objectForKey:@"wndw_msg"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    REFSElement *elementREFS = [self.events objectAtIndex:indexPath.row];
    NSString *windowNid = [[self getDictionaryFromJsonString:elementREFS.params ]  objectForKey:@"wndw_nid"];
    if (windowNid && [windowNid respondsToSelector:@selector(longLongValue)]) {
        [REFS elementSelected:[windowNid longLongValue]];
        //_lastElement = [events objectAtIndex:indexPath.row];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Oferta no disponible"
                                                       delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
    }
    self.events = [REFS windowElements];
    //NSLog(@"sale list = %@", saleList);
    [tableView reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.events count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
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
