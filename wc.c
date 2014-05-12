#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int i;
    int is;

    for (i = 1; i < argc; i++) {
        FILE *f;
        int c;

        f = fopen(argv[i], "r");
        if (!f) {
            perror(argv[i]);
            exit(1);
        }
        is = 0;
        while((c = fgetc(f)) != EOF) {
            if (c == '\n') is++;
        }
        fseek(f,-1,SEEK_END);
        while ((c = fgetc(f)) != EOF) {
            if (c != '\n') is--;
        }
        printf("%d", is);
        fclose(f);
    }
    exit(0);
}
