#!/usr/bin/env python3
'''pymlock, a python program for locking a list of files into memory

   In addition to being able to lock individual files into memory, it can
   also recursively lock executables and all their library dependencies
   into memory, and if passed a directory, will lock all the files under
   that directory.  After doing so, it will either sleep until it gets
   a signal, or wake up on a specified interval and remap everything.
   A SIGHUP will cause it to re-map all the files it's mlocked (useful
   for system updates).

   Because of how Python works, this will additionally lock the python
   interpreter and all of it's dependencies into memory, even if not
   requested.

   TODO:
   * Add support for detecting the interpreter in #! based scripts.

   Possible future TODO items:
   * Support for parsing Python scripts and loading their dependencies.
   * Support for parsing other scripts for dependencies.
   * Parsing Java binaries for dependencies (may need an installed JDK).
   * Parsing Mono/.NET binaries for dependencies (may need development
   tools from Mono).

   Copyright (c) 2015 2016, Austin S. Hemmelgarn
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:

   1. Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
   2. Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
   3. Neither the name of pymlock nor the names of its contributors
      may be used to endorse or promote products derived from this
      software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
   '''

import os
from mmap import mmap, PROT_READ
from signal import signal, pause, setitimer, SIGHUP, SIGALRM, ITIMER_REAL

_maps = []
_args = None

def parse_args():
    '''Parse our commandline arguments'''
    import argparse
    parser = argparse.ArgumentParser(description='Lock files into memory.',
                                     fromfile_prefix_chars='@')
    parser.add_argument('files', nargs='+', help='A list of files to lock into memory.')
    parser.add_argument('-p', type=int, dest='periodic', metavar='P', help='remap everything every P seconds')
    parser.add_argument('-n', action='store_true', dest='nomap', help='print the full list of files that would be mapped and locked, then exit.')
    parser.add_argument('-t', action='store_true', dest='timing', help='exit after mmaping and mlocking all the files (used for timing how long it takes).')
    return parser.parse_args()

def mlockall():
    '''Call mlockall(MCL_CURRENT | MCL_FUTURE) via ctypes.'''
    from ctypes import cdll
    libc = cdll.LoadLibrary('libc.so.6')
    return libc.mlockall(1 | 2)

def map_file(path):
    '''mmap() a file, and return a tuple of the filename and fd.'''
    fd = None
    try:
        fd = os.open(path, os.O_RDONLY | os.O_NOATIME)
    except (OSError, PermissionError, AttributeError):
        fd = os.open(path, os.O_RDONLY)
    mfile = mmap(fd, 0, prot=PROT_READ)
    os.close(fd)
    return (path, mfile)

def parse_list(files):
    '''Parse through a list of files, and expand any dependencies for executables.

       Currently, this only expands dependencies for binaries that can
       be parsed by the system version of ldd.'''
    from subprocess import check_output, CalledProcessError
    from glob import glob
    i = 0
    while i < len(files):
        i += 1
        if files[i - 1] == '':
            continue
        if os.path.isdir(files[i - 1]) and os.access(files[i - 1], os.R_OK | os.X_OK):
            for item in glob(os.path.join(files[i - 1], '*')):
                files.append(item)
        elif os.path.isfile(files[i - 1]) and os.access(files[i - 1], os.R_OK):
            while files.count(files[i - 1]) > 1:
                del files[files.index(files[i - 1], i)]
            if os.access(files[i - 1], os.X_OK):
                try:
                    ldddeps = check_output(['ldd', files[i - 1]], universal_newlines=True)
                except CalledProcessError:
                    continue
                ldddeps = ldddeps.splitlines()
                for line in ldddeps:
                    dep = line.lstrip().split('=>')
                    if len(dep) < 2:
                        continue
                    deppath = dep[1].lstrip().split()[0]
                    if os.access(deppath, os.R_OK) and not (deppath in files):
                        files.append(deppath)
        else:
            files[i - 1] = ''
    while files.count('') > 0:
        files.remove('')
    return files

def _sighup(signum, frame):
    '''Handler for SIGHUP, remaps all mapped files.

       Currently, this does not atomically remap a file, and as such there
       is a period of time between a file being unmapped and remapped.
       Ideally, this should be fixed.'''
    files = parse_list(_args.files)
    for i in _maps:
        i[1].close()
    _maps = []
    for i in files:
        _maps.append(map_file(i))

def main():
    _args = parse_args()
    files = parse_list(_args.files)
    if _args.nomap:
        for i in files:
            print(i)
        exit(0)
    for i in files:
        _maps.append(map_file(i))
    mlockall()
    if _args.timing:
        return 0
    signal(SIGHUP, _sighup)
    if _args.periodic:
        signal(SIGALRM, _sighup)
        setitimer(ITIMER_REAL, _args.periodic, _args.periodic)
        while True:
            pause()
    else:
        pause()

if __name__ == '__main__':
    exit(main())
