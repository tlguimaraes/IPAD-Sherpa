//
//  AlbumDataModel.m
//  AlbumDataNodeApp
//
//  Created by Thiago Guimaraes on 11/10/15.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import "AlbumDataModel.h"

#import "DataLoad.h"

@interface AlbumDataModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation AlbumDataModel

- (void)downloadItems
{
    // Download the json file coming from php Web services.
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/albums"];
    
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
    
    
    
    //WORKING BEFORE
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new asset object and set its props to JsonElement properties
        //Getting all Details from Albuns of eachUser
        DataLoad *newLoad =[[DataLoad alloc] init];
        newLoad.idAlbum = jsonElement[@"id"];
        newLoad.title= jsonElement[@"title"];
        newLoad.userId=jsonElement[@"userId"];
        newLoad.AlbumPicture=jsonElement[@"title"];
        
        
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