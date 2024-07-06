# MessagePortConnection

A simple bidirectional cross-process communication class based on `CFMessagePort`, based on the method discussed here: https://ddeville.me/2015/02/interprocess-communication-on-ios-with-mach-messages/. As mentioned in the post this can be used for cross-process communication on iOS app store apps between processes sharing the same app group by using two port names prefixed with the app group identifier - `com.company.app.group.*`.



This class is barebones and missing things like error handling, connection invalidation handling, message replys, and a dedicated queue for message handling. It only supports sending and receiving raw data, bring your own serialization method.



After a quick and dirty benchmark I found this is roughly 3x faster than a socket-based XPC implementation for communication between an app process and extension process.

