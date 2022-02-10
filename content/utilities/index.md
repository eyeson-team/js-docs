---
title: "Utilities"
date: 2017-08-08T12:18:31+02:00
---

Use eyeson js library additional helpers and utilities to minimize the work
needed to setup your own video conferencing interface.

## Logger

Collect and manage development, debug, and error messages in one place.

```JavaScript
import { Logger } from 'eyeson';

Logger.error(msg); // output error
Logger.warn(msg);  // output warning
Logger.log(msg);   // output log
Logger.debug(msg); // output debug
```

## Device Manager

Manage audio and video device settings.\
_Note:_ Always make sure to call `storeConstraints` after devices are changed, so that
a following [`start_stream`](/events/#start_stream) will actually use them.

```JavaScript
import { DeviceManager } from 'eyeson';

const deviceManager = new DeviceManager();
deviceManager.onChange(event => { // changeHandler
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
deviceManager.setVideoInput(deviceId); // switch camera
deviceManager.setAudioInput(deviceId); // switch microphone
deviceManager.setAudioOutput(sinkId); // switch audio output, speakers
deviceManager.storeConstraints(); // store current selection
deviceManager.removeListener(changeHandler); // remove listeners if registered via onChange
deviceManager.stop(); // stop checking device changes
```

## Feature Detector

Detect user agents capabilities in order to provide user friendly
notifications, messages, and fallbacks instead of relying on browser
identification techniques.

```JavaScript
import { FeatureDetector } from 'eyeson';

FeatureDetector.canUseEyeson();
FeatureDetector.canScreenCapture();
FeatureDetector.inIframe();
FeatureDetector.hasMobileDevice();
```

The Feature Detector also provides lower level checks that are used in the
library itself or to provide specific advises to an end user. You propably
won't need them but for the sake of completeness:

```JavaScript
FeatureDetector.canToggleCamera();
FeatureDetector.canFullscreen();
FeatureDetector.canPip();
FeatureDetector.canSFU();
```

## StreamHelpers

A collection of utilities to identify and adjust specific tracks within the stream.
There are numerous methods, but the following come in handy to toggle audio.

```JavaScript
import { StreamHelpers } from 'eyeson';

StreamHelpers.toggleAudio(stream, enabled); // enabled can be true or false
```

## Sound Meter

Read volumne input level from a media stream.

```JavaScript
import { SoundMeter } from 'eyeson';

const soundMeter = new SoundMeter();
soundMeter
  .connectToSource(stream) // bind stream, listen for audio
  .onUpdate(event => { // listen on updates
    event.error, // an error occurred, default: null
    event.value  // audio level between 0 and 100
  };
soundMeter.stop(); // stop checking the stream for audio
```

## YouTube API

```JavaScript
import eyeson, { YoutubeApi } from 'eyeson';

const ytApi = new YoutubeApi(eyeson);
// TODO...
```

## Debounce Helper

Efficiently execute a function but not more often than the given wait time (in
milliseconds) limits to. Use the immediate flag to indicate if the function
should be executed before or after the wait time.

```JavaScript
import { debounce } from 'eyeson';

debounce(func, wait, immediate); // debounce function
```

Use this method to enhance performance on several executions. Let's say you
want to act on a browser window resize, simply listening on the event may
execute a lot. When wrapping your handler by debounce you may execute it
only every 100ms, still providing a real-time-feeling for your user but with
much better performance and smoother look and feel.
