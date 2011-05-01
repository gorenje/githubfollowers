@implementation Developer : CPObject
{
  CPString name @accessors(property=name);
  CPString m_username @accessors(property=userName);
  CPString m_image_url @accessors(property=imageUrl);
}

- (id)initWithJSONObject:(JSObject)anObject
{
  self = [super init];
  if (self) {
    [self updateFromJson:anObject];
  }
  return self;
}

- (void)updateFromJson:(JSObject)anObject
{
  [self setValue:[anObject["name"]  stringByTrimmingWhitespace] forKey:"name"];
  // [self setName:[anObject["name"]  stringByTrimmingWhitespace]];
  [self setUserName:anObject["username"]];
  [self setImageUrl:anObject["image"]];
}

@end
