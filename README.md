# Nerves Pinger

Tinkertime project to build a basic Pingu-like probe thing using Nerves. The
current version consists of two separate applications (both in this repo): a
Nerves application (`pinger` for the business logic and `firmware` for teh
Nerves stuff) which runs on a Raspberry Pi and runs network checks, and a
Phoenix web server (`ui`) which runs on a server and collates results
(currently only fro mone probe and only persisted in memory). The Pi posts new
results to the Phoenix app.

Everything is currently set up to run for test/demo with `ui` running on a Mac
connected to Wifi, and the Pi connected to the Mac using Internet Sharing.

You should be able to ssh into the Pi and get an iex prompt (it should be on
192.168.2.2, which you can map to `nerves.local` or whatever in your `hosts`
file). The `pinger` app is hard-coded to post results to 192.168.2.1, which
should be the Mac's address on the shared network.

To escape the remote iex session, type `~.` or run `:c.q` (the usual ^C^C or ^G
won't work).

There's a `Makefile` at the top level to run common tasks (build firmware, burn
to SD card, upload firmware update to Pi over ssh).
