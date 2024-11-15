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
* Several task-aware libraries for interoperability with other programming models:
  * [Task-Aware MPI](https://github.com/bsc-pm/tampi): Library providing support for taskifying MPI communications
  * [Task-Aware GASPI](https://github.com/bsc-pm/tagaspi): Library providing support for taskifying RMA communications
  * [Task-Aware CUDA](https://github.com/bsc-pm/tacuda): Library providing support for taskifying CUDA kernels and operations
  * [Task-Aware HIP](https://github.com/bsc-pm/tahip): Library providing support for taskifying HIP kernels and operations
  * [Task-Aware SYCL](https://github.com/bsc-pm/tasycl): Library providing support for taskifying SYCL kernels and operations
  * [Task-Aware AscendCL](https://github.com/bsc-pm/tacl): Library providing support for taskifying AscendCL kernels and operations
* Other libraries for instrumentation:
  * [Sonar](https://github.com/bsc-pm/sonar): Instrumentation library for parallel programming models (e.g., MPI) using the ovni library

This repository contains the core software projects of the OmpSs-2 model as git submodules.
This repository has a different git tag for each of the OmpSs-2 releases that are available.
The submodules are a link to the different software repositories and they point to the release
commit that corresponds to the OmpSs-2 release. Concretely, there is a submodule for each of
the following projects: Nanos6, NODES, nOS-V, ovni, and LLVM/Clang.

The sources of the task-aware and Sonar libraries can be retrieved directly from their own
repositories, which are listed above.


# Latest Stable Release

The current and latest stable release is **OmpSs-2 2024.11** and its corresponding tag
in this repository is *2024.11*. The versions and tags for each individual software
projects are the following:

| Software     |      Version |              Individual Tag |
| :----------- | -----------: | --------------------------: |
| Nanos6       |          4.2 |      github-release-2024.11 |
| NODES        |          1.3 |      github-release-2024.11 |
| nOS-V        |        3.1.0 |      github-release-2024.11 |
| ovni         |       1.11.0 |                      1.11.0 |
| LLVM         |    20.0.0git |      github-release-2024.11 |

Check the [OmpSs-2 Release Notes](./NEWS.md) in this repository to see the changes
introduced in each stable OmpSs-2 release.

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
$ git checkout 2024.11
```

Then, run the command below to download the Nanos6, NODES, nOS-V, ovni, and LLVM-based
compiler sources in the `nanos6`, `nodes`, `nos-v`, `ovni`, and `llvm` subfolders,
respectively. Those sources will be the ones that correspond to the selected release.

```
$ git submodule update --init
```

Once these sources are downloaded, follow the installation instructions that are
detailed in the [User Guide](https://pm.bsc.es/ompss-2-docs/user-guide).
