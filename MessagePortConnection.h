#import <Foundation/Foundation.h>

@class MessagePortConnection;

@protocol MessagePortConnectionDelegate
- (void)messagePortConnection:(MessagePortConnection *)connection receivedData:(NSData *)data;
@end

@interface MessagePortConnection : NSObject

@property (weak) id<MessagePortConnectionDelegate> delegate;

- (instancetype)initWithLocalPort:(NSString *)localPortName
                       remotePort:(NSString *)remotePortName;

- (void)sendData:(NSData *)data;

@end
