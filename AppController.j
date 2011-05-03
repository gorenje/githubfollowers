/*
 * Created by Gerrit Riessen
 * Copyright 2010-2011, Gerrit Riessen
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

@import <Foundation/CPObject.j>

@import "app/app.j"
@import <GRKit/g_r_comm_worker.j>

@implementation AppController : CPObject
{
    @outlet CPWindow theWindow;

    // Binding "outlets"
    CPMutableArray m_followers;
    CPMutableArray m_following;
    Developer      m_developer;

    @outlet CPTableView       m_followers_table;
    @outlet CPTableView       m_following_table;
    @outlet CPArrayController m_followersController;
    @outlet CPArrayController m_followingController;
    @outlet RoundedImageView  m_imageView;
}

//
// Initialisation
//
- (id)init
{
    m_followers = [[CPMutableArray alloc] init];
    m_following = [[CPMutableArray alloc] init];
    m_developer = [[Developer alloc] initWithJSONObject:{ "name" : "280 North",
                                                          "username" : "280north" }];
    return self;
}

- (void)awakeFromCib
{
    [self triggerRetrieve:[m_developer userName]];

    var dataColumn = [m_followers_table  tableColumnWithIdentifier:"username"];
    var dataViewPrototype = [[DeveloperDataView alloc] initWithFrame:CGRectMake(0,0,322,100)];
    [dataColumn setDataView:dataViewPrototype];

    var dataColumn = [m_following_table  tableColumnWithIdentifier:"username"];
    var dataViewPrototype = [[DeveloperDataView alloc] initWithFrame:CGRectMake(0,0,322,100)];
    [dataColumn setDataView:dataViewPrototype];

    [theWindow setFullBridge:YES];
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
}

//
// Actions
//
- (CPAction)findFollowers:(id)sender
{
    [self triggerRetrieve:[m_developer userName]];
    [ImageLoaderWorker workerFor:"" imageView:m_imageView];
    [m_following removeAllObjects];
    [m_followers removeAllObjects];
    [m_followersController setContent:m_followers];
    [m_followingController setContent:m_following];
}

- (CPAction)followerSelected:(id)sender
{
    [self updateDeveloperFromDeveloper:m_followers[[sender selectedRow]]];
}

- (CPAction)followingSelected:(id)sender
{
    [self updateDeveloperFromDeveloper:m_following[[sender selectedRow]]];
}

//
// Callbacks from the the communication manager
//
- (void)followingData:(JSObject)data
{
    [m_following removeAllObjects];
    for ( var idx = 0; idx < [data["count"] intValue] - 1; idx++ )
        [m_following addObject:[[Developer alloc]
                                   initWithJSONObject:data["value"]["items"][idx]]]

    [m_followingController setContent:m_following];
}

- (void)followerData:(JSObject)data
{
    [m_followers removeAllObjects];
    var idx = 0;
    for ( ; idx < [data["count"] intValue] - 1; idx++ )
        [m_followers addObject:[[Developer alloc]
                                   initWithJSONObject:data["value"]["items"][idx]]]

    [m_followersController setContent:m_followers];

    // the last member of the items is always the owner, i.e. the developer for whom
    // we just got the data.
    [m_developer updateFromJson:data["value"]["items"][idx]];
    [ImageLoaderWorker workerFor:[m_developer imageUrl] imageView:m_imageView];
}

//
// Helpers
//
- (void)updateDeveloperFromDeveloper:(Developer)developer
{
    [m_developer setName:[developer name]];
    [m_developer setUserName:[developer userName]];
    [m_developer setImageUrl:[developer imageUrl]];
    [ImageLoaderWorker workerFor:[m_developer imageUrl] imageView:m_imageView];
}

- (void)triggerRetrieve:(CPString)aUserName
{
    [[CommunicationManager sharedInstance]
        followersFor:aUserName
            delegate:self
            selector:@selector(followerData:)];

    [[CommunicationManager sharedInstance]
        userFollowing:aUserName
             delegate:self
             selector:@selector(followingData:)];
}

@end
