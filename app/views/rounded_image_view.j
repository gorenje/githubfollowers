/*
  Take from:
    https://github.com/Me1000/CappuTweetie/blob/master/Views/TweetDataView.j#L253
*/
var cachedAvatars = {};

@implementation RoundedImageView : CPView
{
  CPImage image @accessors;
  JSObject roundedImage;
}

- (void)setImage:(CPImage)anImage
{
  image = anImage;
  [self drawRoundedImage];
  [self setNeedsDisplay:YES];
}

- (void)imageDidLoad:(id)sender
{
}

- (void)drawRoundedImage
{
  var url = [image filename];
  if(cachedAvatars[url])
  {
    roundedImage = cachedAvatars[url];
    return;
  }

  var rect = CGRectMake(0, 0, 50, 50),
    path = CGPathWithRoundedRectangleInRect(rect, 5, 5, YES, YES, YES, YES),
    context = CGBitmapGraphicsContextCreate();

  context.DOMElement.width = context.DOMElement.height = 50;
  CGContextAddPath(context, path);
  CGContextClip(context);

  if ([image loadStatus] !== CPImageLoadStatusCompleted)
  {
    CGContextClearRect(context, rect);
    return;
  }

  CGContextDrawImage(context, rect, image);

  // hack attack for CGContextDrawImage!
  roundedImage = { _image: context.DOMElement };
  cachedAvatars[url] = roundedImage;
}

- (void)drawRect:(CPRect)aRect
{
  var context = [[CPGraphicsContext currentContext] graphicsPort];

  if(!image || [image loadStatus] !== CPImageLoadStatusCompleted)
  {
    CGContextClearRect(context, aRect);
    return;
  }


  var shadowColor = [CPColor colorWithRed:0 green:0 blue:0 alpha:0.4];

  CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 2, shadowColor);
  CGContextDrawImage(context, CGRectMake(2, 0, 50, 50), roundedImage);
}

- (void)mouseEntered:(CPEvent)anEvent
{
  [[CPCursor pointingHandCursor] set];
}

- (void)mouseExited:(CPEvent)anEvent
{
  [[CPCursor arrowCursor] set];
}

@end

