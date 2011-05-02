@STATIC;1.0;p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;15;AppController.jt;4193;@STATIC;1.0;I;21;Foundation/CPObject.ji;9;app/app.jt;4135;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("app/app.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("m_followers"),new objj_ivar("m_following"),new objj_ivar("m_developer"),new objj_ivar("m_followers_table"),new objj_ivar("m_following_table"),new objj_ivar("m_followersController"),new objj_ivar("m_followingController"),new objj_ivar("m_imageView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("init"),function(_3,_4){
with(_3){
m_followers=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
m_following=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
m_developer=objj_msgSend(objj_msgSend(Developer,"alloc"),"initWithJSONObject:",{"name":"280 North","username":"280north"});
return _3;
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_5,_6){
with(_5){
objj_msgSend(_5,"triggerRetrieve:",objj_msgSend(m_developer,"userName"));
var _7=objj_msgSend(m_followers_table,"tableColumnWithIdentifier:","username");
var _8=objj_msgSend(objj_msgSend(DeveloperDataView,"alloc"),"initWithFrame:",CGRectMake(0,0,322,100));
objj_msgSend(_7,"setDataView:",_8);
var _7=objj_msgSend(m_following_table,"tableColumnWithIdentifier:","username");
var _8=objj_msgSend(objj_msgSend(DeveloperDataView,"alloc"),"initWithFrame:",CGRectMake(0,0,322,100));
objj_msgSend(_7,"setDataView:",_8);
objj_msgSend(theWindow,"setFullBridge:",YES);
}
}),new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_9,_a,_b){
with(_9){
}
}),new objj_method(sel_getUid("findFollowers:"),function(_c,_d,_e){
with(_c){
objj_msgSend(_c,"triggerRetrieve:",objj_msgSend(m_developer,"userName"));
objj_msgSend(ImageLoaderWorker,"workerFor:imageView:","",m_imageView);
objj_msgSend(m_following,"removeAllObjects");
objj_msgSend(m_followers,"removeAllObjects");
objj_msgSend(m_followersController,"setContent:",m_followers);
objj_msgSend(m_followingController,"setContent:",m_following);
}
}),new objj_method(sel_getUid("followerSelected:"),function(_f,_10,_11){
with(_f){
objj_msgSend(_f,"updateDeveloperFromDeveloper:",m_followers[objj_msgSend(_11,"selectedRow")]);
}
}),new objj_method(sel_getUid("followingSelected:"),function(_12,_13,_14){
with(_12){
objj_msgSend(_12,"updateDeveloperFromDeveloper:",m_following[objj_msgSend(_14,"selectedRow")]);
}
}),new objj_method(sel_getUid("followingData:"),function(_15,_16,_17){
with(_15){
objj_msgSend(m_following,"removeAllObjects");
for(var idx=0;idx<objj_msgSend(_17["count"],"intValue")-1;idx++){
objj_msgSend(m_following,"addObject:",objj_msgSend(objj_msgSend(Developer,"alloc"),"initWithJSONObject:",_17["value"]["items"][idx]));
}
objj_msgSend(m_followingController,"setContent:",m_following);
}
}),new objj_method(sel_getUid("followerData:"),function(_18,_19,_1a){
with(_18){
objj_msgSend(m_followers,"removeAllObjects");
var idx=0;
for(;idx<objj_msgSend(_1a["count"],"intValue")-1;idx++){
objj_msgSend(m_followers,"addObject:",objj_msgSend(objj_msgSend(Developer,"alloc"),"initWithJSONObject:",_1a["value"]["items"][idx]));
}
objj_msgSend(m_followersController,"setContent:",m_followers);
objj_msgSend(m_developer,"updateFromJson:",_1a["value"]["items"][idx]);
objj_msgSend(ImageLoaderWorker,"workerFor:imageView:",objj_msgSend(m_developer,"imageUrl"),m_imageView);
}
}),new objj_method(sel_getUid("updateDeveloperFromDeveloper:"),function(_1b,_1c,_1d){
with(_1b){
objj_msgSend(m_developer,"setName:",objj_msgSend(_1d,"name"));
objj_msgSend(m_developer,"setUserName:",objj_msgSend(_1d,"userName"));
objj_msgSend(m_developer,"setImageUrl:",objj_msgSend(_1d,"imageUrl"));
objj_msgSend(ImageLoaderWorker,"workerFor:imageView:",objj_msgSend(m_developer,"imageUrl"),m_imageView);
}
}),new objj_method(sel_getUid("triggerRetrieve:"),function(_1e,_1f,_20){
with(_1e){
objj_msgSend(objj_msgSend(CommunicationManager,"sharedInstance"),"followersFor:delegate:selector:",_20,_1e,sel_getUid("followerData:"));
objj_msgSend(objj_msgSend(CommunicationManager,"sharedInstance"),"userFollowing:delegate:selector:",_20,_1e,sel_getUid("followingData:"));
}
})]);
p;9;app/app.jt;588;@STATIC;1.0;i;27;lib/communication_manager.ji;27;lib/communication_workers.ji;25;lib/placeholder_manager.ji;26;lib/image_loader_helpers.ji;18;models/developer.ji;27;views/developer_data_view.ji;26;views/rounded_image_view.jt;359;
objj_executeFile("lib/communication_manager.j",YES);
objj_executeFile("lib/communication_workers.j",YES);
objj_executeFile("lib/placeholder_manager.j",YES);
objj_executeFile("lib/image_loader_helpers.j",YES);
objj_executeFile("models/developer.j",YES);
objj_executeFile("views/developer_data_view.j",YES);
objj_executeFile("views/rounded_image_view.j",YES);
p;22;app/models/developer.jt;1302;@STATIC;1.0;t;1283;
var _1=objj_allocateClassPair(CPObject,"Developer"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("name"),new objj_ivar("m_username"),new objj_ivar("m_image_url")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("name"),function(_3,_4){
with(_3){
return name;
}
}),new objj_method(sel_getUid("setName:"),function(_5,_6,_7){
with(_5){
name=_7;
}
}),new objj_method(sel_getUid("userName"),function(_8,_9){
with(_8){
return m_username;
}
}),new objj_method(sel_getUid("setUserName:"),function(_a,_b,_c){
with(_a){
m_username=_c;
}
}),new objj_method(sel_getUid("imageUrl"),function(_d,_e){
with(_d){
return m_image_url;
}
}),new objj_method(sel_getUid("setImageUrl:"),function(_f,_10,_11){
with(_f){
m_image_url=_11;
}
}),new objj_method(sel_getUid("initWithJSONObject:"),function(_12,_13,_14){
with(_12){
_12=objj_msgSendSuper({receiver:_12,super_class:objj_getClass("Developer").super_class},"init");
if(_12){
objj_msgSend(_12,"updateFromJson:",_14);
}
return _12;
}
}),new objj_method(sel_getUid("updateFromJson:"),function(_15,_16,_17){
with(_15){
objj_msgSend(_15,"setValue:forKey:",objj_msgSend(_17["name"],"stringByTrimmingWhitespace"),"name");
objj_msgSend(_15,"setUserName:",_17["username"]);
objj_msgSend(_15,"setImageUrl:",_17["image"]);
}
})]);
p;31;app/views/developer_data_view.jt;2557;@STATIC;1.0;t;2538;
var _1=objj_allocateClassPair(CPView,"DeveloperDataView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("m_developer"),new objj_ivar("authorName"),new objj_ivar("authorAvatarView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("DeveloperDataView").super_class},"initWithFrame:",_5);
if(_3){
authorName=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(75,15,150,20));
objj_msgSend(authorName,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",13));
authorAvatarView=objj_msgSend(objj_msgSend(RoundedImageView,"alloc"),"initWithFrame:",CGRectMake(6,6,55,55));
var _6=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CGRectMake(60,2,_5.size.width-62,_5.size.height-4));
objj_msgSend(_6,"setAutoresizingMask:",CPViewHeightSizable|CPViewWidthSizable);
objj_msgSend(_3,"setSubviews:",[_6,authorName,authorAvatarView]);
}
return _3;
}
}),new objj_method(sel_getUid("setValue:forKey:"),function(_7,_8,_9,_a){
with(_7){
objj_msgSend(_7,"setObjectValue:",_9);
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_b,_c,_d){
with(_b){
if(!_d){
return;
}
m_developer=_d;
objj_msgSend(authorName,"setStringValue:",objj_msgSend(CPString,"stringWithFormat:","%s (%s)",objj_msgSend(m_developer,"userName"),objj_msgSend(m_developer,"name")));
objj_msgSend(authorName,"sizeToFit");
objj_msgSend(ImageLoaderWorker,"workerFor:imageView:",objj_msgSend(m_developer,"imageUrl"),authorAvatarView);
}
}),new objj_method(sel_getUid("objectValue"),function(_e,_f){
with(_e){
return m_developer;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_10,_11,_12){
with(_10){
objj_msgSendSuper({receiver:_10,super_class:objj_getClass("DeveloperDataView").super_class},"encodeWithCoder:",_12);
objj_msgSend(_12,"encodeObject:forKey:",authorName,"authorName");
objj_msgSend(_12,"encodeObject:forKey:",authorAvatarView,"authorAvatarView");
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_13,_14,_15){
with(_13){
_13=objj_msgSendSuper({receiver:_13,super_class:objj_getClass("DeveloperDataView").super_class},"initWithCoder:",_15);
if(_13){
authorName=objj_msgSend(_15,"decodeObjectForKey:","authorName");
authorAvatarView=objj_msgSend(_15,"decodeObjectForKey:","authorAvatarView");
}
return _13;
}
}),new objj_method(sel_getUid("setTarget:"),function(_16,_17,_18){
with(_16){
}
}),new objj_method(sel_getUid("setAction:"),function(_19,_1a,_1b){
with(_19){
}
})]);
p;30;app/views/rounded_image_view.jt;1982;@STATIC;1.0;t;1963;
var _1={};
var _2=objj_allocateClassPair(CPView,"RoundedImageView"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("image"),new objj_ivar("roundedImage")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("image"),function(_4,_5){
with(_4){
return image;
}
}),new objj_method(sel_getUid("setImage:"),function(_6,_7,_8){
with(_6){
image=_8;
}
}),new objj_method(sel_getUid("setImage:"),function(_9,_a,_b){
with(_9){
image=_b;
objj_msgSend(_9,"drawRoundedImage");
objj_msgSend(_9,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("imageDidLoad:"),function(_c,_d,_e){
with(_c){
}
}),new objj_method(sel_getUid("drawRoundedImage"),function(_f,_10){
with(_f){
var url=objj_msgSend(image,"filename");
if(_1[url]){
roundedImage=_1[url];
return;
}
var _11=CGRectMake(0,0,50,50),_12=CGPathWithRoundedRectangleInRect(_11,5,5,YES,YES,YES,YES),_13=CGBitmapGraphicsContextCreate();
_13.DOMElement.width=_13.DOMElement.height=50;
CGContextAddPath(_13,_12);
CGContextClip(_13);
if(objj_msgSend(image,"loadStatus")!==CPImageLoadStatusCompleted){
CGContextClearRect(_13,_11);
return;
}
CGContextDrawImage(_13,_11,image);
roundedImage={_image:_13.DOMElement};
_1[url]=roundedImage;
}
}),new objj_method(sel_getUid("drawRect:"),function(_14,_15,_16){
with(_14){
var _17=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
if(!image||objj_msgSend(image,"loadStatus")!==CPImageLoadStatusCompleted){
CGContextClearRect(_17,_16);
return;
}
var _18=objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0,0,0,0.4);
CGContextSetShadowWithColor(_17,CGSizeMake(0,1),2,_18);
CGContextDrawImage(_17,CGRectMake(2,0,50,50),roundedImage);
}
}),new objj_method(sel_getUid("mouseEntered:"),function(_19,_1a,_1b){
with(_19){
objj_msgSend(objj_msgSend(CPCursor,"pointingHandCursor"),"set");
}
}),new objj_method(sel_getUid("mouseExited:"),function(_1c,_1d,_1e){
with(_1c){
objj_msgSend(objj_msgSend(CPCursor,"arrowCursor"),"set");
}
})]);
p;30;app/lib/image_loader_helpers.jt;4757;@STATIC;1.0;t;4738;
var _1=objj_allocateClassPair(CPObject,"ImageLoaderWorker"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("m_image"),new objj_ivar("m_imageView"),new objj_ivar("m_delegate"),new objj_ivar("m_selector"),new objj_ivar("m_rotation_value"),new objj_ivar("m_is_vertical_flipped")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithUrl:imageView:tempImage:delegate:selector:rotation:isVFlipped:"),function(_3,_4,_5,_6,_7,_8,_9,_a,_b){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("ImageLoaderWorker").super_class},"init");
if(_3){
m_imageView=_6;
m_image=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:",_5);
m_delegate=_8;
m_selector=_9;
m_rotation_value=_a;
m_is_vertical_flipped=_b;
objj_msgSend(m_image,"setDelegate:",_3);
if(objj_msgSend(m_image,"loadStatus")!=CPImageLoadStatusCompleted&&objj_msgSend(_7,"loadStatus")==CPImageLoadStatusCompleted){
objj_msgSend(m_imageView,"setImage:",_7);
}
}
return _3;
}
}),new objj_method(sel_getUid("imageDidLoad:"),function(_c,_d,_e){
with(_c){
objj_msgSend(m_imageView,"setImage:",_e);
if(m_rotation_value&&objj_msgSend(m_imageView,"respondsToSelector:",sel_getUid("setRotationDegrees:"))){
objj_msgSend(m_imageView,"setRotationDegrees:",m_rotation_value);
}
if(m_is_vertical_flipped&&objj_msgSend(m_imageView,"respondsToSelector:",sel_getUid("setVerticalFlip:"))){
objj_msgSend(m_imageView,"setVerticalFlip:",1);
}
if(m_delegate&&m_selector){
objj_msgSend(m_delegate,"performSelector:withObject:",m_selector,_e);
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("workerFor:imageView:"),function(_f,_10,_11,_12){
with(_f){
return objj_msgSend(objj_msgSend(ImageLoaderWorker,"alloc"),"initWithUrl:imageView:tempImage:delegate:selector:rotation:isVFlipped:",_11,_12,objj_msgSend(objj_msgSend(PlaceholderManager,"sharedInstance"),"spinner"),nil,nil,nil,NO);
}
}),new objj_method(sel_getUid("workerFor:imageView:"),function(_13,_14,_15,_16){
with(_13){
return objj_msgSend(objj_msgSend(ImageLoaderWorker,"alloc"),"initWithUrl:imageView:tempImage:delegate:selector:rotation:isVFlipped:",_15,_16,objj_msgSend(objj_msgSend(PlaceholderManager,"sharedInstance"),"spinner"),nil,nil,nil,NO);
}
}),new objj_method(sel_getUid("workerFor:imageView:pageElement:"),function(_17,_18,_19,_1a,_1b){
with(_17){
return objj_msgSend(objj_msgSend(ImageLoaderWorker,"alloc"),"initWithUrl:imageView:tempImage:delegate:selector:rotation:isVFlipped:",_19,_1a,objj_msgSend(objj_msgSend(PlaceholderManager,"sharedInstance"),"spinner"),nil,nil,objj_msgSend(_1b,"rotation"),objj_msgSend(_1b,"isVerticalFlipped"));
}
}),new objj_method(sel_getUid("workerFor:imageView:rotation:"),function(_1c,_1d,_1e,_1f,_20){
with(_1c){
return objj_msgSend(objj_msgSend(ImageLoaderWorker,"alloc"),"initWithUrl:imageView:tempImage:delegate:selector:rotation:isVFlipped:",_1e,_1f,objj_msgSend(objj_msgSend(PlaceholderManager,"sharedInstance"),"spinner"),nil,nil,_20,NO);
}
}),new objj_method(sel_getUid("workerFor:imageView:tempImage:"),function(_21,_22,_23,_24,_25){
with(_21){
return objj_msgSend(objj_msgSend(ImageLoaderWorker,"alloc"),"initWithUrl:imageView:tempImage:delegate:selector:rotation:isVFlipped:",_23,_24,_25,nil,nil,nil,NO);
}
}),new objj_method(sel_getUid("workerFor:imageView:delegate:selector:"),function(_26,_27,_28,_29,_2a,_2b){
with(_26){
return objj_msgSend(objj_msgSend(ImageLoaderWorker,"alloc"),"initWithUrl:imageView:tempImage:delegate:selector:rotation:isVFlipped:",_28,_29,objj_msgSend(objj_msgSend(PlaceholderManager,"sharedInstance"),"spinner"),_2a,_2b,nil,NO);
}
})]);
var _1=objj_allocateClassPair(CPObject,"PMGetImageWorker"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("image"),new objj_ivar("path")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("image"),function(_2c,_2d){
with(_2c){
return image;
}
}),new objj_method(sel_getUid("setImage:"),function(_2e,_2f,_30){
with(_2e){
image=_30;
}
}),new objj_method(sel_getUid("path"),function(_31,_32){
with(_31){
return path;
}
}),new objj_method(sel_getUid("setPath:"),function(_33,_34,_35){
with(_33){
path=_35;
}
}),new objj_method(sel_getUid("initWithPath:"),function(_36,_37,_38){
with(_36){
_36=objj_msgSendSuper({receiver:_36,super_class:objj_getClass("PMGetImageWorker").super_class},"init");
if(_36){
path=_38;
image=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:",path);
objj_msgSend(image,"setDelegate:",_36);
}
return _36;
}
}),new objj_method(sel_getUid("imageDidLoad:"),function(_39,_3a,_3b){
with(_39){
image=_3b;
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("workerFor:"),function(_3c,_3d,_3e){
with(_3c){
return objj_msgSend(objj_msgSend(PMGetImageWorker,"alloc"),"initWithPath:",_3e);
}
})]);
p;29;app/lib/placeholder_manager.jt;1395;@STATIC;1.0;t;1376;
var _1=nil;
var _2=[];
var _3=objj_allocateClassPair(CPObject,"PlaceholderManager"),_4=_3.isa;
class_addIvars(_3,[new objj_ivar("_store")]);
objj_registerClassPair(_3);
class_addMethods(_3,[new objj_method(sel_getUid("init"),function(_5,_6){
with(_5){
_5=objj_msgSendSuper({receiver:_5,super_class:objj_getClass("PlaceholderManager").super_class},"init");
if(_5){
_store=objj_msgSend(objj_msgSend(CPDictionary,"alloc"),"init");
for(var _7=0;_7<_2.length;_7++){
var _8=_2[_7];
objj_msgSend(_store,"setObject:forKey:",objj_msgSend(PMGetImageWorker,"workerFor:",objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"pathForResource:",(_8+".png"))),objj_msgSend(_8,"lowercaseString"));
}
objj_msgSend(_store,"setObject:forKey:",objj_msgSend(PMGetImageWorker,"workerFor:",objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"pathForResource:","spinner.gif")),"sp");
}
return _5;
}
}),new objj_method(sel_getUid("spinner"),function(_9,_a){
with(_9){
return objj_msgSend(objj_msgSend(_store,"objectForKey:","sp"),"image");
}
})]);
class_addMethods(_4,[new objj_method(sel_getUid("sharedInstance"),function(_b,_c){
with(_b){
if(!_1){
_1=objj_msgSend(objj_msgSend(PlaceholderManager,"alloc"),"init");
}
return _1;
}
}),new objj_method(sel_getUid("imageFor:"),function(_d,_e,_f){
with(_d){
return objj_msgSend(objj_msgSend(PlaceholderManager,"sharedInstance"),"performSelector:",_f);
}
})]);
p;31;app/lib/communication_manager.jt;1271;@STATIC;1.0;t;1252;
var _1=nil;
var _2="521af6886680bf0c16355274ee0b46f6";
var _3="beb4613138f82f83c456c4cb689feab3";
var _4="http://pipes.yahoo.com/pipes/pipe.run?_id=%s&_render=json&githubusername=%s";
var _5=objj_allocateClassPair(CPObject,"CommunicationManager"),_6=_5.isa;
objj_registerClassPair(_5);
class_addMethods(_5,[new objj_method(sel_getUid("init"),function(_7,_8){
with(_7){
return objj_msgSendSuper({receiver:_7,super_class:objj_getClass("CommunicationManager").super_class},"init");
}
}),new objj_method(sel_getUid("followersFor:delegate:selector:"),function(_9,_a,_b,_c,_d){
with(_9){
var _e=objj_msgSend(CPString,"stringWithFormat:",_4,_2,encodeURIComponent(_b));
objj_msgSend(PMCMWjsonpWorker,"workerWithUrl:delegate:selector:callback:",_e,_c,_d,"_callback");
}
}),new objj_method(sel_getUid("userFollowing:delegate:selector:"),function(_f,_10,_11,_12,_13){
with(_f){
var url=objj_msgSend(CPString,"stringWithFormat:",_4,_3,encodeURIComponent(_11));
objj_msgSend(PMCMWjsonpWorker,"workerWithUrl:delegate:selector:callback:",url,_12,_13,"_callback");
}
})]);
class_addMethods(_6,[new objj_method(sel_getUid("sharedInstance"),function(_14,_15){
with(_14){
if(!_1){
_1=objj_msgSend(objj_msgSend(CommunicationManager,"alloc"),"init");
}
return _1;
}
})]);
p;31;app/lib/communication_workers.jt;1516;@STATIC;1.0;t;1497;
var _1=objj_allocateClassPair(CPObject,"PMCMWjsonpWorker"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_urlStr"),new objj_ivar("_delegate"),new objj_ivar("_selector")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithUrl:delegate:selector:callback:"),function(_3,_4,_5,_6,_7,_8){
with(_3){
_urlStr=_5;
_delegate=_6;
_selector=_7;
objj_msgSend(CPJSONPConnection,"connectionWithRequest:callback:delegate:",objj_msgSend(CPURLRequest,"requestWithURL:",_urlStr),_8,_3);
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_9,_a,_b,_c){
with(_9){
if(_delegate&&_selector&&_c){
objj_msgSend(_delegate,"performSelector:withObject:",_selector,_c);
}
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_d,_e,_f,_10){
with(_d){
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("jsonpRequestError:"))){
objj_msgSend(_delegate,"performSelector:withObject:",sel_getUid("jsonpRequestError:"),_10);
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("workerWithUrl:delegate:selector:"),function(_11,_12,url,_13,_14){
with(_11){
return objj_msgSend(objj_msgSend(PMCMWjsonpWorker,"alloc"),"initWithUrl:delegate:selector:callback:",url,_13,_14,"callback");
}
}),new objj_method(sel_getUid("workerWithUrl:delegate:selector:callback:"),function(_15,_16,url,_17,_18,_19){
with(_15){
return objj_msgSend(objj_msgSend(PMCMWjsonpWorker,"alloc"),"initWithUrl:delegate:selector:callback:",url,_17,_18,_19);
}
})]);
