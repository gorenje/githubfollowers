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
    CPView m_contentView;
    JSObject m_current_data;
    CPTextField m_github_username;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];

    m_contentView = [theWindow contentView];

    [PlaceholderManager sharedInstance];

    m_github_username = [[CPTextField alloc]
                            initWithFrame:CGRectMake( 10, 10, 250, 50 )];
    [m_github_username setEditable:YES];
    [m_github_username setEnabled:YES];
    [m_github_username setTarget:self];
    [m_github_username setAction:@selector(findFollowers:)];
    [m_github_username setStringValue:@"Github username"];
    [m_github_username setFont:[CPFont boldSystemFontOfSize:24.0]];
    [m_github_username setBordered:YES];
    [m_github_username setBezeled:YES];
    [m_github_username setBezelStyle:CPTextFieldSquareBezel];
    [m_github_username selectText:m_github_username];
    [m_github_username becomeFirstResponder];
    [m_github_username setCenter:[m_contentView center]];
    [m_contentView addSubview:m_github_username];

    [theWindow orderFront:self];
}

- (CPAction)findFollowers:(id)sender
{
    var count = [[m_contentView subviews] count],
        subviews = [m_contentView subviews];

    while ( count-- )
        if ( [subviews[count] isKindOfClass:CPImageView] )
            [subviews[count] removeFromSuperview];

    [[CommunicationManager sharedInstance]
        followersFor:[sender stringValue]
            delegate:self
            selector:@selector(followerData:)];
}

- (CPAction)imageClicked:(id)sender
{
    [m_github_username setStringValue:[sender dataObject]["username"]];
    [self findFollowers:m_github_username];
}

- (void)followerData:(JSObject)data
{
    m_current_data = data;
    var xLoc = 10, yLoc = -40;

    for ( var idx = 0; idx < [data["count"] intValue]; idx++ ) {
        yLoc += 50;
        if ( (yLoc + 50) > CGRectGetHeight( [m_contentView bounds] ) ) {
            xLoc += 60;
            yLoc = 10;
        }
        var imageView = [[GravatorImageView alloc]
                            initWithFrame:CGRectMake(xLoc,yLoc,50,50)];
        [imageView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [imageView setImageScaling:CPScaleProportionally];
        [imageView setHasShadow:YES];
        [imageView setDataObject:data["value"]["items"][idx]];
        [imageView setTarget:self];
        [imageView setAction:@selector(imageClicked:)];
        [ImageLoaderWorker workerFor:data["value"]["items"][idx]["image"]
                           imageView:imageView];
        [m_contentView addSubview:imageView];
    }
}

@end
