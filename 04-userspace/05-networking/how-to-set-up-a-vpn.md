# How to set Up a VPN

## Steps

1. Provision and log into target Debian machine.

    ```bash
    ssh root@${IP}
    ```

    * If desired set upload a `public key` and disable password based log-in instead

        ```bash
        ssh-copy-id root@${IP}
        ---
        # vim /etc/ssh/sshd_config
        # Replace 'PasswordAuthentication yes' with 'PasswordAuthentication no'
        ---
        service ssh restart
        ```

2. Install the `OpenVPN Server`. Read and check the `OpenVPN Install script`. If happy then execute it:

    ```bash
    wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
    ```

3. Download the `OpenVPN Tunnel Config` from the target machine to the client machine.

    ```bash
    scp ${user}@$[ip}:${path-tpo}/${vpn-name}.ovpn:.
    ```

4. Install `OpenVPN` on the client machine.

    ```bash
    sudo apt-get install openvpn
    ```

5. Open a tunnel to the `OpenVPN server`:

    ```bash
    sudo openvpn ${path-tpo}/${vpn-name}.ovpn
    ```



---

## References

* [OpenVPN Home](https://openvpn.net/)

* [OpenVPN Debian Installer](https://github.com/Nyr/openvpn-install)

* [https://www.youtube.com/watch?v=IneAGgh9hQg - YouTube](https://www.youtube.com/watch?v=IneAGgh9hQg)