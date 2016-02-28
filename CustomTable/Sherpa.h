//
//  Recipe.h
//  AlbumBook
//
//  Created by Thiago G. on 02/22/2016.
//  Copyright (c) 2016 Thiago G.. All rights reserved.
//
//
//

#import <Foundation/Foundation.h>

@interface Sherpa : NSObject

@property (nonatomic, strong) NSString *name; // name of User
@property (nonatomic, strong) NSString *detail; // User E-mail
@property (nonatomic, strong) NSString *imageFile; // image filename of recipe


//REMOVE SOON
@property (nonatomic, strong) NSString *prepTime;
@property (nonatomic, strong) NSString *image; // image filename
@property (nonatomic, strong) NSArray *ingredients; 

//Pending the CompanyCatchPhrase --Thiago 

//FOR USER DETAILS
@property (nonatomic,strong) NSString *compCatchPhrase;
//@property (nonatomic,strong) NSString *userId;
@property(nonatomic, assign) int userId;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *Id;

//FOR ALBUMS DETAILS
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *AlbumPicture;
@property (nonatomic,strong) NSString *idAlbum;
//FOR PHOTO ALBUNS DETAILS




@end
