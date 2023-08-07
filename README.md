# Podman LaTeX
A LaTeX environment to work in a podman container with VSCode and especially on `arm64` architecture. Comes with a CloudRef webserver to manage your bibliography (see **CloudRef**). You will also install [LTeX](https://marketplace.visualstudio.com/items?itemName=valentjn.vscode-ltex) in the process, configured for German language and with a Java JRE inside the container (see **Java Path**).

# Getting started
1. Clone the repository.
    ```bash
    git clone https://github.com/brunobeeee/docker-latex-arm
    ```

2. Initialize and start youre podman machine.
    ```bash
    podman machine init
    podman machine start
    ```

2. Run the container.
    ```bash
    cd docker-latex-arm
    podman-compose build
    podman-compose up -d
    ```
    This builds the image and runs the container in detached mode.

3. Open VSCode and install the following extensions if not present.
- [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
- [Remote - Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer)
- [Remote - SSH: Editing Configuration Files](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh-edit)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

4. Find out where youre podman machine is running.
    ```bash
    podman machine connection ls
    ```
    Copy the URI of the machine you created. It should look something like this: `ssh://user@host:port`. Do not copy the `ssh://`.

5. In VSCode open the Remote-Explorer extension on the sidebar and select the "Remotes" tab. Click on the `+`-Button on the top left corner and paste the URI you copied in the previous step. Then choose the SSH config file you want to store this connection in. Normally you would want to save it in your home directory `~/.ssh/config`.

6. You will get a popup asking you to open the config you just created. Now you also want to provide the location of the ssh key to connect to the machine. It is located in `~/.ssh/` and called after the machine name. Your config file should look like this now:
    ```bash
    Host podman-machine
      HostName 127.0.0.1
      AddKeysToAgent yes
      IdentityFile ~/.ssh/podman-machine-default
      Port 52903
      User core
    ```

7. Update the remotes list in VSCODE by clicking the rotating arrow on the top left corner. Connect to the remote by clicking the arrow next to its name.

8. Inside the container again click on the Remote-Explorer extension but this time on the "Development Container" tab. You now should see every podman container running on your device.

9. Access latex container by clicking the arrow next to its name.

10. Inside open the folder `/data` and install the nessecary extensions by running the `install-extensions.sh` script inside the VSCode terminal.
    ```bash
    bash scripts/install-extensions.sh
    ```

# Features and Settings

## CloudRef
You also have a CloudRef webserver running inside the container. You can access it by opening `localhost:1080` in your browser. The credentials are `maintainer`/`developer`, but sometimes you can't login (see **Bugs**). Every reference you add will be saved in the `bibDirectory` folder inside the `data`-volume. `podman-compose up` runs the `merge-bib.sh`-Skript that merges all references into one `bibliography.bib`-File. You can add this file to your LaTeX project and use it as your bibliography. The script watches for changes in the `bibDirectory` folder and updates the `bibliography.bib` file automatically. So every entry you add to CloudRef over the Web-GUI should automatically end up in the `bibliography.bib`-File.

## Java Path
A Java JRE gets installed in the build process. The LTeX extension needs Java to work, so I provided the Java path in `.vscode/settings.json`. Depending in your architecture you might have a different Java path. You can view the path by running the following command inside the container.
```bash
ls -al /etc/alternatives/java
```
If your path differs you may want to copy the output to the `ltex.java.path`-Setting in `.vscode/settings.json`.


# Bugs
Unfortunately the CloudRef server has its hickups. I couldn't figure out why it sometimes doesn't work. Sometimes you can not login and the container ramps up to 200% CPU usage. If you have any idea why this happens please let me know.
