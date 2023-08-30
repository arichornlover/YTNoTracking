%hook YTICompactLinkRenderer

- (BOOL)hasTrackingParams { return NO; }

%end

%hook YTIReelPlayerOverlayRenderer

- (BOOL)hasTrackingParams { return NO; }

%end
