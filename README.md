# DevSecOps Workshops: Docker setup

This is a brief introduction to Docker, followed by a workshop. For the workshop material, visit <a href="https://github.com/devopsies/docker" target="_blank">github.com/devopsies/docker</a>. For a complete documentation, visit <a href="https://docs.docker.com" target="_blank">docs.docker.com</a>.

## What is Docker?

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their own software, libraries and configuration files; they can communicate with each other through well-defined channels. For more information, visit <a href="https://www.docker.com" target="_blank">docker.com</a>.

## Start using Docker

In this workshop, we're going to install Docker on a virtual machine that uses 2 GB of RAM and 2 vCPUs.

### Install Docker

Depending on your operating system, you will have to follow the appropriate installation guide on <a href="https://docs.docker.com/engine/install/">docs.docker.com/engine/install/</a>.

Or, you can just use Docker from within the virtual machine. Just use `Vagrantfile` we provide in this repository and run the `vagrant up` command.

### Docker exercises:

You can find the solution to these exercices under `material/solution.sh`. Please try your best before resorting to it.

#### Containers Life Cycle:

The `wordpress:latest` image uses port `80` guest side.
1. Create a Docker container based on the image `wordpress:latest` (The container must not be running). This container should also use the port `8085`, host side. Name it `ex1-1`.
2. Start the previously created container.
3. Now, stop and then delete the container.
4. Use a single docker command to make and run another container named `ex1-4` based on the image `wordpress:latest` and that must be running on the port `8086` host side, and it must be set in detached mode.
5. Check the resources consumption of the `ex1-4` container.
6. Check the volumes mounted on `ex1-4`.
7. Put the previous container on pause, make a `curl` request in the background, unpause the container, notice what happens, then stop it.

#### Containers Storage:

The `nginx:latest` image uses port `80` guest side.
1. With a single command, create and run a docker container based on the `nginx:latest` image. You should mount a persistent data folder (i.e `~/data` on your host) to the container at `/usr/share/nginx/html`. The container must use the port `8087` on the host side. The container's name must be `ex2-1`, and it must be running in detached mode (detached from the terminal).
2. Create a file named `index.html` in `~/data` and that contains `Hello from DevOpsies!`.
3. Visit the nginx web page using your browser then delete the container.
4. Create a volume named `nginx-vol` and inspect its location.
5. Run an nginx container mapped to host port `8088` and bind volume `nginx-vol` to the container at `/usr/share/nginx/html`. Name it `ex2-5`.
6. Visit the container’s web page, change the content of `index.html` in the `nginx-vol` volume location to `Hello!!`, and then visit the web page again.
7. Run an nginx container mapped to host port `8089` and bind volume `nginx-vol` to the container at `/usr/share/nginx/html`. Name it `ex2-7`. Then visit its web page.
8. Stop and remove all containers.
9. Check if the previously created volume `nginx-vol` still exists. Remove it.

#### Containers Network:

1. Inspect current docker networks.
2. Run the image `wordpress:latest` with name `ex3-2`.
3. Create bridge network `my-net`
4. Connect the container `ex3-2` to this bridge network.
5. Run a container called `db` based on the image `mysql:latest` (mysql uses port `3306` guest side). The container must be set in detached mode and it must be directly connected to `ex3-2` through `my-net` bridge network.
6. Execute commands from within the `ex3-2` container to make sure it can reach the `db` container. You may have to install packages in the `ex3-2` container to run `ping`. You can also install a MySQL client and try to connect to the MySQL server running on the `db` container.
7. Disconnect the `ex3-2` container from the `my-net` network and try the previous step.
8. Remove the two containers directly (without stopping them) and remove the created network.
