#include <string.h>
#include "life.h"

int count_alive(int field[HEIGHT][WIDTH], int row, int col)
{
    int count = 0;

    for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
            if (dr == 0 && dc == 0)
                continue;
            /* wrap edges */
            int r = (row + dr + HEIGHT) % HEIGHT;
            int c = (col + dc + WIDTH) % WIDTH;
            if (field[r][c] == ALIVE)
                count++;
        }
    }
    return count;
}

void evolve(int field[HEIGHT][WIDTH])
{
    int next[HEIGHT][WIDTH];

    for (int r = 0; r < HEIGHT; r++) {
        for (int c = 0; c < WIDTH; c++) {
            int n = count_alive(field, r, c);
            if (field[r][c] == ALIVE)
                next[r][c] = (n == 2 || n == 3);
            else
                next[r][c] = (n == 3);
        }
    }
    memcpy(field, next, sizeof(next));
}
