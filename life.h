#ifndef LIFE_H
#define LIFE_H

#define WIDTH 30
#define HEIGHT 15
#define ALIVE 1

int count_alive(int field[HEIGHT][WIDTH], int row, int col);
void evolve(int field[HEIGHT][WIDTH]);

#endif
