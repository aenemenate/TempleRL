# TempleRL

Meant for use with TempleOS.

Use RedSeaFS or a similar tool to put this in an iso, then copy from your T:/ directory to C:/Apps

#include "_Run.HC"; to run!

Note that this will save some BIN files in a C:/Home/TempleRL directory


# Q&A: 

> Why precede the Run file with an underscore?

I wanted to organize the file tree, so one could easily scan through the directory and see only relevant code files in a contiguous block.

> Why not use a linked list?

TempleOS has strict memory limits on tasks, so by using fixed length arrays I am putting a hard limit on how much memory the task can allocate without modification.
