//
//  DetailViewController.m
//  App
//
//  Created by Thiago Guimaraes on 2/23/16.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "Sherpa.h"
#import "DataLoad.h"
#import "PhotoViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController


AlbumDataModel *_albumDataModel;
NSArray *_feedItems;
NSArray *filtered;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = self.sherpa.title;
    self.prepTimeLabel.text = [NSString stringWithFormat:@"%@",self.sherpa.userId];
    self.recipeImageView.image = [UIImage imageNamed:@"album.jpg"];
    
    
    self.ingredientsTextView.text = @"BLABLABLA";
    
    
    //table loading:
    // Set this view controller object as the delegate and data source for the table view
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _albumDataModel = [[AlbumDataModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _albumDataModel.delegate = self;
    
    // Call the download items method of the home model object
    [_albumDataModel downloadItems];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    
    NSLog(@"USERID to be filtered %d", self.sherpa.userId);
    //Thiago - FILTERING ALBUMS BY USERID per requirement from Sherpany
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@",self.sherpa.userId];
    filtered = [items filteredArrayUsingPredicate:predicate];
    //Thiago - adding the required filtered Albums by USERID on the main array control of ViewControler recipe.
    // Set the downloaded items to the array
    _feedItems = filtered  ;
    
    
    // Reload the table view
    [self.listTableView reloadData];
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of feed items (initially 0)
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get the location to be shown
    DataLoad *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    myCell.textLabel.text=item.title;
    
    return myCell;
}


//by seelecting the row in a table view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected to see photos." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAlbumPhotosDetail"]) {
        NSIndexPath *indexPath = nil;
        Sherpa *sherpa = nil;
        
            indexPath = [self.listTableView indexPathForSelectedRow];
            sherpa = [_feedItems objectAtIndex:indexPath.row];
        
        
        PhotoViewController *destViewController = segue.destinationViewController;
        destViewController.sherpa = sherpa;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"Album Name";
    
}

@end
