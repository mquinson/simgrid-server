# Remote SimGrid

RSG is a simple solution to execute your distributed
application on top of [SimGrid](http://simgrid.org/). You just have to
reimplement the little class abstracting every network interactions
that you have down below in your code architecture. This is easy with
the RSG client API.

Then, the RSG server can start your (real) application on top of a
(simulated) platform, enabling you to use the full power of SimGrid as
a perfect testbench for your application.

Enjoy reproducibility, clairvoyance and simplicity while testing your
distributed application or infrastructure !

## Current State

SimGrid is a strong and mature framework to study distributed
algorithms or applications.
We are currently (2019-06) reimplementing RSG to improve its maintainability and robustness.

[![pipeline status](https://framagit.org/simgrid/remote-simgrid/badges/master/pipeline.svg)](https://framagit.org/simgrid/remote-simgrid/pipelines)
[![coverage report](https://framagit.org/simgrid/remote-simgrid/badges/master/coverage.svg)](https://framagit.org/simgrid/remote-simgrid/-/jobs)

## Contact and License

If you are interested, please drop us a line on the
simgrid-user@lists.gforge.inria.fr mailing list.

SimGrid is released under LGPL-2.1 and Remote SimGrid is released under LGPL-3.0.

## Installing Remote SimGrid manually

Install dependencies:
- docopt-cpp: `nix-env -f https://github.com/oar-team/kapack/archive/master.tar.gz -iA docopt_cpp`
- Protobuf: `nix-env -i protobuf`
- SFML-network: `nix-env -i sfml`
- SimGrid: `nix-env -f https://github.com/oar-team/kapack/archive/master.tar.gz -iA simgrid322_2`

Make sure all of them are accessible by pkg-config:
`pkg-config --cflags --libs docopt protobuf sfml-network simgrid` should
output how to link and include all the libraries.
If this is not the case, update your PKG_CONFIG_PATH environment variable.

Then, this is classical meson build:

```
meson build # --prefix=/install/directory
ninja -C build
ninja install -C build
```
