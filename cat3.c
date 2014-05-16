#include <stdio.h>
#include <stdlib.h>

#define _GNU_SOURCE
#include <getopt.h>

static void do_cat(FILE *f, int n);

int main(int argc, char *argv[]) {
    int opt;
    int n = 0;

    while ((opt = getopt(argc, argv, "t")) != -1) {
            switch (opt) {
            case 't':
                n = 1;
                break;
            case '?':
                fprintf(stderr, "Usage: %s [-t] [FILE ...]\n", argv[0]);
                exit(1);
            }
    }

    if (argc == optind) {
        do_cat(stdin, n);
    }
    else {
        int i;
        for (i = optind; i < argc; i++) {
            FILE *f;

            f = fopen(argv[i],"r");
            if (!f) {
                perror(argv[i]);
                exit(1);
            }
            do_cat(f, n);
            fclose(f);
        }
    }
    exit(0);
}

static void do_cat(FILE *f, int n) {
    int c;

    if (n == 0) {
        while ((c = fgetc(f)) != EOF) {
            if (putchar(c) < 0) exit(1);
        }
        fclose(f);
    } else {
        while ((c = fgetc(f)) != EOF) {
            switch (c) {
                case '\t':
                    if (fputs("\\t", stdout) == EOF) exit(1);
                    break;
                case '\n':
                    if (fputs("$\n", stdout) == EOF) exit(1);
                    break;
                default:
                    if (putchar(c) < 0) exit(1);
                    break;
            }
        }
    }
}
