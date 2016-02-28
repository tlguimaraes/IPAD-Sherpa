//
//  CustomTableViewController.m
//  CustomTable
//
//  Created by Thiago Guimaraes on 2/23/16.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeTableCell.h"
#import "RecipeDetailViewController.h"
#import "Sherpa.h"
#import "DataLoad.h"

@interface RecipeTableViewController ()

@end

@implementation RecipeTableViewController
{
    NSArray *searchResults;
    NSArray *_feedItems;
    DataModel *_DataModel;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Thiago-Set this view controller object as the delegate and data source for the table view
    
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    
    
    self.navigationItem.title = @"Users Book Details";
    //Thiago-
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _DataModel = [[DataModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _DataModel.delegate = self;
    // Call the download items method of the home model object
    [_DataModel downloadItems];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        
        return _feedItems.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CustomTableCell";
    RecipeTableCell *cell = (RecipeTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[RecipeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe of users in the table cell f
    Sherpa *sherpa = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        sherpa = [searchResults objectAtIndex:indexPath.row];
    } else {
        sherpa = [_feedItems objectAtIndex:indexPath.row];
    }
    
    // Retrieve cell details from DataLoad class that is Loading Json from Model.
    
    // Get the location to be shown
    
    DataLoad *item = _feedItems[indexPath.row];
    
    cell.thumbnailImageView.image = [UIImage imageNamed:@"User.png"];   
    //cell.thumbnailImageView.image = [UIImage imageNamed:item.AlbumPicture];
    cell.nameLabel.text =   item.title;
    cell.prepTimeLabel.text = item.email;


    
    return cell;
}


//THiago - Searching filter for the field specifiec in predicate below - content related of the predicate for what we type on searchfilter by title.
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    searchResults = [_feedItems filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
// Thiago-ItemsDownloaded for listTableView load from json
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    // Reload the table view
    [self.listTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAlbumPhotosDetail"]) {
        NSIndexPath *indexPath = nil;
        Sherpa *sherpa = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            sherpa = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            sherpa = [_feedItems objectAtIndex:indexPath.row];
        }
        
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.sherpa = sherpa;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"Users | Utilisateurs |  Benutzer";
    
}


@end
