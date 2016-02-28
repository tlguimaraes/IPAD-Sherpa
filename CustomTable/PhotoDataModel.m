//
//  PhotoDataModel.m
//  PhotoDataNodeApp
//
//  Created by Thiago Guimaraes on 11/10/15.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import "PhotoDataModel.h"
#import "Sherpa.h"
#import "DataLoad.h"

@interface PhotoDataModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation PhotoDataModel

- (void)downloadItems
{
    //NSLog(@"NEEDED: %@", self.sherpa.title);
    NSLog(@"NEEDED: %@", self.sherpa.idAlbum);
    NSLog(@"JSON CALL ");
    // Download the json file coming from php Web services.
    //NSURL *jsonFileUrl = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/photos"];
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://localhost/photos.php"];
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_dataload = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new asset object and set its props to JsonElement properties
        //Getting all Details from Albuns of eachUser
        DataLoad *newLoad =[[DataLoad alloc] init];
        newLoad.Id = jsonElement[@"albumId"];
        newLoad.photoTitle= jsonElement[@"title"];
        newLoad.userId=jsonElement[@"id"];
        newLoad.AlbumPicture=jsonElement[@"thumbnailUrl"];
        
        
        // Add this question to the locations array
        [_dataload addObject:newLoad];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_dataload];
    }
}

@end