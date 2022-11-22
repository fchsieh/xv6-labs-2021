#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char results[10000][512];

void find(char *path, char *name) {
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if ((fd = open(path, 0)) < 0) {
        fprintf(2, "find: cannot open %s\n", path);
        exit(1);
    }
    if (fstat(fd, &st) < 0) {
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        exit(1);
    }
    switch (st.type) {
        case T_DIR:
            // recursive find in subdirectories
            // get the directory name
            if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
                printf("find: path too long\n");
                break;
            }
            strcpy(buf, path);
            p = buf + strlen(buf);
            *p++ = '/';
            while (read(fd, &de, sizeof(de)) == sizeof(de)) {
                if (de.inum == 0) continue;  // skip empty entries
                memmove(p, de.name, DIRSIZ);
                p[DIRSIZ] = 0;
                if (stat(buf, &st) < 0) {
                    printf("find: cannot stat %s\n", buf);
                    continue;
                }
                if (st.type == T_DIR) {
                    if (strcmp(de.name, ".") == 0 ||
                        strcmp(de.name, "..") == 0) {
                        continue;
                    }
                    find(buf, name);
                } else {
                    if (strcmp(de.name, name) == 0) {
                        printf("%s\n", buf);
                    }
                }
            }
            break;
    }
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: %s <dir> <file>\n", argv[0]);
        exit(1);
    }
    char *dir = argv[1];
    char *file = argv[2];
    find(dir, file);
    exit(0);
}