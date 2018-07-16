
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import "AFHTTPRequestOperationPanChan.h"
#import "AFURLResponseSerializationPanChan.h"
#import "AFURLRequestSerializationPanChan.h"
#import "AFSecurityPolicyPanChan.h"
#import "AFNetworkReachabilityManagerPanChan.h"

@interface AFHTTPRequestOperationManagerPanChan : NSObject <NSSecureCoding, NSCopying>

@property (readonly, nonatomic, strong) NSURL *baseURL;

@property (nonatomic, strong) AFHTTPRequestSerializerPanChan <AFURLRequestSerializationPanChan> * requestSerializer;

@property (nonatomic, strong) AFHTTPResponseSerializerPanChan <AFURLResponseSerializationPanChan> * responseSerializer;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, assign) BOOL shouldUseCredentialStorage;

@property (nonatomic, strong) NSURLCredential *credential;

@property (nonatomic, strong) AFSecurityPolicyPanChan *securityPolicy;

@property (readwrite, nonatomic, strong) AFNetworkReachabilityManagerPanChan *reachabilityManager;

///-------------------------------
/// @name Managing Callback Queues
///-------------------------------

/**
 The dispatch queue for the `completionBlock` of request operations. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, strong) dispatch_queue_t completionQueue;

/**
 The dispatch group for the `completionBlock` of request operations. If `NULL` (default), a private dispatch group is used.
 */
@property (nonatomic, strong) dispatch_group_t completionGroup;

+ (instancetype)manager;

- (instancetype)initWithBaseURL:(NSURL *)url;

- (AFHTTPRequestOperationPanChan *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

- (AFHTTPRequestOperationPanChan *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

- (AFHTTPRequestOperationPanChan *)HEAD:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperationPanChan *operation))success
                         failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

- (AFHTTPRequestOperationPanChan *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

- (AFHTTPRequestOperationPanChan *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

- (AFHTTPRequestOperationPanChan *)PUT:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

- (AFHTTPRequestOperationPanChan *)PATCH:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

- (AFHTTPRequestOperationPanChan *)DELETE:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

@end

