# OmpSs-2 Release Notes
All notable changes to the OmpSs-2 programming model, the Nanos6 runtime system, and the Mercurium source-to-source
compiler will be documented in this file.


## Version 2019.11.1, Tue Dec 10, 2019
The OmpSs-2 2019.11.1 release introduces some bugfixes and performance improvements.

### General
- Fix execution of CUDA tasks
- Fix `dmalloc` in OmpSs-2@Cluster
- Add missing calls to CPU Manager
- Improve taskfor performance
- Improve general performance by using a reasonable cache line size padding
- Add tests checking the execution of CUDA tasks
- Fix minor issues of Mercurium


## Version 2019.11, Mon Nov 18, 2019
The OmpSs-2 2019.11 release introduces a new optimized data dependency implementation. It improves the usability,
performance and code of the scheduling infrastructure and the `task for` feature. It also adds support for DLB
and OmpSs-2@Linter.

### General
- Data dependency implementation can be decided at run-time through `NANOS6_DEPENDENCIES` variable
- Performance and code improvements on the `task for` feature
- Add support for Dynamic Load Balancing (DLB) tool
- Add compiler and runtime support for [OmpSs-2@Linter](https://github.com/bsc-pm/ompss-2-linter)
- Important bugfix in memory allocator (used by OmpSs-2@Cluster)
- Bugfixes, performance and code improvements

### Dependency System
- Add new optimized discrete dependency system implementation; enabled by `NANOS6_DEPENDENCIES=discrete`

### Scheduling
- Usability, performance and code improvements on the scheduling infrastructure

### Instrumentation
- Remove profile instrumentation variant
- Remove interception mechanism of memory allocation functions


## Version 2019.06.2, Mon Oct 7, 2019
The OmpSs-2 2019.06.2 release introduces some bugfixes.

### General
- Compiling extrae variant with high optimization flags
- Removing backtrace sampling from the extrae variant


## Version 2019.06.1, Fri Sep 27, 2019
The OmpSs-2 2019.06.1 release mainly introduces bugfixes and code improvements.

### General
- Renaming loop directive to task for
- Tasks can leverage reductions and external events at the same time (over distinct data regions)
- OmpSs-2@Cluster bugfixes
- Fixing binding information reported by nanos6-info binary
- Support for the TAGASPI library
- Other bugfixes and code improvements


## Version 2019.06, Mon Jun 17, 2019
The OmpSs-2 2019.06 release mainly introduces the new support for OmpSs-2@Cluster. It also includes some improvements and
optimizations for array task reductions and general bugfixes.

### General
- Support for OmpSs-2@Cluster
- Bugfixes and performance improvements

### Dependency System
- Bugfixes and optimization for array reductions
- Delete obsolete task data dependency implementations

### Scheduling
- Delete obsolete schedulers


## Version 2018.11, Fri Nov 9, 2018
The OmpSs-2 2018.11 release provides full support for the [TAMPI](https://github.com/bsc-pm/tampi) library. It also includes
general bugfixes and performance improvements.

### General
- Full support for TAMPI
- Bugfixes and performance improvements

### Others
- Bugfixes in task external events API


## Version 2018.06.2, Mon Jun 25, 2018
The OmpSs-2 2018.06.2 release introduces some bugfixes.

### General
- Bugfixes in HWLOC support


## Version 2018.06.1, Mon Jun 25, 2018
The OmpSs-2 2018.06.1 release introduces some bugfixes.

### General
- Bugfixes in task reductions


## Version 2018.06, Mon Jun 25, 2018
The OmpSs-2 2018.06 release introduces support for OmpSs-2@CUDA in Unified Memory NVIDIA devices. It also supports array task
reductions in C/C++ and task priorities. Additionally, it provides two new APIs used by the [TAMPI](https://github.com/bsc-pm/tampi)
library.

### General
- Support for OmpSs-2@CUDA Unified Memory
- Bugfixes and performance improvements

### Dependency System
- Support for array task reductions in C/C++

### Scheduling
- Support for task priorities
- Add priority scheduler

### Others
- Add polling services API
- Add task external events API
- Rename taskloop construct to loop


## Version 2017.11.1, Thu Nov 23, 2017
The OmpSs-2 2017.11.1 release provides general bugfixes.

### General
- Fixes for the building system
- Fixes for the loading system


## Version 2017.11, Mon Nov 13, 2017
The OmpSs-2 2017.11 release is the first release of the OmpSs-2 parallel task-based programming model, which comprises the Nanos6 runtime
system and the Mercurium source-to-source compiler. This version provides the essential infrastructure to manage the parallelism of user
tasks (task creation, task scheduling, etc.) and their data dependencies. The task dependency system supports array section dependencies,
the nested dependency domain connection, and both early release and weak dependency models.

### General
- General infrastructure of the runtime system and the compiler
- Support for user tasks and nesting of tasks

### Scheduling
- Implement different schedulers: FIFO, LIFO, etc

### Dependency System
- Implementation of a task data dependency system
- Support for array section dependencies
- Support for nested dependency domain connection
- Support for early release of task dependencies
- Support for weak task dependencies
- Support for reductions

### Others
- Taskloop construct with dependencies
- Task pause/resume API
