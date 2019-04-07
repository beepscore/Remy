# Purpose
Remote control television by sending commands from iOS device to a server.
For example, the server may be on a Raspberry Pi on local wifi network.
The Raspberry Pi may have an infrared LED and operate as an infrared remote control.

# References

## Swift iOS to Raspberry Pi TV Remote Control
http://beepscore.com/website/2019/02/08/swift-ios-to-raspberry-pi-tv-remote-control.html

## iOS - Detect Blow into Mic and convert the results! (swift)
https://stackoverflow.com/questions/31230854/ios-detect-blow-into-mic-and-convert-the-results-swift

## How to monitor audio input on ios using swift - example?
https://stackoverflow.com/questions/35929989/how-to-monitor-audio-input-on-ios-using-swift-example

## Network enabled Raspberry Pi tv remote control
http://beepscore.com/website/2019/02/05/network-enabled-raspberry-pi-tv-remote-control.html

## remy_python
Make a Python app with two parts:
- A Flask web service to accept television command requests (e.g. volume decrease, volume increase).
- A way to send commands to a transmitter, which then transmits the commands to the television (e.g. via infrared light). The app may run on a Raspberry Pi with an attached infrared transmitter and use LIRC (Linux Infrared Remote Control).

https://github.com/beepscore/remy_python

## Phoney
Phoney is an iOS application to experiment with testing phone calls. 
branch request_web_service_end_call
https://github.com/beepscore/Phoney

# Results
See code and tests.

## unit tests
Unit tests may be run in simulator or on device.
Need to grant microphone permission to iPhone or to macOS running simulator.

### how to fix unit tests not running on device
The device may get into a state where tests "fail" immediately e.g.

    Remy.app encountered an error (Failed to establish communication with the test runner.
    (Underlying error: Unable to connect to test manager on 91281e8da160abcce5dad7950c47fbf64f02f8e3.
    (Underlying error: kAMDMuxConnectError: Could not connect to the device.)))

I think one way this can happen if the user denied the app microphone permission.

To fix this, delete app from device. Turn device completely off and back on. Reinstall app.

Run tests, grant microphone permission.

See also https://stackoverflow.com/questions/53643318/xctests-canceling-prematurely

