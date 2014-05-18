#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <regex.h>

#define _GNU_SOURCE
#include <getopt.h>

static void do_grep(regex_t *pat, FILE *f, int g);

int main(int argc, char *argv[]) {
    regex_t pat;
    int err;
    int i;
    int opt;
    int g = 0;

    while ((opt = getopt(argc, argv, "iv")) != -1) {
        i = optind;
        switch (opt) {
            case 'i':
                err = regcomp(&pat,argv[i], REG_EXTENDED | REG_NOSUB | REG_NEWLINE | REG_ICASE);
                break;
            case 'v':
                err = regcomp(&pat,argv[i], REG_EXTENDED | REG_NOSUB | REG_NEWLINE);
                g = 1;
                break;
            case '?':
                fprintf(stderr, "Usage: %s [-i] [-v] [patten] [file ...]\n", argv[0]);
                exit(1);
            default:
                err = regcomp(&pat,argv[i], REG_EXTENDED | REG_NOSUB | REG_NEWLINE);
                break;
        }
    }

    if (err != 0) {
        char buf[1024];

        regerror(err, &pat, buf, sizeof buf);
        puts(buf);
        exit(1);
    }
    i = i + 1;
    if (argc == i) {
        do_grep(&pat, stdin, g);
    } else {
        for (i = i; i < argc; i++) {
            FILE *f;

            f = fopen(argv[i], "r");
            if (!f) {
                perror(argv[i]);
                exit(1);
            }
            do_grep(&pat, f, g);
            fclose(f);
        }
    }
    regfree(&pat);
    exit(0);
}


static void do_grep(regex_t *pat, FILE *src, int g) {
    char buf[4096];

    while (fgets(buf, sizeof buf, src)) {
        if (g == 0) {
            if (regexec(pat, buf, 0, NULL, 0) == 0) {
                fputs(buf, stdout);
            }
        } else {
            if (regexec(pat, buf, 0, NULL, 0) == REG_NOMATCH) {
                fputs(buf, stdout);
            }
        }

    }
}

