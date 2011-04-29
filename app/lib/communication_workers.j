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

@implementation PMCMWjsonpWorker : CPObject
{
  CPString _urlStr;
  id       _delegate;
  SEL      _selector;
}

+ (PMCMWjsonpWorker) workerWithUrl:(CPString)url delegate:(id)aDelegate selector:(SEL)aSelector
{
  return [[PMCMWjsonpWorker alloc] initWithUrl:url
                                      delegate:aDelegate
                                      selector:aSelector
                                      callback:@"callback"];
}

+ (PMCMWjsonpWorker) workerWithUrl:(CPString)url
                          delegate:(id)aDelegate
                          selector:(SEL)aSelector
                          callback:(CPString)aCallback
{
  return [[PMCMWjsonpWorker alloc] initWithUrl:url
                                      delegate:aDelegate
                                      selector:aSelector
                                      callback:aCallback];
}

- (id) initWithUrl:(CPString)url
          delegate:(id)aDelegate
          selector:(SEL)aSelector
          callback:(CPString)aCallback
{
  _urlStr = url;
  _delegate = aDelegate;
  _selector = aSelector;
  [CPJSONPConnection connectionWithRequest:[CPURLRequest requestWithURL:_urlStr]
                                  callback:aCallback
                                  delegate:self];
}

- (void)connection:(CPJSONPConnection)aConnection didReceiveData:(JSObject)data
{
  if ( _delegate && _selector && data ) {
    [_delegate performSelector:_selector withObject:data];
  }
}

- (void)connection:(CPJSONPConnection)aConnection didFailWithError:(CPString)error
{
  if ( _delegate && [_delegate respondsToSelector:@selector(jsonpRequestError:)] ) {
    [_delegate performSelector:@selector(jsonpRequestError:) withObject:error];
  }
}

@end
