# Docker LaTeX ARM
A dockerized LaTeX compiler to work with VSCode. Comes with a CloudRef webserver to manage your bibliography (see **CloudRef**). You will also install [LTeX](https://marketplace.visualstudio.com/items?itemName=valentjn.vscode-ltex) in the process, configured for German language and with a Java JRE inside the container (see **Java Path**).

# Getting started
1. Clone the repository.
    ```bash
    git clone https://github.com/brunobeeee/docker-latex-arm
    ```

2. Run the container.
    ```bash
    docker-compose up -d
    ```
    This builds the image and runs the container in detached mode.

3. Open VSCode and install the [Remote - Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer) extension if not present.

4. Access the container by clicking on the blue button on the bottom left corner of VSCode and selecting `Remote-Containers: Attach to Running Container...`.

5. Install the nessecary extensions by running the `install-extensions.sh` Skript inside the VSCode terminal.
    ```bash
    bash install-extensions.sh
    ```

# Features and Settings

## CloudRef
You also have a CloudRef webserver running inside the container. You can access it by opening `localhost:80` in your browser. The credentials are `maintainer`/`developer`. Every reference you add will be saved in the `bibDirectory` folder inside the `data`-volume. `docker-compose up` runs the `merge-bib.sh`-Skript that merges all references into one `bibliography.bib`-File. You can add this file to your LaTeX project and use it as your bibliography. The script watches for changes in the `bibDirectory` folder and updates the `bibliography.bib` file automatically. So every entry you add to CloudRef over the Web-GUI should automatically end up in the `bibliography.bib`-File.

## Java Path
A Java JRE gets installed in the build process. The LTeX extension needs Java to work, so I provided the Java path in `.vscode/settings.json`. Depending in your architecture you might have a different Java path. You can view the path by running the following command inside the container.
```bash
ls -al /etc/alternatives/java
```
If your path differs you may want to copy the output to the `ltex.java.path`-Setting in `.vscode/settings.json`.


# Bugs
Unfortunately the CloudRef server has its hickups. I couldn't figure out why it sometimes doesn't work. Sometimes you can not login and the container ramps up to 200% CPU usage. If you have any idea why this happens please let me know.
