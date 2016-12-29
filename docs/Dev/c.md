# C

Sample.c

```c
#include <stdio.h>

int main()
{
    printf("hello there person");
}
```

## Windows

### Visual C++

Compile Sample.c to Test.exe with Visual C++ compiler

```bat
cl Sample.c /nologo /FeTest.exe /W4 /TP
```

- `/W4` Sets warning level
- `/TP` Compile all files as .cpp

### GCC

[MinGW Distro](https://nuwen.net/mingw.html)

```bash
gcc Sample.c -Wall
type sample.c
gcc Sample.c -Wall -std=c99 Wextra -pedantic -o Sample
```

## Language

Variables

```c
int distance, progress, remaining;
printf("%d\n", distance, progress, remaining)
```