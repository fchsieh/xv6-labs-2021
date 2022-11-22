#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]) {
    int p[2];
    if (pipe(p) < 0) {
        printf("pipe error\n");
        exit(1);
    }
    if (fork() == 0) {
        // child
        char buf[1];
        read(p[0], buf, 1);
        close(p[0]);
        printf("%d: received ping\n", getpid());
        write(p[1], "2", 1);
        exit(0);
    } else {
        // parent
        char buf[1];
        write(p[1], "1", 1);
        close(p[1]);
        read(p[0], buf, 1);
        printf("%d: received pong\n", getpid());
        exit(0);
    }
}