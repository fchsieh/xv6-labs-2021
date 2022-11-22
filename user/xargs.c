#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"

int readline(char *new_argv[32], int curr_argc) {
    // read from stdout, separate by lines
    char buf[1024];
    int n = 0;
    while (read(0, buf + n, 1)) {
        if (n == 1023) {
            fprintf(2, "argument is too long\n");
            exit(1);
        }
        if (buf[n] == '\n') {
            break;
        }
        n++;
    }
    // parse the line into arguments by space
    buf[n] = 0;
    if (n == 0) return 0;
    int offset = 0;
    while (offset < n) {
        new_argv[curr_argc++] = buf + offset;  // store argument
        while (buf[offset] != ' ' && offset < n) {
            offset++;
        }
        while (buf[offset] == ' ' && offset < n) {
            // clear buffer
            buf[offset++] = 0;
        }
    }
    return curr_argc;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(2, "Usage: xargs command\n");
        exit(1);
    }
    char *command = malloc(strlen(argv[1]) + 1);
    char *args[MAXARG];
    strcpy(command, argv[1]);
    for (int i = 1; i < argc; i++) {
        args[i - 1] = argv[i];
    }
    int cur_argc = 0;
    while ((cur_argc = readline(args, argc - 1)) != 0) {
        args[cur_argc] = 0;
        if (fork() == 0) {
            exec(command, args);
            fprintf(2, "xargs: exec %s failed\n", command);
            exit(1);
        }
        wait(0);
    }

    exit(0);
}