---
title: "Utilities"
date: 2017-08-08T12:18:31+02:00
---

Use eyeson js library additional helpers and utilities to minimize the work
needed to setup your own video conferencing interface.

## Logger

Collect and manage development, debug, and error messages in one place.

```JavaScript
eyeson.Logger.error(msg); // output error
eyeson.Logger.warn(msg);  // output warning
eyeson.Logger.log(msg);   // output log
eyeson.Logger.debug(msg); // output debug
```

## Device Manager

Manage audio and video device settings like a boss.

```JavaScript
const deviceManager = new eyeson.DeviceManager();
deviceManager.onChange(function(event) { // changeHandler
  event.error; // if set it contains { name, message }, default null
  event.cameras; // available cameras
  event.microphones; // available microphones
  event.speakers; // available speakers
  event.sinkId; // available sinkId (audio output selection)
  event.stream; // stream to test devices with
  event.constraints; // selected media constraints
  event.options; // selected options
});
deviceManager.start(); // start checking device changes
deviceManager.setVideoInput(camera); // switch camera
deviceManager.setAudioInput(microphone); // switch microphone
deviceManager.setAudioOutput(speaker); // switch speaker
deviceManager.storeConstraints(); // store current selection
deviceManager.removeListener(changeHandler); // remove listeners if registered via onChange
deviceManager.stop(); // stop checking device changes
```

## Feature Detector

Detect user agents capabilities in order to provide user friendly
notifications, messages, and fallbacks instead of relying on browser
identification techniques.

```JavaScript
eyeson.FeatureDetector.canUseEyeson();
eyeson.FeatureDetector.canScreenCapture();
eyeson.FeatureDetector.canChangeAudioOutput();
eyeson.FeatureDetector.isAndroidDevice();
eyeson.FeatureDetector.isIOSDevice();
eyeson.FeatureDetector.inIframe();
eyeson.FeatureDetector.hasMobileApp();
```

The Feature Detector also provides lower level checks that are used in the
library itself or to provide specific advises to an end user. You propably
won't need them but for the sake of completeness:

```JavaScript
eyeson.FeatureDetector.canHandleMediaStreams();
eyeson.FeatureDetector.canHandlePeerConnection();
eyeson.FeatureDetector.canHandleIceConnection();
eyeson.FeatureDetector.canUpdatePeerConnection();
eyeson.FeatureDetector.hasSenderReceiverSupport();
eyeson.FeatureDetector.canUseVp8Codec();
```

## Sound Meter

Read volumne input level from a media stream.

```JavaScript
const soundMeter = eyeson.SoundMeter.new();
soundMeter
  .connectToSource(stream) // bind stream, listen for audio
  .onUpdate(function(event) { // listen on updates
    event.error, // an error occurred, default: null
    event.value  // audio level between 0 and 100
  });
soundMeter.stop(); // stop checking the stream for audio
```

## YouTube API

```JavaScript
const ytApi = new eyeson.YoutubeApi(eyeson);
// TODO...
```

## Facebook API

```JavaScript
const fbApi = new eyeson.FacebookApi(eyeson);
// TODO...
```

## Date Helper

Very basic date formatting helpers.

```JavaScript
eyeson.date.ensureDate(date); // convert number, string or Date to Date
eyeson.date.formatDate(date); // format with toLocalDate (with fallback)
eyeson.date.monthNames; // ['January', ... ]
eyeson.date.beautifulDate(date); // neat date format, 'November 25th, 2016'
eyeson.date.formatTime(date); // format with toLocaleTimeString (with fallback)
```

## Debounce Helper

Efficiently execute a function but not more often than the given wait time (in
milliseconds) limits to. Use the immediate flag to indicate if the function
should be executed before or after the wait time.

```JavaScript
eyeson.debounce(func, wait, immediate); // debounce function
```

Use this method to enhance performance on several executions. Let's say you
want to act on a browser window resize, simply listening on the event may
execute a lot. When wrapping your handler by debounce you may execute it
only every 100ms, still providing a real-time-feeling for your user but with
much better performance and smoother look and feel.
