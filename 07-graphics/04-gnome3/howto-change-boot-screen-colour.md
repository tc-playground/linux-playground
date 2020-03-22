# Howto: Make the Ubuntu startup screen black

## Steps

1. Open the plymouth theme:  `/usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script`

2. Change the colour (to black):

    ```
    Window.SetBackgroundTopColor (0.0, 0.00, 0.0);     # Nice colour on top of the screen fading to
    Window.SetBackgroundBottomColor (0.0, 0.00, 0.0);  # an equally nice colour on the bottom
    ```

3. Update `initramfs`:

    ```
    sudo update-initramfs -u
    ```