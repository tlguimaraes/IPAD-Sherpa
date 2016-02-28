//
//  DataLoad.h
//  DataNodeApp
//
//  Created by Thiago Guimaraes on 11/10/15.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLoad : NSObject

//FOR USER DETAILS
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSString *imageFile;
@property (nonatomic,strong) NSString *compCatchPhrase;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *Id;


//FOR ALBUMS DETAILS

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *AlbumPicture;
@property (nonatomic,strong) NSString *idAlbum;
//FOR PHOTO ALBUNS DETAILS
@property (nonatomic,strong) NSString *photoTitle;


@end
