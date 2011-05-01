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
/*
  This stores a bunch of placeholders, required at various places in the application.
  Better name would be ImageManager but placeholder, even 15 days into the project,
  has history!
*/
var PlaceholderManagerInstance = nil;
var ImageAry = [];

@implementation PlaceholderManager : CPObject
{
  CPDictionary _store;
}

- (id)init
{
  self = [super init];
  if (self) {
    _store = [[CPDictionary alloc] init];
    for ( var idx = 0; idx < ImageAry.length; idx++ ) {
      var name = ImageAry[idx];
      [_store setObject:[PMGetImageWorker
                          workerFor:[[CPBundle mainBundle] pathForResource:(name + ".png")]]
                 forKey:[name lowercaseString]];
    }
    [_store setObject:[PMGetImageWorker
                        workerFor:[[CPBundle mainBundle] pathForResource:"spinner.gif"]]
               forKey:@"sp"];
  }
  return self;
}

//
// Singleton class, this provides the callee with the only instance of this class.
//
+ (PlaceholderManager) sharedInstance
{
  if ( !PlaceholderManagerInstance ) {
    PlaceholderManagerInstance = [[PlaceholderManager alloc] init];
  }
  return PlaceholderManagerInstance;
}

/*
 * Remember, imageFor takes the name of an instance method and *not* the key of
 * an image in the store.
 */
+ (CPImage) imageFor:(CPString)aMethodName
{
  return [[PlaceholderManager sharedInstance] performSelector:aMethodName];
}

//
// Instance methods.
//

- (CPImage)spinner
{
  return [[_store objectForKey:"sp"] image];
}

@end
