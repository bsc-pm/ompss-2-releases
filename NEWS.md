# OmpSs-2 Release Notes
All notable changes to the OmpSs-2 programming model and its related software will be documented in this file.

## Version 2025.06, Fri Jun 6, 2025
The OmpSs-2 2025.06 release adds compatibility with ALPI v1.2 across Task-Aware libraries and runtimes, expands device support via Nanos6 and LLVM/Clang, introduces code coverage in nOS-V, and features several updates to Task-Aware libraries such as TASYCL, TACUDA, and TAMPI. It also introduces several bug fixes and improvements to the OmpSs-2 clang parser, several APIs from nOS-V, and instrumentation across libraries.

### Nanos6
- Add compatibility with [ALPI](https://gitlab.bsc.es/alpi/alpi) version 1.2.
- Add support for the `grid` clause on CUDA tasks.
- Weaken DLB test requirements (partial drop of tests).

### nOS-V
- Extended hwinfo API with new functionalities
- Updated compatibility to support ALPI v1.2
- Integrated code coverage
- Fixed a TLS-related bug when nesting `attaches` via `fork()`
- Fixed synchronization issues involving `nosv_cond` mutexes
- Fixed memory consistency issues on certain architectures related to barriers in `complete_callbacks`
- Reduced the number of instrumentation events triggered by `schedpoints` and `yields`
- Improved detection logic and internal representation of hardware information
- Fixed an instrumentation bug where physical CPU IDs were incorrectly emitted instead of logical IDs, leading to emulator failures

### NODES
- No relevant changes compared to the previous release

### LLVM/OpenMP (libompv)
- New, more refined implementation of the `passive` wait policy in `libompv` (`OMP_WAIT_POLICY=passive`)
- Add a `libompvtarget`, equivalent to `libomptarget` but through `libompv`
- Several bugfixes in the `libompv` implementation of free-agents

### LLVM/Clang
- Preliminary support for combining OmpSs-2 with OpenMP offload
- Added suport for the `grid` clause for devices in OmpSs-2
- Several bugfixes in the OmpSs-2 clang parser

### Ovni
- Add support OpenMP label and task ID views.
- Add support for nOS-V non-blocking scheduler server events (VSN and VSn).
- Add OpenMP simple breakdown view.
- Add bench6 package to run full mini-apps for tests.

### Task-Aware Libraries
- Add compatibility with ALPI v1.2 to multiple Task-Aware libraries.
- (TASYCL) Accept Adaptive CPP targets in the configure script.
- (TASYCL) Expand the create queues API to accept combinations of SYCL device selectors, async exception handlers.
- (TASYCL) Expand the API to allow executing functions on all TASYCL queues.
- (TAMPI) Rework the polling mechanism through ALPI's new suspend feature
- (TAMPI) Generate a PKGCONFIG file on installation
- (TAMPI) Allow specifying the maximum number of CPUs of the system while configuring TAMPI
- (TAMPI) Improve the logging of tests
- (TAMPI) Fixed passing of lambdas in some boost functions to fix compatibility with v1.87.9
- (TAMPI) Removed `cpubind` from tests to avoid unexpected behavior depending on SLURM configuration
- (TACUDA) Allow multiple streams per CPU through the use of the `tacudaCreateStreams` parameter
- (TACUDA) Preallocate `cudaEvent_t` objects to reduce internal CUDA library contention


## Version 2024.11, Fri Nov 15, 2024
The OmpSs-2 2024.11 release adds support for Coroutines through the NODES runtime and the nOS-V tasking library and introduces several new features in nOS-V which include support for a task suspension API, support for RISC-V, a Topology API, and a Memory Pressure API, among others. This release also introduces support for the breakdown model through ovni and nOS-V.

### Nanos6
- Add compatibility with ALPI version 1.1 by implementing various functions from the tasking interface

### nOS-V
- Introduce support for breakdown model implementation, supported through the use of `ovniemu -b`
- Refactor shutdown mechanism, using a coordinated approach to prevent contention during runtime shutdown
- Introduce a Memory Pressure API, to query the current occupancy of the nOS-V shared memory segment
- Allow re-initialization of nOS-V, permitting the call to `nosv_init()` after `nosv_shutdown()`
- Enable `turbo` setting by default, and add correctness checking to detect changes to FPU flags from outside of nOS-V
- Add support for coroutines and similar constructs through the `nosv_suspend()` API.
- Add support for RISC-V
- Introduce a Topology API, which allows the configuration of system topology through the `nosv.toml` file
- Allow submitting tasks as `NOSV_SUBMIT_IMMEDIATE` from a task's run callback
- Introduce `nosv_cond_t` and related calls, as a replacement for pthread condition variables
- Other miscellaneous fixes and improvements

### NODES
- Introduce support for Coroutines
- Fix immediate successor logic from within busy threads
- Fix wrong header include order in the build system affecting NODES' installation
- Other minor bug fixes and code improvements

### LLVM/OpenMP (libompv)
- Support other LLVM/Intel compiler generated code in libompv (tracing) by setting `OMP_ENABLE_COMPAT=1`
- Other bug fixes and improvements

### LLVM/Clang
- Miscellaneous bug fixes and improvements

### Ovni
- Add breakdown model for nOS-V
- New mark API `ovni_mark_*()` to emit user-defined events
- New API to manage stream metadata `ovni_attr_*()`
- Update trace format to version 3 (to support independent streams)

### Task-Aware Libraries
- Introduce TAMPI-OPT, an update for the Task-Aware MPI (TAMPI) library which implements several optimizations


## Version 2024.05, Thu May 16, 2024
The OmpSs-2 2024.05 release includes the Directory/Cache (D/C) for Host and CUDA devices in Nanos6, several new features for the nOS-V tasking library, and performance and bugfixes. The `libompv` in LLVM/OpenMP includes the implementation of OpenMP free-agents and instrumentation through ovni. This release removes the support for the Mercurium compiler.

### Nanos6
- Add directory/cache (D/C) for Host and CUDA devices
- Add device memory allocation API for D/C-managed memory
- Improvements to the ovni instrumentation

### nOS-V
- New batch submission API, which can accumulate tasks to submit them in batch once a certain threshold is reached
- Add `nosv_mutex_t` and `nosv_barrier_t` as nOS-V aware alternatives to their pthread counterparts
- Add instrumentation points for the `nosv_attach` and `nosv_detach` calls
- Add instrumentation for parallel tasks
- Activate the `turbo.enabled` configuration option by default, enabling flush-to-zero in x86-64 and aarch64
- Perform safety checks when the `turbo.enabled` configuration option is set to verify FPU flags are not modified by external libraries
- Split instrumentation events for the scheduler to allow them to be more granularly controlled
- Allow nOS-V programs to call fork() without leaving the forked process in an incoherent state
- Other bugfixes and improvements

### NODES
- Improve the error-handling of nOS-V return codes
- Improve descriptiveness of ovni instrumentation
- Various improvements related to API integrations (nOS-V, ALPI, ovni)

### LLVM/OpenMP (libompv)
- Implement the OpenMP free-agents feature by setting `OMP_ENABLE_FREE_AGENTS=1` and `OMP_WAIT_POLICY=passive`
- Instrument through ovni by setting `OMP_OVNI=1` and enabling ovni instrumentation in nOS-V

### LLVM/Clang
- Add `OPENMP_RUNTIME` environment variable to choose the runtime library to link against
- Other bugfixes and improvements

### Ovni
- New `ovni_thread_require`function to enable emulation models
- Streams are marked as finished when calling `ovni_thread_free`
- Support per-thread metadata
- Add manual page for `ovnidump`
- Add support for `nosv_attach` and `nosv_detach` events
- Add support for `nosv_mutex_lock`, `nosv_mutex_trylock`, and `nosv_mutex_unlock` events
- Add support for `nosv_barrier` events
- Add OpenMP model to instrument the `libompv` implementation
- Add new body model to support parallel tasks in nOS-V (`taskfor` directive)
- Fix Paraver cfgs for Mac OS
- Other bugfixes and improvements


## Version 2023.11, Wed Nov 22, 2023
The OmpSs-2 2023.11 release includes performance and bugfixes for the runtime systems, several new features for the nOS-V tasking library, and performance improvements on the `taskiter` construct implementation. It also implements the [ALPI](https://gitlab.bsc.es/alpi/alpi) (version 1.0) in the runtime systems, which provides support for task-aware libraries. The LLVM/OpenMP includes a new OpenMP runtime called OpenMP-V (`libompv`) that works on top of the nOS-V tasking library. A new instrumentation library called [Sonar](https://github.com/bsc-pm/sonar) is provided to instrument MPI function calls through ovni.

### General
- The OmpSs-2 runtime systems expose the [ALPI](https://gitlab.bsc.es/alpi/alpi) generic low-level tasking interface

### Nanos6
- Implement the [ALPI](https://gitlab.bsc.es/alpi/alpi) interface (version 1.0)
- Allow embedding jemalloc allocator
- Embed hwloc and jemalloc by default
- Add `devices.cuda.prefetch` config option to control CUDA prefetching of data dependencies (enabled by default)
- Install the `nanos6.toml` config file in `$prefix/share`
- Remove obsolete instrument.h public interface
- Remove obsolete stats and graph instrumentations
- Remove software dependency with libunwind and elfutils
- Fix execution when enabling extrae instrumentation
- Remove memory leaks
- Various bugfixes and corrections

### nOS-V
- Implement the [ALPI](https://gitlab.bsc.es/alpi/alpi) interface (version 1.0)
- Add `misc.stack_size` config option to change the stack size of nOS-V threads
- Add `ovni.level` config option for fine-grained instrumentation control
- Change `nosv_attach` API to not require an explicit task type and support multiple attaches
- Implement *parallel tasks* which can be executed on multiple CPUs at once
- Allow calling `nosv_init` and `nosv_shutdown` multiple times
- Change error handling to return custom nOS-V error codes
- Allow early wake of deadline tasks with `nosv_submit` passing the `NOSV_SUBMIT_DEADLINE_WAKE` flag
- Add compatibility layer for calls to `sched_get/setaffinity` and `pthread_get/setaffinity`
- Add instrumentation points for the `nosv_create` and `nosv_destroy` APIs
- Various bugfixes and corrections

### NODES
- Improve performance of the `taskiter` construct
- Fix several bugs of the `taskiter` implementation
- Ensure nOS-V library is at the first level of dependencies
- Use the updated attach/detach from nOS-V 2.0
- Drop support for nOS-V versions older than 2.0

### LLVM/OpenMP
- Provide OpenMP runtime named OpenMP-V (`libompv`) working over the nOS-V tasking library (`-fopenmp=libompv`)
- Make OpenMP-V runtime compatible with task-aware libraries
- Drop support for task-aware libraries in vanilla OpenMP runtime `libomp`

### LLVM/Clang
- Fix task data dependencies' calculation for long double types

### Ovni
- Add `OVNI_TRACEDIR` envar to change the trace directory (default is `ovni`)
- Add the `ovniver` program to report the libovni version and commit
- Add `ovni_version_get()` function
- Add nOS-V API subsystem events for `nosv_create()` and `nosv_destroy()`
- Add TAMPI model with `T` code, subsystem events and cfgs
- Add MPI model with `M` code, function events and cfgs
- Don't hardcore destination directory names like lib, to use the ones in the destination host (like lib64)

### Sonar
- Introduce the [Sonar](https://github.com/bsc-pm/sonar) library that uses ovni for instrumenting MPI functions

### Task-Aware Libraries
- Leverage the [ALPI](https://gitlab.bsc.es/alpi/alpi) interface instead of the Nanos6-specific interface
- Drop support for OmpSs-2 versions older than 2023.11
- See other features and fixes in each task-aware libraries' CHANGELOG


## Version 2023.05.1, Mon Jul 24, 2023
The OmpSs-2 2023.05.1 release includes bug fixes and documentation improvements in the Nanos6 runtime, the LLVM/OpenMP runtime, and the LLVM/Clang compiler.

### Nanos6 Runtime
- Fix CUDA kernel launch configuration and improve performance of OmpSs-2@CUDA support
- Allow failures at CUDA prefetching without aborting the execution
- Fix linking with jemalloc when --as-needed linking flag is used
- Improve testing infrastructure and programs
- Update documentation regarding OmpSs-2@CUDA support
- Improve general documentation

### LLVM/OpenMP Runtime
- Fix OpenMP potential use-after-free in polling tasks' mechanism

### LLVM/Clang Compiler
- Fix unconditional break inside a for-loop which is encapsulated in a task
- Fix device tasks call order when capturing more information in other clauses
- Add support `shmem` clause in device tasks


## Version 2023.05, Wed May 24, 2023
The OmpSs-2 2023.05 release includes new software projects and several performance and usability improvements for the OmpSs-2 programming model.
In the context of OmpSs-2, this release introduces the new NODES runtime system supporting OmpSs-2, a novel and efficient tasking library named nOS-V, new Task-Aware libraries for interoperability with GPU offloading models, and new features in the ovni instrumentation library.

### General
- Improve support for ovni instrumentation in the Nanos6 runtime and support for the idle CPUs view
- Add performance and usability improvements in Nanos6
- Allow embedding hwloc library into Nanos6 to avoid conflicts with other third-party software that use different hwloc versions
- Add support for `atomic` and `critical` OmpSs-2 directives in the LLVM/Clang compiler
- Drop support for `task for` clause
- Mercurium is the OmpSs-2 legacy compiler, not supported anymore, and will not provide new features for OmpSs-2. Use the LLVM/Clang compiler instead

### NODES Runtime and nOS-V Tasking Library
- Introduce the new low-level nOS-V threading and tasking library, enabling co-execution of applications
- Introduce the new NODES runtime system, built on top of nOS-V, that supports the OmpSs-2 model. This runtime implements the `taskiter` construct and leverages directed task graphs (DCTG) to optimize the execution of iterative applications
- Extend `-fompss-2` option from LLVM/Clang to choose between Nanos6 and NODES runtimes by accepting the option values `libnanos6` (default) and `libnodes`, respectively

### Task-Aware Libraries
- Introduce the new Task-Aware CUDA (TACUDA), Task-Aware HIP (TAHIP) and Task-Aware SYCL (TASYCL) libraries. These task-aware libraries seamlessly integrate the CUDA, HIP and SYCL APIs for GPU offloading with the OmpSs-2 and OpenMP tasking models
- Add performance improvements and bug fixes in the Task-Aware MPI (TAMPI) and Task-Aware GASPI (TAGASPI) communication libraries
- Extend Task-Aware MPI (TAMPI) to support ovni instrumentation and allow tracing of multi-node hyrbid MPI+OmpSs-2 applications

### **ovni** Instrumentation
- Add new graph-based design in ovni to support complex models like the new breakdown timeline


## Version 2022.11, Tue Nov 15, 2022
The OmpSs-2 2022.11 release introduces LLVM support for CUDA tasks and runtime loading, OVNI instrumentation support, and several bug fixes and features that improve the overall performance and programmability.

### General
- Add a probabilistic attribute to the Immediate Successor feature (enabled by default)
- Improve locking, reduce allocations, and fix alignment issues
- Improve task creation performance

### **ovni** Instrumentation
- Add support for **ovni** instrumentation through the configuration: `version.instrument=ovni`
- Choose detail level with the option `instrument.ovni.level`

### LLVM Support for CUDA
- Support `device(cuda)` tasks in OmpSs-2 programs built with the LLVM compiler
- Drop support for `device(cuda)` in Mercurium
- Support both building kernels separately with NVCC and linking them to the final binary or building directly with LLVM
- Support building PTX binaries and CUDA kernels at runtime when placed in a specific folder (by default nanos6-cuda-kernels)
- Add a new configuration option for the default CUDA kernels folder `devices.cuda.kernels_folder`


## Version 2021.11.1, Fri May 27, 2022
The OmpSs-2 2021.11.1 release introduces some bug fixes and minor improvements.

### General
- Adapt taskfor to avoid overwriting task args in compiler-generated code
- Improve support for custom CXXFLAGS in the runtime system
- Add `--disable-all-instrumentations` configure option in the runtime system
- Provide `nanos6-info` with new options to show compile/link runtime flags
- Provide `nanos6-info` with new options to show current and default config files


## Version 2021.11, Wed Nov 17, 2021
The OmpSs-2 2021.11 release introduces the support for the taskloop with the collapse clause, some performance and
code fixes in the runtime system, and several fixes for the CTF tracing tools.

### General
- Add compiler support for the taskloop with the collapse clause
- Set `hybrid` CPU manager policy as default
- Fix the setting of a floating-point optimization bit in the CSR register (x86) when enabling `turbo` mode
- Add several fixes to CTF tracing tools
- Add support for `if(0)` and taskwaits with dependencies in fast CTF converter (`nanos6-ctf2prv-fast`)
- Remove unnecessary warning at run-time in the NUMA-aware code


## Version 2021.06, Wed Jun 30, 2021
The OmpSs-2 2021.06 release instroduces efficient support in the programming model and the runtime system for
NUMA systems. It also enhances the taskloop construct to support data dependencies. Now the CTF instrumentation
supports MPI applications.

### General
- Add memory allocation API to distribute allocations across NUMA domains and schedule tasks based on that information
- Add the `onready` task clause to define arbitrary callback functions executed when a task becomes ready
- Add new `hybrid` CPU manager policy in the runtime that combines both `idle` and `busy` policies
- Make idle CPUs block inside the scheduler while there are no ready tasks when enabling the `busy` policy
- Remove polling services API
- Remove OmpSs-2@Cluster features and code from this runtime system version
- Remove `nanos6-cluster` submodule; see [OmpSs-2@Cluster Releases](https://github.com/bsc-pm/ompss-2-cluster-releases) for cluster versions
- Other bugfixes, performance and code improvements

### Instrumentation
- Add fast CTF trace converter enabled through the runtime config option `instrument.ctf.converter.fast`
- Add support for multi-process tracing enabled by the Task-Aware MPI library
- Add merger tool for multi-process traces named `nanos6-mergeprv`


## Version 2020.11.1, Tue Dec 22, 2020
The OmpSs-2 2020.11.1 release introduces bug fixes and code improvements.

### General
- Efficient support for taskloop dependencies
- Fix reductions in taskloops and taskfors
- Fix Fortran reductions in Mercurium
- Fully implement the `assert` directive
- Centralize runtime configuration options
- Abort execution when an unknown runtime configuration option is defined
- Fix CTF instrumentation issues
- Unify instrumentation, monitoring and hwcounter points in Nanos6
- Add stable Nanos6 for OmpSs-2@Cluster at `nanos6-cluster` submodule
- Bugfixes, performance and code improvements


## Version 2020.11, Wed Nov 18, 2020
The OmpSs-2 2020.11 release introduces several features and fixes that improve general performance. It
replaces all the configuration environment variables with a configuration file, improving the runtime
system's usability. Now, the discrete dependency system is the default implementation. Finally, the
LLVM-based compiler has been extended to support most of OmpSs-2 features.

### General
- Replace all environment variables with a TOML configuration file
- Add `NANOS6_CONFIG` environment variable to specify the configuration file
- Add `NANOS6_CONFIG_OVERRIDE` to override options from the configuration file
- Enhance performance in architectures with hyperthreading
- Improve locking performance in the runtime system
- Optimize memory allocations in the runtime system
- Add the `assert` declarative directive to check the loaded dependency system
- Support all OmpSs-2 features in the LLVM-based compiler except device tasks
- Other bugfixes, performance and code improvements

### Dependency System
- Make `discrete` the default dependency system
- Add support for CUDA task reductions in discrete dependencies
- Improve allocations in discrete dependencies

### Instrumentation
- Add support for kernel events in CTF instrumentation
- Add new Paraver views for CTF traces

### Devices
- Add fixes for OpenACC and CUDA devices


## Version 2020.06.1, Tue Sep 21, 2020
The OmpSs-2 2020.06.1 release introduces some bug fixes and performance improvements.

### General
- Improve the interface and performance of the Nanos6 scheduler's lock
- Fix CTF instrumentation bugs and limitations
- Fix PAPI hardware counters backend
- Support newer versions of GCC, Clang and GLIBC in Nanos6
- Fix task external events API
- Remove preemption mechanism from critical sections
- Add Nanos6 test suite built with the OmpSs-2 LLVM-based compiler
- Fix OmpSs-2 `atomic` directive
- Define `_OMPSS_2` when compiling with the OmpSs-2 LLVM-based compiler
- Bugfixes, performance and code improvements


## Version 2020.06, Mon Jun 22, 2020
The OmpSs-2 2020.06 release introduces several features that improve the general performance of OmpSs-2 applications.
It adds a new variant to extract execution traces with a lightweight internal tracer. It also improves the support
for CUDA and provides support for OpenACC tasks. Additionally, it introduces a new compiler for OmpSs-2 programs in
beta development based on the open-source [LLVM infrastructure](https://www.llvm.org).

### General
- Use jemalloc as a scalable multi-threading memory allocator
- Add `turbo` variant enabling floating-point optimizations and the discrete dependency system
- Refactor of CPU Manager and DLB support improvements
- Add new OmpSs-2 compiler based on LLVM in beta development supporting several OmpSs-2 features
- Add support for non-blocking [TAMPI](https://github.com/bsc-pm/tampi) in the LLVM OpenMP runtime system
- Bugfixes, performance and code improvements

### Scheduling
- Improve taskfor distribution policy
- Improve scheduling performance and code infrastructure

### Dependency System
- Implement the discrete dependency system with lock-free techniques
- Add support for weak dependencies in discrete
- Add support for commutative and concurrent dependencies in discrete

### Instrumentation
- Refactor the hardware counters infrastructure and support both PAPI and PQoS counters
- Add `ctf` variant to extract execution traces in CTF format using a lightweight internal tracer
- Provide the `ctf2prv` tool to convert CTF traces to Paraver traces
- Avoid Extrae trace desynchronizations in hybrid MPI+OmpSs-2 executions
- Remove the `stats-papi` instrumentation variant

### Devices
- Refactor of the devices' infrastructure
- Perform transparent CUDA Unified Memory prefetching
- Add support for cuBLAS and similar CUDA APIs
- Add support for OpenACC tasks


## Version 2019.11.2, Wed Jan 8, 2020
The OmpSs-2 2019.11.2 release introduces some bug fixes.

### General
- Fix important error at the Nanos6 initialization
- Fix in discrete dependency system
- Several fixes for OmpSs-2@Cluster
- Fix minor issues of Mercurium


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
