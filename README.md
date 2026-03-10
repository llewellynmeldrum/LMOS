# LMOS 
## V0.2
This version follows the [Meaty-Skeleton](https://wiki.osdev.org/Meaty_Skeleton) tutorial from [wiki.osdev.org](https://wiki.osdev.org).

## Directory Structure:
I found the directory structure suggested by Meaty Skeleton to be quite confusing. Heres what I could come up with as to the reasoning for some of its oddities (from the perspective of a noob osdev).

**Why `kernel/include/kernel/<header>.h`?**
This seems repetitive and unnecessary at first glance. I think the main reason might be for this:
```c
// For some example file, say tty.h, which provides generic declarations of tty functions for any arch.

// without extra kernel/ in the include dir:
#include <tty.h> 

// with extra kernel/ in the include dir:
#include <kernel/tty.h> 


// This forces every include to be prefixed with the 'module' or 'subproject' that it comes from. 
// So you get a sort of modular separation of the headers.I can imagine how useful this sort of thing would be as the userspace grows alongside kernel space.
```

**Why must every function in the stdlib have its own C file?**
This ones a bit harder to reason about from my perspective.
My best guess is that it helps in larger projects to avoid merge conflicts. 
Especially as you add more architectures, I can see how this becomes necessary.
I think the glibc malloc.c file is like 5000 lines long, because it has like 7 different functions.


# References/sources
[os dev wiki](https://wiki.osdev.org/)
