# Docker image for Pydio cells

This images was created to run pydio with other user than root, due to permission error. \
This images is for my personal use and will not be actively maintained. \
[Pydio website](https://pydio.com/) \
[Pydio cells documentation](https://pydio.com/en/docs/cells/v1/installation-guides)

#### ENV variables

`CELLS_EXTERNAL`: external url - used in links, etc.. *(default: localhost:8080)* \
`CELLS_BIND`: internal url - used by services to talk between each others *(default: localhost:8080)* \
`SSL`: set 0 if you dont want to use a self-generated ssl cerificate *(default: 1)* \
`PUID`: user's uid pydio will run as *(default: 1000)* \
`PGID`: group's gid pydio will run as *(default: 1000)*

#### Example

```
docker run -it -p 8080:8080 \
  -e PUID=1500 \
  -e PGID=1300 \
  -e SSL=0 \
  wilply/pydio_cells
```
