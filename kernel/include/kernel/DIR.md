# kernel/include/kernel
We do this repeated directory nonsense for better separation and explicitness of includes.
For instance:
```c
// it forces us to do this: 
#include <kernel/tty.h>         // Clear and unambiguous where tty.h comes from.

// instead of this: 
#include <tty.h>                // ambiguous and murky. Is tty.h a generic header for all archs? Who knows?
```
