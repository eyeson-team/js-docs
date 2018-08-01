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
var handleEvent = function() { /* ... */ };

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

## Using the EventTarget Web API

If you want to handle the eyeson events via the [EventTarget API] you can use
the following snippet.

```JavaScript
eyeson.onEvent(new eyeson.dispatchOn(window));
eyeson.start(token)
/* then listen for events */
window.addEventListener("eyeson_conf", handleEvent);
window.addEventListener("eyeson_conf.receive_chat", handleIncomingChatMessage);
```

## Sending Events

There are two types of sending procedures `send` and `signal`. The first
method, `send`, is the default and widely used. However you might require to
send some events directly to the current session in that case use `signal`
instead. Which method should be used depends on the event type and is further
described in the corresponding event details.

```JavaScript
eyeson.send(msg);   // send an event.
eyeson.signal(msg); // send a direct message to the current session.
```

Find more details about the types of events to be received and send in the
[events section](events/).

## Configuration

If you are not planning to provide screen capturing, you can deactivate it in
the configuration.

```JavaScript
eyeson.config.screencapture = false;
```

[EventTarget API]: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget "EventTarget API Documentation"
