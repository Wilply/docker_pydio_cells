# Docker image for Pydio cells

This images was created to run pydio with other user than root, due to permission error. \
This images is for my personal use and will not be actively maintained. \
[Pydio website](https://pydio.com/) \
[Pydio cells documentation](https://pydio.com/en/docs/cells/v1/installation-guides)

#### ENV variables

`CELLS_EXTERNAL`: external url - used to acess from the web *(default: pydio.example.com)* \
`CELLS_BIND`: internal url - used by services to talk between each others *(default: localhost:8080)* \
`SSL`: set 1 if you dont want to use a self-generated ssl cerificate *(default: 0)* \
`PUID`: user's uid pydio will run as *(default: 1500)* \
`PGID`: group's gid pydio will run as *(default: 1500)* \
`RUN_AS_ROOT`: set to 1 to run pydio as root *(default: 0)*

#### Volume

`/cell/.config/pydio/cells`: pydio config files folder

#### Example

```
Look at compose file for example.
```
