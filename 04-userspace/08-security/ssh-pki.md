# ssh-kegen adn ssh-agent

## Introduction

* `ssh-keygen` is a tool for creating `ssh public private keypairs` for `Public Key Infrastructure (PKI)`.

* `ssh-agent` is a `daemon` for storing `passphrases` associated with `keys` to avoid being manually propmted for them when required.

---

## Generate a new Public Private Key Pair

1. Check a usable `PKI key pair` does not already exist.

    ```bash
    ls -al ~/.ssh
    ```

2. Generate a new `PKI key pair` (using `RSA` algorithm).

    ```bash
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```

3. Start the `ssh-agent` and register the newly minted `private key`.

    ```bash
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    ```

4. Register the newly minted `public key` with any systems than require `proof of identity`.
