# OmpSs-2 Releases

This meta-repository contains the official OmpSs-2 programming model's releases.

* OmpSs-2 User Guide: https://pm.bsc.es/ompss-2-docs/user-guide  
* OmpSs-2 Specification: https://pm.bsc.es/ompss-2-docs/spec  
* OmpSs-2 Examples: https://pm.bsc.es/gitlab/ompss-2/examples  
* OmpSs-2 Release Notes: [NEWS.md](./NEWS.md)

The OmpSs-2 programming model consist of several software repositories:

* [Nanos6](https://github.com/bsc-pm/nanos6): The main runtime system that supports OmpSs-2
* [NODES](https://github.com/bsc-pm/nodes): The runtime system that supports OmpSs-2 and works over the nOS-V tasking library
* [nOS-V](https://github.com/bsc-pm/nos-v): A novel tasking library for efficient task execution and resource managing
* [ovni](https://github.com/bsc-pm/ovni): A fast instrumentation library to record small execution events and generate Paraver traces
* [LLVM/Clang](https://github.com/bsc-pm/llvm): A LLVM-based compiler that supports the OmpSs-2 directives (recommended)
* [Mercurium](https://github.com/bsc-pm/mcxx): The source-to-source compiler supporting OmpSs-2 directives (legacy compiler)
* Several task-aware libraries for interoperability with other programming models:
  * [Task-Aware MPI](https://github.com/bsc-pm/tampi): Library providing support for taskifying MPI communications
  * [Task-Aware GASPI](https://github.com/bsc-pm/tagaspi): Library providing support for taskifying RMA communications
  * [Task-Aware CUDA](https://github.com/bsc-pm/tacuda): Library providing support for taskifying CUDA kernels and operations
  * [Task-Aware HIP](https://github.com/bsc-pm/tahip): Library providing support for taskifying HIP kernels and operations
  * [Task-Aware SYCL](https://github.com/bsc-pm/tasycl): Library providing support for taskifying SYCL kernels and operations

This repository contains the core software projects of the OmpSs-2 model as git submodules.
This repository has a different git tag for each of the OmpSs-2 releases that are available.
The submodules are a link to the different software repositories and they point to the release
commit that corresponds to the OmpSs-2 release. Concretely, there is a submodule for each of
the following projects: Nanos6, NODES, nOS-V, ovni, LLVM/Clang and Mercurium (legacy).

The sources of the task-aware libraries can be retrieved directly from their own repositories,
which are listed above.

# Getting Started

This repository contains all OmpSs-2 releases stored as *git tags*. These release
tags are named following the format `YYYY.MM[.PATCH]`, which can be, for instance,
`2020.11` or `2020.06.1`.

Firstly, clone this repository to your local computer:

```
$ git clone https://github.com/bsc-pm/ompss-2-releases.git
$ cd ompss-2-releases
```

After cloning this repository, run the following command to move to a particular
OmpSs-2 release:

```
$ git checkout 2023.05
```

Then, run the command below to download the Nanos6, NODES, nOS-V, ovni, LLVM-based compiler
and Mercurium sources in the `nanos6`, `nodes`, `nos-v`, `ovni`, `llvm`, and `mcxx` subfolders,
respectively. Those sources will be the ones that correspond to the selected release.

```
$ git submodule update --init
```

Once these sources are downloaded, follow the installation instructions that are
detailed in the [User Guide](https://pm.bsc.es/ompss-2-docs/user-guide).
