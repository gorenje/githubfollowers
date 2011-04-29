@STATIC;1.0;p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;15;AppController.jt;3607;@STATIC;1.0;I;21;Foundation/CPObject.ji;9;app/app.jt;3549;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("app/app.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("m_contentView"),new objj_ivar("m_github_username"),new objj_ivar("m_viewed_followers")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_3,_4,_5){
with(_3){
var _6=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMakeZero(),CPBorderlessBridgeWindowMask);
m_contentView=objj_msgSend(_6,"contentView");
objj_msgSend(PlaceholderManager,"sharedInstance");
m_github_username=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(10,10,250,50));
objj_msgSend(m_github_username,"setEditable:",YES);
objj_msgSend(m_github_username,"setEnabled:",YES);
objj_msgSend(m_github_username,"setTarget:",_3);
objj_msgSend(m_github_username,"setAction:",sel_getUid("findFollowers:"));
objj_msgSend(m_github_username,"setStringValue:","Github username");
objj_msgSend(m_github_username,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",24));
objj_msgSend(m_github_username,"setBordered:",YES);
objj_msgSend(m_github_username,"setBezeled:",YES);
objj_msgSend(m_github_username,"setBezelStyle:",CPTextFieldSquareBezel);
objj_msgSend(m_github_username,"selectText:",m_github_username);
objj_msgSend(m_github_username,"becomeFirstResponder");
objj_msgSend(m_github_username,"setCenter:",objj_msgSend(m_contentView,"center"));
objj_msgSend(m_contentView,"addSubview:",m_github_username);
objj_msgSend(_6,"orderFront:",_3);
m_viewed_followers=objj_msgSend(CPArray,"array");
}
}),new objj_method(sel_getUid("findFollowers:"),function(_7,_8,_9){
with(_7){
var _a=objj_msgSend(objj_msgSend(m_contentView,"subviews"),"count"),_b=objj_msgSend(m_contentView,"subviews");
while(_a--){
if(objj_msgSend(_b[_a],"isKindOfClass:",CPImageView)){
objj_msgSend(_b[_a],"removeFromSuperview");
}
}
for(var _c=0;_c<objj_msgSend(m_viewed_followers,"count");_c++){
var _d=m_viewed_followers[_c];
objj_msgSend(_d,"removeFromSuperview");
objj_msgSend(m_contentView,"addSubview:",_d);
objj_msgSend(_d,"setFrameOrigin:",CGPointMake(10+(_c*60),10));
}
objj_msgSend(objj_msgSend(CommunicationManager,"sharedInstance"),"followersFor:delegate:selector:",objj_msgSend(_9,"stringValue"),_7,sel_getUid("followerData:"));
}
}),new objj_method(sel_getUid("imageClicked:"),function(_e,_f,_10){
with(_e){
if(CPNotFound==objj_msgSend(m_viewed_followers,"indexOfObject:",_10)){
m_viewed_followers.push(_10);
}
objj_msgSend(m_github_username,"setStringValue:",objj_msgSend(_10,"dataObject")["username"]);
objj_msgSend(_e,"findFollowers:",m_github_username);
}
}),new objj_method(sel_getUid("followerData:"),function(_11,_12,_13){
with(_11){
var _14=10,_15=20;
for(var idx=0;idx<objj_msgSend(_13["count"],"intValue");idx++){
_15+=50;
if((_15+50)>CGRectGetHeight(objj_msgSend(m_contentView,"bounds"))){
_14+=60;
_15=70;
}
var _16=objj_msgSend(objj_msgSend(GravatorImageView,"alloc"),"initWithFrame:",CGRectMake(_14,_15,50,50));
objj_msgSend(_16,"setAutoresizingMask:",CPViewNotSizable);
objj_msgSend(_16,"setImageScaling:",CPScaleProportionally);
objj_msgSend(_16,"setHasShadow:",YES);
objj_msgSend(_16,"setDataObject:",_13["value"]["items"][idx]);
objj_msgSend(_16,"setTarget:",_11);
objj_msgSend(_16,"setAction:",sel_getUid("imageClicked:"));
objj_msgSend(ImageLoaderWorker,"workerFor:imageView:",_13["value"]["items"][idx]["image"],_16);
objj_msgSend(m_contentView,"addSubview:",_16);
}
}
})]);
p;9;app/app.jt;438;@STATIC;1.0;i;27;lib/communication_manager.ji;27;lib/communication_workers.ji;25;lib/placeholder_manager.ji;26;lib/image_loader_helpers.ji;27;views/gravator_image_view.jt;263;
objj_executeFile("lib/communication_manager.j",YES);
objj_executeFile("lib/communication_workers.j",YES);
objj_executeFile("lib/placeholder_manager.j",YES);
objj_executeFile("lib/image_loader_helpers.j",YES);
objj_executeFile("views/gravator_image_view.j",YES);
p;29;app/lib/placeholder_manager.jt;1769;@STATIC;1.0;t;1750;
var _1=nil;
var _2=[];
var _3=objj_allocateClassPair(CPObject,"PlaceholderManager"),_4=_3.isa;
class_addIvars(_3,[new objj_ivar("_store"),new objj_ivar("_waitingOnImage"),new objj_ivar("_spinnerImage"),new objj_ivar("_quotesImage")]);
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
}),new objj_method(sel_getUid("placeholderImageUrl"),function(_10,_11){
with(_10){
return "http://assets.2monki.es/images/placeholder.png";
}
}),new objj_method(sel_getUid("moustacheImageUrl"),function(_12,_13){
with(_12){
return "http://assets.2monki.es/images/moustache.png";
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
p;31;app/lib/communication_manager.jt;923;@STATIC;1.0;t;905;
var _1=nil;
var _2="http://pipes.yahoo.com/pipes/pipe.run?_id=88908111d5b1a32c1c41aefa25fa188d&_render=json";
var _3=objj_allocateClassPair(CPObject,"CommunicationManager"),_4=_3.isa;
objj_registerClassPair(_3);
class_addMethods(_3,[new objj_method(sel_getUid("init"),function(_5,_6){
with(_5){
return objj_msgSendSuper({receiver:_5,super_class:objj_getClass("CommunicationManager").super_class},"init");
}
}),new objj_method(sel_getUid("followersFor:delegate:selector:"),function(_7,_8,_9,_a,_b){
with(_7){
var _c=objj_msgSend(CPString,"stringWithFormat:","%s&githubusername=%s",_2,encodeURIComponent(_9));
objj_msgSend(PMCMWjsonpWorker,"workerWithUrl:delegate:selector:callback:",_c,_a,_b,"_callback");
}
})]);
class_addMethods(_4,[new objj_method(sel_getUid("sharedInstance"),function(_d,_e){
with(_d){
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
p;31;app/views/gravator_image_view.jt;567;@STATIC;1.0;t;549;
var _1=objj_allocateClassPair(CPImageView,"GravatorImageView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("m_data_object")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataObject"),function(_3,_4){
with(_3){
return m_data_object;
}
}),new objj_method(sel_getUid("setDataObject:"),function(_5,_6,_7){
with(_5){
m_data_object=_7;
}
}),new objj_method(sel_getUid("mouseDown:"),function(_8,_9,_a){
with(_8){
objj_msgSend(objj_msgSend(_8,"target"),"performSelector:withObject:",objj_msgSend(_8,"action"),_8);
}
})]);
