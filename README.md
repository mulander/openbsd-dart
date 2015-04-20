# openbsd-dart
Work in progres port for dartlang.org for OpenBSD - DO NOT USE IN PRODUCTION

The port started from /usr/ports/www/chromium and currently contains a ton of
stuff that's not really needed. The way the port is perfomed is hacky to say the
least - I want to get a runtime binary running after which I will be attemping
adding proper support for OpenBSD as a new target OS. For now - everything is fair
game - including tricking the build to use android/mac/linux files when it looks
like allowing me to move forward.

By now you shold now not to use this package in production or for any important work.
This repository is published in case anyone wants to chip in to get this done faster
and for me personally to have a backup/record of the work.

This port will be mostly worked on during weekends so don't expect it being finalised
during a couple of days.

Goals
=====

Have a fully functional & working build of dart runtime, sdk & editor for OpenBSD.

Status
======

Ongoing work to make at least the runtime buildable - in a really hacky way for now.

TODO
====

 - Fetch sources - done
 - Generate makefiles - done
 - Use gcc4 - done
 - Build runtime - WIP
 - Build sdk
 - Build editor
 - Clean up the port (remove hacky build stuff / patches - write proper ones)
 - Upstream proper patches