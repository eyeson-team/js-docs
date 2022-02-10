---
title: "eyeson JS Library"
date: 2017-08-04T15:55:33+02:00
type: index
weight: 0
---

This library provides a convenient interface between your browser and the eyeson
API and is used at [eyeson.team].

- **Simple and powerful**: All you need is an access key. The high level
  abstractions allow easy control of video and audio streams, chat, screen
  capturing, broadcasting, media integration, document presentation and
  hardware device handling.
- **Lightweight**: Besides offering a simple interface for managing complex
  workflows, eyeson has only few external dependencies. This keeps the size and
  potential compatibility issues small.
- **Event Driven**: After creating a session, you have full control over how to
  respond to any events occurring during the session. With a convention based
  action system you can easily customize the experience for your users.
  Depending on your needs, events may be handled in individual interface
  components or managed by a state-drive approach.
- **Framework Agnostic**: Using this event driven system, eyeson is seamlessly
  integrated with other JavaScript libraries and frameworks like Vue, React,
  Angular, or Elm, with or without using additional event handling libraries
  like Redux or RxJS.

You can start your own video conferencing app with a few lines of JavaScript:

```js
eyeson.onEvent(event => {
  if (event.type === 'accept') {
    // Note: Some iOS devices might require video to have autoplay attribute set.
    const video = document.querySelector('video');
    video.srcObject = event.remoteStream;
    video.play();
  }
});
eyeson.start('<access-key>');
```

Visit the [overview](overview/) section of this guide to familiarize yourself
with some general concepts of the library.

The [events](events/) section is a handy reference of all events the library
exposes during a conference session.

Building a web UI for video conferencing can be quite challenging. To ease
the process, we provide a couple of tools which might be useful to you. For
example a sound meter which provides the current volume level of the microphone,
a device manager, screen capture helpers and many more. Head over to
[utilities](utilities/).

If you have a question that's not answered in the documentation or you're not
sure the eyeson services will fit your particular needs, shoot us a
[message](mailto:developers@eyeson.team) or open a [GitHub issue]. We're happy
to help.

[eyeson.team]: https://eyeson.team/ "eyeson Team Video Meetings"
[GitHub issue]: https://github.com/eyeson-team/js-docs/issues
