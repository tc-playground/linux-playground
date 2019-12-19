# HowTo: Checking Windowing System

1. How to check if the session is using `xorg` or `wayland`.

    ```bash
    loginctl show-session 2 -p Type 
    ```