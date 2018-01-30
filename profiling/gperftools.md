# gperftools

[Gperftools](https://code.google.com/p/gperftools/) from Google provides a set of tools aimed for analyzing and improving performance of multi-threaded applications. They offer a CPU profiler, a fast thread aware malloc implementation, a memory leak detector and a heap profiler. Let's focus on their sampling based CPU profiler.

## Installation
However we can install it from repositories using `apt-get install google-perftools`, we opt for installation from source to have latest version. 

1. Download latest available [release](https://github.com/gperftools/gperftools/releases) as a `*.tar.gz` archive. Don't clone repository, since to build it you will have to additionally install `autoconf`,`automake` and `libtool` tools and manually generate install scripts. The archive will already have generated all needed scripts. 
2. Unpack the archive with command like:
    ```bash
    tar -xvf gperftools-2.6.tar.gz gperftools-2.6/
    ```
    This will create `gperftools-2.6` directory and unpack there all files.
3. Before compiling `gperftools` make sure you have installed `libunwind` (if you have 64-bit system):
    ```bash
    sudo dpkg-query --list libunwind8
    ```
    If we see it listed with `ii` at the begining of the row, then it's installed, else type:
    ```bash
    sudo apt-get install libunwind8
    ```
    In the `INSTALL` file inside repository the authors claim that we should install 0.99 version and that:
        "too-new versions introduce new code that does not work well with perftools (because libunwind can call malloc, which will lead to deadlock)",
    however with version from Ubuntu Xenial 16.04 repositories (1.1-4.1) I haven't got any problems so far.
    __EDIT__ I have segfaults problems with this version!
    1. Download latest version of libunwind library from [here](https://download.savannah.gnu.org/releases/libunwind/)
    2. Unpack, and standard 
        ```bash
        ./configure
        make -j6
        sudo make install
        ```
        If you have errors like: `error: 'longjmp' aliased to undefined symbol '_longjmp'` run `make CFLAGS+=-U_FORTIFY_SOURCE -j6`, however this could take place with earlier versions (tested in: 0.99).
4. Run configuration tool and install:
    ```bash
    ./configure CPPFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib
    make -j8
    sudo make install
    make clean
    make distclean
    ```
    Additional parameters to `./configure` instructs to search for libraries inside specified directories. This is needed to link against our previously compiled libunwind version insted of system installed `libunwind8`
    The last two commands will remove created binaries and object files from repository directory as well as files created by `configure` script. You can now as well remove entire `gperftools-2.6` directory.

## Profiling
Creating a CPU profile of selected parts of our application with `gperftools` requires the following steps:

1. First we need to compile our program with debugging symbols enabled (to get a meaningful call graph). When using `cmake` tools compile with flag `-DCMAKE_BUILD_TYPE=Debug` or add this line to `CMakeLists.txt`:
    ```cmake
    set(CMAKE_BUILD_TYPE Debug)
    ``` 
2. Next we have to link gperftools `profiler.so` and this isn't as easy as above step. We have to inform `cmake` it should find and link aforementioned library. We add these lines to `CMakeLists.txt`:
    ```cmake
    find_package(PkgConfig)
    set(PKG_CONFIG_PATH "${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig")
    pkg_search_module(gperftools REQUIRED libprofiler)
    ```
    First line instructs `cmake` to use `pkg-config` to find libraries which doesn't provide `FindLibname.cmake` file. Second line adds path where to additionally search for such libraries. Finally, last line search for `libprofiler.pc` file which is a `profile` package library configuration file. `gperftools` is a prefix added to standard `cmake` variables.

    Lastly we add `${gperftools_INCLUDE_DIRS}` to included directories and link our executable with `${gperftools_LIBRARIES}`.
3. Now `#include <gperftools/profiler.h>` and surround the sections you want to profile with `ProfilerStart("nameOfProfile.log");` and `ProfilerStop();` and
execute your program to generate the profiling data file(s).
4. To analyze the profiling data, use `pprof` (distributed with `gperftools`) or convert it to a `callgrind` compatible format and analyze it with KCachegrind
    ```bash
    # convert profile.log to callgrind compatible format
    pprof --callgrind ./our_program profile.log > profile.callgrind

    # open profile.callgrind with kcachegrind
    kcachegrind profile.callgrind
    ```

## [Documentation](http://gperftools.googlecode.com/svn/trunk/doc/cpuprofile.html)
