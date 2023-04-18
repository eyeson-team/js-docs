---
title: "Events"
date: 2017-08-04T16:29:43+02:00
---

Events are the core data construct provided by the Eyeson library. Most
interactions with the room will be processed through events. The identifying
attribute of an event is its `type`. _When listening for events the most common
thing you want to do is to respond to an event, commonly distinguished by
conditionals, a switch statement or a factory._

{{< note title="Note" >}}
Eyeson js library will handle some additional events for you in order to
provide a higher level abstraction and for ease of use you will not receive
those events.
{{< /note >}}

## Connection and Setup

### connection

Contains update information about your connection status to the Eyeson API.

```Javascript
{
  type: 'connection',
  connectionStatus: 'fetch_room' | 'connected' | 'access_denied'
}
```

### room\_setup

Received once the real time channel connection is established. This event
contains information about the state of the current room.

```JavaScript
{
  type: 'room_setup',
  content: {
    access_key: 'token-for-room',
    ready: true | false,
    room: {
      id,
      name,
      ready: true | false,
      shutdown: true | false,
      sip: { /* omitted */ } // sip connection credentials
      guest_token: 'token-for-guest'
    },
    team: {
      name
    },
    user: {
      id,
      name,
      avatar,
      guest: true | false,
      ready: true | false,
      sip: { /* omitted */ } // sip connection credentials
    },
    links: {
      self: 'https://api.eyeson.team/rooms/token-for-room',
      gui: 'https://app.eyeson.team/?token-for-room',
      guest_join: 'https://app.eyeson.team/?guest=token-for-guest',
      websocket: 'https://api.eyeson.team/rt?access_key=token-for-room'
    },
    presentation: { /* ... */ },
    broadcasts: [],
    recording: null
  }
}
```

{{< note title="Note" >}}
An Eyeson room server and user may not be available on the first request
therefore there a three status flags included in the response above. Room ready
and user ready status, as well as the top level ready flag combining those two.
{{< /note >}}

### room\_ready

When you establish a real time connection but the Eyeson room isn't ready at
that point (i.e. `room_setup` content ready is false) you'll receive this
separate message once the room is ready.

```JavaScript
{
  type: 'room_ready',
  content: {
    ready: true,
    user: { /* ... */ },
    room: { /* ... */ }
  }
}
```

### fetch\_room

Fetch the room details, provides the room and user information and is also
initially received when a room changes its status to `ready`. The event can be
send to the Eyeson room and will return with same type when a response is
received.

```JavaScript
eyeson.send({ type: 'fetch_room' });
```

```JavaScript
{
  type: 'fetch_room',
  room: { /* ... */ }
}
```

### accept

Received once a session for the room has been established.

```JavaScript
{
  type: 'accept',
  remoteStream: MediaStream, // the remote stream you're receiving
  localStream: MediaStream   // your local stream
}
```

### stream\_update

Remote or local stream has been updated and needs to be replaced.

```JavaScript
{
  type: 'stream_update',
  stream: MediaStream,     // new remote stream
  localStream: MediaStream // new local stream
}
```

### disconnect

User has disconnected. If providing a presentation feature you should ensure to
close any active presentation held by this user, and on demand remember to
restore on reconnect.

```JavaScript
{
  type: 'disconnect'
}
```

### reconnect

