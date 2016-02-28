//
//  PhotoViewController.m
//  CustomTableView
//
//  Created by Thiago Guimaraes on 2/23/16.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//


#import "PhotoViewController.h"
#import "DataLoad.h"
#import "Sherpa.h"


//===================
//IMAGE CACHE CARE
#import "FTWCache.h"
#import "NSString+MD5.h"
//===================

@interface PhotoViewController ()

@end

@implementation PhotoViewController {
    PhotoDataModel *_PhotoDataModel;
    NSArray *_feedItems;
    NSArray *filtered;
    
}


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
    
    
    //Thiago - adding Album Name per request on requirements
    self.navigationItem.title =self.sherpa.title;
    //self.title = self.sherpa.title;
    
    // Set this view controller object as the delegate and data source for the table view
    self.listTableViewPhoto.delegate = self;
    self.listTableViewPhoto.dataSource = self;
    
    
    
    
    NSLog(@"AlbumID to filter photosArray %@", self.sherpa.idAlbum);
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
    // Remove table cell separator
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Assign our own backgroud for the view
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Add padding to the top of the table view
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create array object and assign it to filtered variable
    filtered = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _PhotoDataModel = [[PhotoDataModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _PhotoDataModel.delegate = self;
    // Call the download items method of the home model object
    [_PhotoDataModel downloadItems];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //THIS COUNT IS IMPORTANT DURING THE DISPLAY PHASE-THIAGO
    // Return the number of feed items (initially 0)
    return _feedItems.count;
    
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    //====================================================================
    // Retrieve cell details from DataLoad class that is Loading Json from Album.
    
    // Get the location to be shown
    
    DataLoad *item = _feedItems[indexPath.row];
    // Get references to labels of cell
    
    //This will be later be added as improvement for the first display image of the Album.
    
    NSLog(@"item Album: '%@'", item.Id);
    NSLog(@"Sherpa Album: '%@'", self.sherpa.idAlbum);
    //if ([item.Id isEqualToString:self.sherpa.idAlbum]) {
    
        @try{
            NSLog(@"Album Picture: '%@'", item.AlbumPicture);
            //Trying to load the image based on the recipe of the ALbum/photos
            UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
            NSString* urltemp =item.AlbumPicture;
            //NSString* urltemp = @"http://placehold.it/150/bce63b";
            NSString* urlText = @"70.84.58.40/projects/ThiagoLeoncio/TipThumb/GOLF 58B.jpg";
            //NSString* urlTextEscaped = [urlText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString: urltemp];
            
            
            NSLog(@"url: '%@'", url);
            
            
            /*
             //Thiago - CACHING THE IMAGE CONTENT
             NSURL *imageURL = [NSURL URLWithString:urlText];
             NSString *key = [urlText MD5Hash];
             NSData *data = [FTWCache objectForKey:key];
             if (data) {
             UIImage *image = [UIImage imageWithData:data];
             recipeImageView.image = image;
             } else {
             recipeImageView.image = [UIImage imageNamed:@"img_def"];
             dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
             dispatch_async(queue, ^{
             NSData *data = [NSData dataWithContentsOfURL:imageURL];
             [FTWCache setObject:data forKey:key];
             UIImage *image = [UIImage imageWithData:data];
             dispatch_sync(dispatch_get_main_queue(), ^{
             recipeImageView.image = image;
             });
             });
             }
             */
            
            
            
            // Run CGI
            NSData *img_data = [NSData dataWithContentsOfURL:url];
            // Display results
            recipeImageView.image  = [[UIImage alloc] initWithData:img_data];
            
            
            // Assign our own background image for the cell
            UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
            
            UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
            cellBackgroundView.image = background;
            cell.backgroundView = cellBackgroundView;
            
        }
        @catch (NSException *exception)
        {
            NSLog(@"thumbnail.cgi fail to load the image %@:%@\n", [exception name], [exception reason]);
        }
        @finally
        {
            //
        }
        
        
        UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
        
        recipeNameLabel.text =  item.photoTitle;
        
        
        UILabel *recipeDetailLabel = (UILabel *)[cell viewWithTag:102];
        
        recipeDetailLabel.text =  item.Id;
    
    //}
    
    
    
    // BACKGROUND PART   ******
    // Assign our own background image for the cell
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    
    return cell;
}

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    //Thiago - FILTERING PHOTOS SELECTION BY ALBUMID
    NSLog(@"AlbumID to be filtered %@", self.sherpa.idAlbum);
    
    //Thiago - FILTERING ALBUMS BY USERID per requirement from Sherpany
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",self.sherpa.idAlbum];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Id == %@", [NSString stringWithFormat:@"%@",self.sherpa.idAlbum]];
    filtered = [items filteredArrayUsingPredicate:predicate];
    
    //Thiago - adding the required filtered photos by albumID on the main array control of ViewControler recipe.
    // Set the downloaded items to the array
    _feedItems = filtered  ;
    
    // Reload the table view
    [self.listTableViewPhoto reloadData];
}





#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *details = [NSString stringWithFormat:@"Check the photos related of %@",self.sherpa.title];
    return details;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}



@end