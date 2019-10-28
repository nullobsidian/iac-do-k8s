# iac-do-k8s
Iac and Configuration Management for Digital Ocean K8s

**Alpine OS [Latest]**

- Ansible 2.8.6
- Terraform 0.12.12
- Digital Ocean Cli (doctl) 1.33.0
- Kubectl 1.15.5

Default login user is `dev` with `sudo` privileges and no password.

Want to change default username? Add this end of `docker build` command.

`--build-arg USER='exampleuser'`

Pull image and run the container

```shell
docker pull sagebinary/iac-do-k8s
docker run -it --name k8s-iac-do sagebinary/iac-do-k8s
```

`Sh` into your container

```shell
docker exec -itd k8s-iac-do /bin/sh
```

A volume is created and mounted to your `HOME` directory for persistent dev environment. 
