cmake_minimum_required(VERSION 3.4.1)
project(NMD)
add_library(NMD
             SHARED
             src/main/c/libNMD.c)
set_target_properties(NMD PROPERTIES LINKER_LANGUAGE C)
