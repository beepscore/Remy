# Purpose
Remote control television by sending commands from iOS device to a server.
For example, the server may be on a Raspberry Pi on local wifi network.
The Raspberry Pi may have an infrared LED and operate as an infrared remote control.

# References

## remy_python
Make a Python app with two parts:
- A Flask web service to accept television command requests (e.g. volume decrease, volume increase).
- A way to send commands to a transmitter, which then transmits the commands to the television (e.g. via infrared light). The app may run on a Raspberry Pi with an attached infrared transmitter and use LIRC (LInux Infrared Remote Control).

https://github.com/beepscore/remy_python

## Phoney
Phoney is an iOS application to experiment with testing phone calls. 
branch request_web_service_end_call
https://github.com/beepscore/Phoney

# Results

