# rAnnouncer
My first decently sized project for FiveM. rAnnouncer is an announcement system which allows you to send announcements and/or updates to your FiveM chat every (by default, can be changed) 5 minutes.

Messages (for now) have to be added through the config.lua

(psssst: rAnnouncer stands for RocketAnnouncer)

## Convars

Color convars are 1/3 of an entire RGB set.

| Name          | Description           | Convar       | Default |
|---------------|-----------------------|--------------|---------|
| Prefix        | Message prefix.       | ra_prefix    |  System |
| Wait Time     | Time between messages | ra_wait_time | 300     |
| Color (Red)   | Message color (Red)   | ra_color_r   | 255     |
| Color (Green) | Message color (Green) | ra_color_g   | 0       |
| Color (Blue)  | Message color (Blue)  | ra_color_b   | 0       |

You can also just change this through the config.lua.

## Notes

Any convar changed automatically overwrites the config values, as the configs are just defaults. So, when you change a convar, it does not use the configuration value.

The 3 colors are used to form the RGB set, so it would be 255, 0, 0, making the PREFIX COLOR red.
