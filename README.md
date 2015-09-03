# openbsd-dart
Work in progress port for dartlang.org for OpenBSD - DO NOT USE IN PRODUCTION

The port started from /usr/ports/www/chromium and currently contains a ton of
stuff that's not really needed. The way the port is perfomed is hacky to say the
least - I want to get a runtime binary running after which I will be attemping
adding proper support for OpenBSD as a new target OS. For now - everything is fair
game - including tricking the build to use android/mac/linux files when it looks
like allowing me to move forward.

By now you shold know not to use this package in production or for any important work.
This repository is published in case anyone wants to chip in to get this done faster
and for me personally to have a backup/record of the work.

This port will be mostly worked on during weekends so don't expect it being finalised
during a couple of days.

Goals
=====

Have a fully functional & working build of dart runtime & sdk for OpenBSD.

Status
======

Ongoing work to make at least the runtime buildable - in a really hacky way for now.
Currently fighting with the nss/nspr build. You can see a full build output in this gist:

 - https://gist.github.com/mulander/4929a40b2c8e9bab4440

I restarted it several times, as subsequent builds tend to pick up other files untill the
whole process settles on a single error.

UPDATE: 2015-05-10 posted to the [dart issue tracker #10260](https://code.google.com/p/dart/issues/detail?can=2&start=0&num=100&q=BSD&colspec=ID%20Type%20Status%20Priority%20Area%20Milestone%20Owner%20Summary%20Modified&groupby=&sort=&id=10260)

The build got pretty far, as in most of dart runtime builds without issues with small modifications to use kqueue/pthreads in some places - so far I 'patched' 36 files where most of them is 'use the mac one instead of linux' or 'use the android one instead of linux' with really rare cases when I actually had to edit the code. I obviously took the recommended "[ 'OS=="openbsd"', { 'dart_target_os': 'Linux', } ]," from comment #5.

Unfortunately I'm also having huge issues with building NSPR similarly to what was reported in comment #7 over an year ago. I'm afraid that without guidance/help I won't be able to move far with the port.

Regardless, it would be nice if the project had a porting guide for new platforms. I did not find any documentation that would tell me how the project build system works & how it should be configured. I don't know why the third party libs are bundled with the distribution & how to untangle them to use the system wide installed & already ported libraries. I assume the project has reasons for that but this leads to duplicate effort in software porting on the platform side.

The current state is of course uploaded to the github account linked in comment #10.

UPDATE: 2015-08-23

The dart issue tracker is obviously gone. The case was migrated as https://github.com/dart-lang/sdk/issues/10260. I'm roughly waiting for the upstream to migrate to BoringSSL as anything else feels like a waste of time. This is reported as https://github.com/dart-lang/sdk/issues/23560 which is currently marked as blocked by https://github.com/dart-lang/sdk/issues/23561. The repo state was tested against Dart v1.10.0, I tried locally against v1.11.3 but most patches no longer apply and there is no point in trying until upstream migrates to BoringSSL.

UPDATE: 2015-09-02

Dart 1.12 has been released and the blocker for BoringSSL work has been closed (https://github.com/dart-lang/sdk/issues/23561). The main task is still ongoing in https://github.com/dart-lang/sdk/issues/23560. This left me with 2 options.

- wait for a release so I can reuse their tarball mechanism
- fork the repo and try to add *proper* OpenBSD support

I decided to do it the proper way. It will probably impact hugely the amount of time required to finish the port but should have a higher quality port in the end with a higher chance of upstreaming the changes.

All work is done in https://github.com/mulander/sdk OpenBSD-support branch. Any work done on the port is possible thanks to [Koparo](https://koparo.com) supporting the project.

UPDATE: 2015-09-04

Started to move forward with the port.
 - Current effort can be tracked in [this](https://github.com/mulander/sdk/commits/OpenBSD-support) repository
 - [Reported](https://github.com/dart-lang/sdk/issues/10260) the efforts upstream
 - [Reported](https://github.com/dart-lang/sdk/issues/24287) outdated gclient setup
 - [Reported](https://github.com/dart-lang/sdk/issues/24289) the build system ignoring environment variables

The effort will be ongoing. This repository will get semi frequent status updates. Follow the [main fork](https://github.com/mulander/sdk) for up to the minute changes.


Contributing
============

Start by forking the repository & checking it out to `/usr/ports/mystuff/lang/dart`.
You should now be able to go through:

 - `make fetch`
 - `make checksum`
 - `make configure`
 - `make build`

Pick a build error you want to tackle. Go to the port directory (`cd ``make show=WRKSRC`).
Make an .orig file (`cp target.c{,.orig}`) and apply your changes to target.c. When done
`cd - && make update-patches`.

Rinse & repeat - comitting after each fixed issue. Send a pull request when you're happy :)

Please use github issues to discuss/suggest changes to the port itself.

TODO
====

 - Fetch sources - done
 - Generate makefiles - done
 - Use gcc4 - done
 - Build runtime - WIP
 - Build sdk
 - ~~Build editor~~ - no point since the dart team bailed on it
 - Clean up the port (remove hacky build stuff / patches - write proper ones)
 - Upstream proper patches
