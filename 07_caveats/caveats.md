!SLIDE

# Caveats #

!SLIDE

## DON'T BLOCK THE EVENT LOOP! ##

!SLIDE bullets incremental

* Callbacks run till finished
* Make them fast

!SLIDE bullets incremental

## Avoid Blocking Code in Event Loop ##

* Because it blocks the event loop
* `Net::HTTP` -> `EM::HttpRequest`

!SLIDE

## Can't I just run Rails inside EventMachine ##

!SLIDE bullets

## Yes, and no ##

* Processing kills the event loop
* Short and predictable requests

!SLIDE

## EventMachine ≠ Scaling Silver Bullet ##

!SLIDE bullets

## Harder to Debug ##

!SLIDE center

![Dude, where's my stack?](dude_wheres_my_car.jpg)

!SLIDE

## DON'T BLOCK THE EVENT LOOP! ##

!SLIDE

# Or Just Use Erlang #

!SLIDE

# Thanks! #
