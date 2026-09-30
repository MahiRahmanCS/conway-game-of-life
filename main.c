#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "life.h"

void dump_field(int field[HEIGHT][WIDTH], int gen)
{
    printf("\033[H\033[2J");  /* clear screen */
    printf("Generation %d\n", gen);
    for (int r = 0; r < HEIGHT; r++) {
        for (int c = 0; c < WIDTH; c++)
            putchar(field[r][c] == ALIVE ? '#' : '.');
        putchar('\n');
    }
    fflush(stdout);
}

int main(int argc, char *argv[])
{
    int field[HEIGHT][WIDTH] = {0};
    int generations = argc > 1 ? atoi(argv[1]) : 30;

    /* glider */
    field[1][2] = ALIVE;
    field[2][3] = ALIVE;
    field[3][1] = ALIVE;
    field[3][2] = ALIVE;
    field[3][3] = ALIVE;

    /* blinker */
    field[7][20] = ALIVE;
    field[7][21] = ALIVE;
    field[7][22] = ALIVE;

    for (int gen = 0; gen <= generations; gen++) {
        dump_field(field, gen);
        evolve(field);
        usleep(200000);
    }
    return 0;
}
