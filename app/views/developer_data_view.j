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

@implementation DeveloperDataView : CPView
{
  Developer m_developer;

  CPTextField authorName;
  RoundedImageView authorAvatarView;
}

- (id)initWithFrame:(CGRect)aFrame
{
  self = [super initWithFrame:aFrame];
  if ( self )
  {
    authorName = [[CPTextField alloc] initWithFrame:CGRectMake(75, 15, 150, 20)];
    [authorName setFont:[CPFont boldSystemFontOfSize:13]];

    authorAvatarView = [[RoundedImageView alloc] initWithFrame:CGRectMake(6, 6, 55, 55)];

    var tweetBackground = [[CPView alloc]
                                initWithFrame:CGRectMake(60, 2, aFrame.size.width - 62,
                                                         aFrame.size.height - 4)];
    [tweetBackground setAutoresizingMask:CPViewHeightSizable|CPViewWidthSizable];

    [self setSubviews:[tweetBackground, authorName, authorAvatarView]];
  }
  return self
}

- (void)setValue:(id)value forKey:(id)bindingPath
{
  [self setObjectValue:value];
}

- (void)setObjectValue:(id)aDeveloper
{
  if ( !aDeveloper ) return;
  m_developer = aDeveloper;

  [authorName setStringValue:[CPString stringWithFormat:"%s (%s)",
                                       [m_developer userName], [m_developer name]]];
  [authorName sizeToFit];
  [ImageLoaderWorker workerFor:[m_developer imageUrl] imageView:authorAvatarView];
}

- (id)objectValue
{
  return m_developer;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
  [super encodeWithCoder:aCoder];

  [aCoder encodeObject:authorName forKey:"authorName"];
  [aCoder encodeObject:authorAvatarView forKey:"authorAvatarView"];
}

- (id)initWithCoder:(CPCoder)aCoder
{
  self = [super initWithCoder:aCoder];

  if (self)
  {
    authorName       = [aCoder decodeObjectForKey:"authorName"];
    authorAvatarView = [aCoder decodeObjectForKey:"authorAvatarView"];
  }

  return self;
}

- (void)setTarget:(id)aTarget
{
}

- (void)setAction:(SEL)anAction
{
}

@end


