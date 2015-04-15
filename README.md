### Docker CentOS 7 x64 Base Image

This bootstrap bash script will update `yum` to latest, update `docker` to the latest and enable it in `systemctl`. It will also make directory for `docker_registry`.


#### Instructions
- Requires `vagrant` on main machine (for development)
- For production, run only `bootstrap.sh`

### Usage
```bash
$ git clone this-project.git
$ vagrant up
```
