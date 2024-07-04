#import "MessagePortConnection.h"
#import <CoreFoundation/CoreFoundation.h>

@interface MessagePortConnection (Private)
- (void)connectionReceivedData:(NSData *)data;
@end

CFDataRef LocalPortReceivedDataCallback(CFMessagePortRef local, SInt32 msgid, CFDataRef cfData, void *info) {
    MessagePortConnection *connection = (__bridge MessagePortConnection *)info;
    [connection connectionReceivedData:(__bridge NSData *)cfData];
    return NULL;
}

@implementation MessagePortConnection {
    CFMessagePortRef _localPort;
    CFMessagePortRef _remotePort;
}

- (instancetype)initWithLocalPort:(NSString *)localPortName
                       remotePort:(NSString *)remotePortName {
    if (self = [super init]) {
        CFMessagePortContext context = {0, (__bridge void *)self, NULL, NULL, NULL};
        _localPort = CFMessagePortCreateLocal(kCFAllocatorDefault, (__bridge CFStringRef)localPortName, &LocalPortReceivedDataCallback, &context, NULL);
        
        _remotePort = CFMessagePortCreateRemote(kCFAllocatorDefault, (__bridge CFStringRef)remotePortName);
    }
    return self;
}

- (void)sendData:(NSData *)data {
    CFMessagePortSendRequest(_remotePort, 0, (__bridge CFDataRef)data, 0, 0, 0, 0);
}

- (void)connectionReceivedData:(NSData *)data {
    [self.delegate messagePortConnection:self receivedData:data];
}

@end
