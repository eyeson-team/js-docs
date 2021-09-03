---
title: "Overview"
date: 2017-08-04T16:32:40+02:00
---

The library is globally available via `eyeson` and lets you connect to any
eyeson room.

## Public Interface

Two of the most common things you want to do with the library are:

- Let a user join a room
- Respond to things happening inside the room

In order to receive eyeson room events register a listener using the `onEvent`
method provided. Remember to register a handler before starting a room
otherwise you might miss some initial events.

```JavaScript
const handleEvent = function() { /* ... */ };

eyeson.onEvent(handleEvent);  // attach listener for eyeson events
eyeson.start(token);          // initiate and join the room
eyeson.destroy();             // destroy and cleanup a session
eyeson.offEvent(handleEvent); // remove listener for eyeson events
```

_Note_ that `start` is a convenient shorthand which handles connecting, fetching
initial data and joining the room for you. If you want more granular control
over this process you can always use corresponding lower level methods:

```JavaScript
eyeson.onEvent(function(event) {
  if(event.connectionStatus !== 'connected') {
    return ;
  }
  eyeson.join({ audio: true, video: true });  // join the room with audio and video
});
eyeson.connect(token);                      // prepare connection
```

Since v1.6.2 you can even start or join with any custom MediaStream

```JavaScript
eyeson.start('<access_key>', { stream });
```

## Using the EventTarget Web API

If you want to handle the eyeson events via the [EventTarget API] you can use
the following snippet.

```JavaScript
eyeson.onEvent(function (event) {
  window.dispatchEvent(new CustomEvent('eyeson', { detail: event }));
  window.dispatchEvent(new CustomEvent('eyeson.' + event.type, { detail: event }));
});
eyeson.start(token);
/* then listen for events */
window.addEventListener('eyeson', handleEvent);
window.addEventListener('eyeson.chat', handleIncomingChatMessage);
```

## Sending Events

Sending events is a crucial part of interacting with the meeting library. This
way actions can be triggered from the user's end.

```JavaScript
eyeson.send(msg);   // send an event.
```

Find more details about the types of events to be received and send in the
[events section](/events/).

## Configuration

Since v1.5.1 eyeson supports SFU mode in Safari (desktop and mobile). If your
application encounters any issues, you can switch back to previous behaviour.

```JavaScript
eyeson.config.allowSafariSFU = false; // default is true
```

If you are not planning to provide screen capturing, you can deactivate it in
the configuration.

```JavaScript
eyeson.config.screencapture = false;
```

[EventTarget API]: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget "EventTarget API Documentation"
