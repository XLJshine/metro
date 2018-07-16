
#import <Foundation/Foundation.h>
#import <Availability.h>

#ifndef _AFNETWORKING_
    #define _AFNETWORKING_

    #import "AFURLRequestSerializationPanChan.h"
    #import "AFURLResponseSerializationPanChan.h"
    #import "AFSecurityPolicyPanChan.h"
    #import "AFNetworkReachabilityManagerPanChan.h"

    #import "AFURLConnectionOperationPanChan.h"
    #import "AFHTTPRequestOperationPanChan.h"
    #import "AFHTTPRequestOperationManagerPanChan.h"

#if ( ( defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090) || \
      ( defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 ) )
    #import "AFURLSessionManagerPanChan.h"
    #import "AFHTTPSessionManagerPanChan.h"
#endif

#endif /* _AFNETWORKINGPANCHAN_ */
