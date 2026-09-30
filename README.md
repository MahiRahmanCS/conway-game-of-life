# Conway's Game of Life (C + Make)

Intro to DevOps, Lab 4.

| File | Purpose |
|------|---------|
| `life.h` | Macros and prototypes |
| `life.c` | `count_alive()`, `evolve()` |
| `main.c` | `dump_field()`, `main()` |
| `Makefile` | Build rules |

## Build and run

```
make            # builds ./conway
./conway 30     # run 30 generations
```

## Install and clean

```
make install                       # to /usr/local/bin (needs sudo if not root)
make install PREFIX=$HOME/.local   # user install
make clean                         # remove objects and binary
make uninstall
```
