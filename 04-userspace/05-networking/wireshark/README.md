# Wire Shark

## Configure non-root user for Wireshark

1. Reconfigure wireshark to allow non-root users:

    ```
    sudo dpkg-reconfigure wireshark-common
    ```

2. Add permitted users to the `wireshark` group:

    ```
    sudo usermod -a -G wireshark <user>
    ```