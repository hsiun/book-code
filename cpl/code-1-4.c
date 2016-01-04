#include <stdio.h>

#define OUT 0
#define IN  1

main() {
    int c, nl, nw, nc, state;

    state = OUT;
    nw = nc = nl = 0;
    while( (c=getchar()) != EOF) {
        ++nc;
        if ( c == '\n')
            ++nl;
        if ( c == '\n' || c == ' ' || c == '\t')
            state = OUT;
        else if (state == OUT) {
            state = IN;
            ++nw;
        }
    }

    printf("%d %d %d\n", nl, nw, nc);


}
