
#import <Foundation/Foundation.h>
#import "REFS.h"
#import "SETSEvParams.h"

@interface SETS : NSObject

+(void)startSession:(long long)appID useLocation:(BOOL)location testMode:(BOOL)testMode;
+(void)endSession;
+(void)resume;
+(void)trackEvent:(NSString*)name withParam:(NSString*)params andInfo:(NSString*)moreInfo;
+(void)trackEvent:(NSString*)name withParams:(SETSEvParams*)params;
+(void)trackEventText:(NSString*)name withParam:(NSString*)params andInfo:(NSString*)moreInfo;
+(void)trackEventClick:(NSString*)name;
+(void)trackEventImpr:(id)object withName:(NSString*)name wordsArray:(NSArray*)words andMoreInfo:(NSString*)moreInfo;
+(void)trackEventNavi:(NSString*)name withInfo:(NSString*)moreInfo;
+(void)trackEventNavi:(NSString*)name withPercent:(NSInteger)percent andInfo:(NSString*)moreInfo;
+(void)trackEventMedia:(NSString*)name withUrl:(NSString*)url mediaId:(NSString*)meid mediaType:(NSString*)mediaType andInfo:(NSString*)moreInfo;
+(void)trackEventEcomm:(NSString*)name withUrl:(NSString*)url orderId:(NSString*)orderid andInfo:(NSString*)moreInfo;

+(float)getLat;
+(float)getLon;
+(long long)getUserId;
+(long long)getDeviceId;
+(BOOL)isConnected;
+(void)showLogs:(BOOL)show;
+(BOOL)webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;

@end