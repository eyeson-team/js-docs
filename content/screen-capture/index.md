---
title: "Screen Capture"
date: 2017-08-29T15:45:12+02:00
---

## Screen Capture Browser Extension

In order to provide screen capturing you have to build a browser extension for
Google Chrome.

- Use [eyeson extension].
- Build your own extension, checkout this [blog post].

Note: Mozilla Firefox supports screen capturing without building using a
browser extension.

## Screen Capture Events

### request_screen
### receive_screen
### end_screen

### ext\_error

Browser extension is not accessible.

```JavaScript
{
}
```

## Screen Capture Session

Wrapper and helpers to ease handling of screen capture sessions.

```JavaScript
eyeson.ScreenCaptureSession
```

[blog post]: https://techblog.eyeson.team/post/screen-sharing/ "How to build a screen sharing extension for Chrome"
[eyeson extension]: https://chrome.google.com/webstore/detail/eyeson/bbdcikainjamgglhllfjbkeibiiclnck "eyeson | Chrome Webstore"
