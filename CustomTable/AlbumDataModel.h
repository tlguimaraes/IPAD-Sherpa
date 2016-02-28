//
//  AlbumDataModel.h
//  AlbumNodeApp
//
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AlbumDataModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface AlbumDataModel : NSObject <NSURLConnectionDataDelegate>


@property (nonatomic, strong) id<AlbumDataModelProtocol> delegate;

- (void)downloadItems;

@end
