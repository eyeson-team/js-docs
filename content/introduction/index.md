---
title: "Introduction"
date: 2017-08-04T16:19:03+02:00
---

A JavaScript library to easily connect to video meetings in modern browsers.

- **Simple but powerful**: All you need is an access key. The high level
  abstraction allows easy control of video and audio streams, chat, screen
  capturing, broadcasting, media integration, document presentation and
  hardware device handling.
- **Lightweight**: Besides offering a simple interface for managing complex
  workflows, eyeson has only few external dependencies. This keeps the size and
  potential compatibility risks small.
- **Event Driven**: After creating a session, you have full control on how to
  respond to any events occurring during the session. With a convention based
  action system you can easily customize the experience for your users.
  Depending on your needs, events may be handled in individual interface
  components or managed by a state-drive approach.
- **Framework Agnostic**: Using this event driven system, eyeson is seamlessly
  integrated with other JavaScript libraries and frameworks like Vue, React,
  Angular, or Elm, with or without using additional event handling libraries
  like Redux or RxJS.

## Getting Started

The following snippet is a minimal example of how to connect to an eyeson room.
Assuming you have created the room successfully via the [eyeson API].

```html
<!DOCTYPE html>
<html>
  <head></head>
  <body>
    <video id="video"></video>
    <script>
      eyeson.onEvent(function(event) {
        if (event.type !== "accept") {
          return ;
        }
        var video = document.querySelector("video");
        video.srcObject = event.remoteStream;
        video.play();
      });
      eyeson.start("<access-key>");
    </script>
  </body>
</html>
```

[eyeson API]: https://eyeson-team.github.io/api/ "eyeson API Documentation"