A user has reconnected, received after [disconnect](#disconnect).

```JavaScript
{
  type: 'reconnect'
}
```

### podium

A user has muted the camera, left the room or started a screen capture session.
Every connected source, video source indexes and an optional presenter source
index are provided.

```
{
  type: 'podium',
  sfu: true | false,                 // selective forwarding is enabled
  solo: true | false,                // client is the only participant
  audio: true | false,               // client participates with audio (is "hearable")
  video: true | false,               // client participates with video (is "visible")
  media: true | false,               // source list includes media (e.g. gifs or video files)
  sources: sources,                  // list of source ids
  isSource: true | false,            // client is a source
  isPresenter: true | false,         // client is presenter
  hasPresenter: true | false,        // a participant is presenting
  videoSources: videoSources,        // list of video sources
  userDimensions: {x, y, w, h}       // viewbox of current user on the remote stream
  hasVideoSources: true | false,     // session has video sources
  hasDesktopSources: true | false,   // session has desktop sources
  forwardedVideoMuted: true | false  // forwarded video (sfu) is muted
}
```

## Chat

Any meeting provides a temporary real-time chat that can be used and customized
for many applications.

### chat

Receive a chat message.

```JavaScript
{
  type: 'chat',
  user: {
    name,
    avatar
  }
  timestamp, // JavaScript Date
  content
}
```

### send_chat

Send a chat message.

```JavaScript
eyeson.send({
  type: 'send_chat',
  content
});
```

## Joining and Leaving Users

### add\_user

A new user has joined the Eyeson room.

```JavaScript
{
  type: 'add_user',
  user: {
    id,
    name,
    avatar, // url to users avatar
    guest: true | false
  }
  initial: true | false // initial connect or reconnect
}
```

### remove\_user

A user has left the Eyeson room.

```JavaScript
{
  type: 'remove_user',
  userId,
  user: {
    id,
    name,
    avatar,
    guest: true | false
  }
}
```

### stop\_presenting

Stop a presentation.

```JavaScript
eyeson.send({ type: 'stop_presenting' };
```

## Recording

### start\_recording

Start a recording. The message is delivered to all users.

```JavaScript
eyeson.send({ type: 'start_recording' });
```

```JavaScript
{
  type: 'start_recording',
}
```

### stop\_recording

Stop a recording. The message is delivered to all users.

```JavaScript
eyeson.send({ type: 'stop_recording' });
```

```JavaScript
{
  type: 'stop_recording'
}
```

### recording\_update

Received when the rooms recording state is updated.

```JavaScript
{
  type: 'recording_update',
  recording: {
    id: '598d8812ac605e3e4892470b',
    created_at, // Timestamp
    duration, // in seconds
    links: {
      self: 'https://api.eyeson.team/recordings/598d8812ac605e3e4892470b',
      download: null
    },
    user: {
      id,
      name,
      avatar,
      guest,
    },
    room: {
      id,
      name,
      ready: true | false,
      shutdown: true | false,
      sip: { /* ... */ },
      guest_token
    }
  }
}
```

## Broadcast

### start\_rtmp

Start an RTMP live stream.

```JavaScript
eyeson.send({
  type: 'start_rtmp',
  url,
  key
});
```

### stop\_rtmp

Stop an RTMP live stream.

```JavaScript
eyeson.send({ type: 'stop_rtmp' });
```

### publish\_broadcast

Received after a broadcast has been published to the streaming platform.

```JavaScript
{
  type: 'publish_broadcast',
  playerUrl
}
```

### start\_youtube

Start a YouTube live stream.

```JavaScript
eyeson.send({
  type: 'start_youtube',
  broadcastId,
  playerUrl,
  streamUrl
});
```

### stop\_youtube

Stop a YouTube live stream.

```JavaScript
eyeson.send({ type: 'stop_youtube' });
```

### stop\_broadcasts

To stop all currently running broadcasts

```JavaScript
eyeson.send({ type: 'stop_broadcasts' });
```

### handle\_youtube\_error

A YouTube error was received.

```JavaScript
{
}
```

### broadcasts\_update

One or more broadcast/s was/were updated.

```JavaScript
{
  type: 'broadcasts_update',
  broadcasts: [
    {
      id,
      platform: 'youtube',
      player_url,
      user: { /* ... */ },
      room: { /* ... */ }
    }
  ]
}
```

## Snapshot

Create a snapshot.

```JavaScript
eyeson.send({ type: 'snapshot' });
```

After a snapshot was created, all clients receive the `snapshot_update` event.\
Note that the download link expires after a certain time.

```JavaScript
{
  type: 'snapshot_update',
  snapshots: [
    {
      created_at,
      creator: { /* ... */ },
      id,
      links: { download }
      name,
      room: { /* ... */ }
    }
  ]
}
```

## Error Handling and Notifications

### error

Error events are thrown whenever a connection can not be established due to
numerous reasons.

- `devices`, `permission`, `not_readable` ... there's no device available
  (note that audio device is required)
- `session_in_use` ... a session with the same access-key is currently active
- `meeting_locked` ... meeting is locked, no new pasrticipants are allowed
- `abrupt_disconnect` ... critical connections have dropped unexpectedly and
  could not get re-established automatically
- `request_too_large` ... problem during Interactive Connectivity Establishment
  (ICE) at the beginnging of the session
- `ice_failed` ... the active peer connection dropped (no audio/video anymore).
- `ice_error` ... unable to establish the peer connection to meeting server
- `session_failed` ... generic reason whenever session fails unexpectedly and
  has not been ablo to re-connect

```JavaScript
{
  type: 'error',
  name
}
```

### warning

The following warnings are sent by the Eyeson room.

- `ice_disconnected` ... Interactive Connectivity Establishment (ICE) protocol
  reports the users connection to be gone. You might want to show your client a
  "offline" warning here.
- `error:comapi` ... request to ComAPI failed
- `chat_message_too_long` ... chat message size is currently limited to 32 kB
  (incl. message headers)
- `error_NotReadableError`, `error_DevicesNotFoundError`, `error_NotFoundError`
  are reported if automatic device mediastream allocation failes


An issue described by `name` was detected.

```JavaScript
{
  type: 'warning',
  name
}
```

### clear\_warning

An issue described by `name` has been resolved.

```JavaScript
{
  type: 'clear_warning',
  name
}
```

## Quick Join / Guest Access

### request\_guest\_user

With a given guest\_access\_token you can quickly create temporary users for
the current Eyeson room meeting. This can be used to provide a direct quick
join or guest access. The guest\_access\_token will be provided with the
room information.

```JavaScript
eyeson.send({
  type: 'request_guest_user',
  api: this.eyeson.config.api, // set api as Eyeson is not yet initialized
  token, // guest_access_token
  name,
  email, // optional
  locale // optional, preferred language code (en, de, fr)
});
```

### guest\_user

Receive a newly created guest user. This is same response as for a regular user
but has an additional guest flag set to `true`.

```JavaScript
{
  type: 'guest_user',
  token
}
```

## Stream Control

### start\_stream

After a presentation ends, re-start the local stream with the previously active
options.\
It can also be used after devices are changed. See [`Device Manager`](/utilities/#device-manager) for further information.\
If `screen = true`, `video => false`.

```JavaScript
eyeson.send({
  type: 'start_stream',
  audio: true | false, // default: true
  video: true | false, // default: true
  screen: true | false, // default: false
});
```

The `screen` parameter is used to switch from camera to screen stream.
Use the `surface` option to pre-select the desired options. Skip or set `null` for browser default. Detect availablility for UI with `FeatureDetector.canChooseDisplaySurface()`. [More info](https://developer.chrome.com/docs/web-platform/screen-sharing-controls/#displaySurface).

```JavaScript
eyeson.send({
  type: 'start_stream',
  audio: true | false, // set true to add microphone
  screen: true,
  surface: null | 'monitor' | 'window' | 'browser' // optional; used only if screen=true
});
```

### change\_stream

Update a stream e.g. to toggle audio/video/screen. \
_Note:_ To avoid issues with some devices, you can use [`StreamHelpers`](/utilities/#streamhelpers)
to toggle audio.

```JavaScript
eyeson.send({
  type: 'change_stream',
  audio: true | false,
  video: true | false,
  screen: true | false,
  surface: null | 'monitor' | 'window' | 'browser' // optional; used only if screen=true
});
```

### toggle\_camera

Update the cameras facing mode on mobile devices.

```JavaScript
eyeson.send({
  type: 'toggle_camera',
  stream: localStream,
  facingMode: 'user' | 'environment'
});
```

### replace\_stream

Replace current stream with any custom MediaStream.\
_(First audio track and/or first video track with `readyState = "live"` are used)_

```JavaScript
eyeson.send({
  type: 'replace_stream',
  stream
});
```

### change\_screen\_video

Trigger screenshare selection during screen cam. [Further information](https://techblog.eyeson.team/posts/screen-cam/).

```JavaScript
eyeson.send({ type: 'change_screen_video' });
```

## Device End Events

Since v1.7.1, Eyeson detects broken microphone and camera streams.\
Camera will be switched off and Microphone will automatically try changing to a
new available device.

### audio\_device\_ended

Broken microphone stream, changed to a new device.

```JavaScript
{
  type: 'audio_device_ended',
  newAudioDevice: '<new audio device label>' | undefined
}
```

### video\_device\_ended

Broken camera stream, video is muted.

```JavaScript
{
  type: 'video_device_ended'
}
```

### all\_devices\_ended

Broken microphone and camera streams, changed to a new audio device, video is
muted.

```JavaScript
{
  type: 'all_devices_ended',
  newAudioDevice: '<new audio device label>' | undefined
}
```

