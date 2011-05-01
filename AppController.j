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

@implementation AppController : CPObject
{
    CPWindow theWindow;

    CPMutableArray m_followers;
    CPMutableArray m_following;
    Developer m_developer;

    @outlet CPArrayController m_followersController;
    @outlet CPArrayController m_followingController;
    @outlet CPImageView m_imageView;
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
}

- (CPAction)followerSelected:(id)sender
{
    var developer = m_followers[[sender selectedRow]];
    [m_developer setName:[developer name]];
    [m_developer setUserName:[developer userName]];
    [m_developer setImageUrl:[developer imageUrl]];
    [ImageLoaderWorker workerFor:[m_developer imageUrl] imageView:m_imageView];
}

- (CPAction)followingSelected:(id)sender
{
    var developer = m_following[[sender selectedRow]];
    [m_developer setName:[developer name]];
    [m_developer setUserName:[developer userName]];
    [m_developer setImageUrl:[developer imageUrl]];
    [ImageLoaderWorker workerFor:[m_developer imageUrl] imageView:m_imageView];
}

//
// Callbacks from the the communication manager
//
- (void)followingData:(JSObject)data
{
    [m_following removeAllObjects];
    for ( var idx = 0; idx < [data["count"] intValue] - 1; idx++ ) {
        [m_following addObject:[[Developer alloc]
                                   initWithJSONObject:data["value"]["items"][idx]]]
    }
    [m_followingController setContent:m_following];
}

- (void)followerData:(JSObject)data
{
    [m_followers removeAllObjects];
    var idx = 0;
    for ( ; idx < [data["count"] intValue] - 1; idx++ ) {
        var dev = [[Developer alloc] initWithJSONObject:data["value"]["items"][idx]];
        [m_followers addObject:dev]
    }

    [m_followersController setContent:m_followers];
    [self updateDeveloper:data["value"]["items"][idx]];
}

//
// Helpers
//
- (void)updateDeveloper:(JSObject)anObject
{
    [m_developer updateFromJson:anObject];
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
