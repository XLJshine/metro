
#import <Foundation/Foundation.h>
#import "AFURLConnectionOperationPanChan.h"

@interface AFHTTPRequestOperationPanChan : AFURLConnectionOperationPanChan

@property (readonly, nonatomic, strong) NSHTTPURLResponse *response;

@property (nonatomic, strong) AFHTTPResponseSerializerPanChan <AFURLResponseSerializationPanChan> * responseSerializer;

/**
 An object constructed by the `responseSerializer` from the response and response data. Returns `nil` unless the operation `isFinished`, has a `response`, and has `responseData` with non-zero content length. If an error occurs during serialization, `nil` will be returned, and the `error` property will be populated with the serialization error.
 */
@property (readonly, nonatomic, strong) id responseObject;

///-----------------------------------------------------------
/// @name Setting Completion Block Success / Failure Callbacks
///-----------------------------------------------------------

/**
 Sets the `completionBlock` property with a block that executes either the specified success or failure block, depending on the state of the request on completion. If `error` returns a value, which can be caused by an unacceptable status code or content type, then `failure` is executed. Otherwise, `success` is executed.

 This method should be overridden in subclasses in order to specify the response object passed into the success block.
 
 @param success The block to be executed on the completion of a successful request. This block has no return value and takes two arguments: the receiver operation and the object constructed from the response data of the request.
 @param failure The block to be executed on the completion of an unsuccessful request. This block has no return value and takes two arguments: the receiver operation and the error that occurred during the request.
 */
- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperationPanChan *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperationPanChan *operation, NSError *error))failure;

@end
