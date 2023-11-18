#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

%hook YTICompactLinkRenderer
+ (BOOL)hasTrackingParams { return NO; }
%end

%hook YTIReelPlayerOverlayRenderer
+ (BOOL)hasTrackingParams { return NO; }
%end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSURL *originalURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=your_video_id&si=abcd1234"];
        NSURLComponents *components = [NSURLComponents componentsWithURL:originalURL resolvingAgainstBaseURL:NO];
        NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray arrayWithArray:components.queryItems];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (name == 'si' OR name BEGINSWITH 'si=')"];
        [queryItems filterUsingPredicate:predicate];
        components.queryItems = queryItems;
        NSURL *cleanedURL = components.URL;

        if (cleanedURL) {
            [[UIApplication sharedApplication] openURL:cleanedURL options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"URL opened successfully!");
                } else {
                    NSLog(@"Failed to open URL");
                }
            }];
        }
    }
    return 0;
}
