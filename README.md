CI testing and release build for TeX Live
=========================================

The binaries for TeX Live are built using Github actions, using the
action defined in this repository.

Currently, the following architectures are built

* `x86_64-linux`: built using CentOS 7 (Glibc 2.17) with
  Gcc 9 via `centos-release-scl` and `devtoolset-9`
* `i386-linux`: built using Ubuntu Xenial (Glibc 2.23)
  since the above method is not available for i386 and
  the standard Gcc compiler in CentOS 7 (gcc4) cannot
  compile harfbuzz
* `x86_64-linuxmusl`: built using Alpine 3.5 (3.2 was used
  before, but we need newer compiler for harfbuzz again)

