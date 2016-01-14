# fcron docker container

This container is based on the latest stable version (3.2.0).

It is intended as an alternative to cron and anacron.

Put your fcrontabs (see http://fcron.free.fr/doc/en/fcrontab.5.html) in /fcrontabs (filenames should end with .fcrontab)

You can communicate with the daemon using fcrondyn (see http://fcron.free.fr/doc/en/fcrondyn.1.html)

## About fcron

Fcron is a periodical command scheduler which aims at replacing Vixie Cron, so it implements most of its functionalities.

But fcron makes no assumptions on whether your system is running all the time or regularly : you can, for instance, tell fcron to execute tasks every x hours y minutes of system up time or to do a job only once in a specified interval of time.

Fcron has also much more functionalities : you can also set a nice value to a job, run it depending on the system load average and much more !

For more details, see [fcron](http://fcron.free.fr).