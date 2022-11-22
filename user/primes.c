#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void worker(int p[2]) {
    int prime;
    close(p[1]);
    // terminate if no data in pipe
    if (read(p[0], &prime, sizeof(int)) == 0) {
        close(p[0]);
        exit(0);
    }
    printf("prime %d\n", prime);
    int next_p[2];
    pipe(next_p);
    if (fork() == 0) {
        worker(next_p);
    } else {
        int n;
        // try to read from pipe
        while (read(p[0], &n, sizeof(int)) != 0) {
            if (n % prime != 0) {  // pass to next worker if it is a prime
                write(next_p[1], &n, sizeof(int));
            }
        }
        // end of current sieve
        close(p[0]);
        close(next_p[1]);
        wait(0);
    }
    exit(0);
}

int main(int argc, char const *argv[]) {
    int p[2];
    pipe(p);
    if (fork() == 0) {
        worker(p);
    } else {
        // wait for last worker to finish
        for (int i = 2; i <= 35; i++) {
            write(p[1], &i, sizeof(i));
        }
        close(p[1]);
        wait(0);
    }

    exit(0);
}
