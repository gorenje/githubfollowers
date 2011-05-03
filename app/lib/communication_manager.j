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

var CommunicationManagerInstance = nil;

var PipeIdFollowers = "521af6886680bf0c16355274ee0b46f6";
var PipeIdFollowing = "beb4613138f82f83c456c4cb689feab3";
var BaseUrl = "http://pipes.yahoo.com/pipes/pipe.run?_id=%s&_render=json&githubusername=%s";

@implementation CommunicationManager : CPObject

- (id)init
{
  return [super init];
}

//
// Singleton class, this provides the callee with the only instance of this class.
//
+ (CommunicationManager) sharedInstance
{
  if ( !CommunicationManagerInstance ) {
    CommunicationManagerInstance = [[CommunicationManager alloc] init];
  }
  return CommunicationManagerInstance;
}

// Get the followers of the user
- (void)followersFor:(CPString)aUserName
            delegate:(id)aDelegate
            selector:(SEL)aSelector
{
  var url = [CPString stringWithFormat:BaseUrl, PipeIdFollowers,
                      encodeURIComponent(aUserName)];

  [GRCWJsonpWorker workerWithUrl:url
                        delegate:aDelegate
                        selector:aSelector
                        callback:"_callback"];
}

// get the developers who this user is following
- (void)userFollowing:(CPString)aUserName
             delegate:(id)aDelegate
             selector:(SEL)aSelector
{
  var url = [CPString stringWithFormat:BaseUrl, PipeIdFollowing,
                      encodeURIComponent(aUserName)];

  [GRCWJsonpWorker workerWithUrl:url
                        delegate:aDelegate
                        selector:aSelector
                        callback:"_callback"];
}

@end

