
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "user/user.h"
#include "kernel/fs.h"

char results[10000][512];

void find(char *path, char *name) {
   0:	d9010113          	addi	sp,sp,-624
   4:	26113423          	sd	ra,616(sp)
   8:	26813023          	sd	s0,608(sp)
   c:	24913c23          	sd	s1,600(sp)
  10:	25213823          	sd	s2,592(sp)
  14:	25313423          	sd	s3,584(sp)
  18:	25413023          	sd	s4,576(sp)
  1c:	23513c23          	sd	s5,568(sp)
  20:	1c80                	addi	s0,sp,624
  22:	892a                	mv	s2,a0
  24:	89ae                	mv	s3,a1
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if ((fd = open(path, 0)) < 0) {
  26:	4581                	li	a1,0
  28:	00000097          	auipc	ra,0x0
  2c:	49c080e7          	jalr	1180(ra) # 4c4 <open>
  30:	04054163          	bltz	a0,72 <find+0x72>
  34:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        exit(1);
    }
    if (fstat(fd, &st) < 0) {
  36:	d9840593          	addi	a1,s0,-616
  3a:	00000097          	auipc	ra,0x0
  3e:	4a2080e7          	jalr	1186(ra) # 4dc <fstat>
  42:	04054763          	bltz	a0,90 <find+0x90>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        exit(1);
    }
    switch (st.type) {
  46:	da041703          	lh	a4,-608(s0)
  4a:	4785                	li	a5,1
  4c:	06f70663          	beq	a4,a5,b8 <find+0xb8>
                    }
                }
            }
            break;
    }
}
  50:	26813083          	ld	ra,616(sp)
  54:	26013403          	ld	s0,608(sp)
  58:	25813483          	ld	s1,600(sp)
  5c:	25013903          	ld	s2,592(sp)
  60:	24813983          	ld	s3,584(sp)
  64:	24013a03          	ld	s4,576(sp)
  68:	23813a83          	ld	s5,568(sp)
  6c:	27010113          	addi	sp,sp,624
  70:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  72:	864a                	mv	a2,s2
  74:	00001597          	auipc	a1,0x1
  78:	91c58593          	addi	a1,a1,-1764 # 990 <malloc+0xec>
  7c:	4509                	li	a0,2
  7e:	00000097          	auipc	ra,0x0
  82:	740080e7          	jalr	1856(ra) # 7be <fprintf>
        exit(1);
  86:	4505                	li	a0,1
  88:	00000097          	auipc	ra,0x0
  8c:	3fc080e7          	jalr	1020(ra) # 484 <exit>
        fprintf(2, "find: cannot stat %s\n", path);
  90:	864a                	mv	a2,s2
  92:	00001597          	auipc	a1,0x1
  96:	91658593          	addi	a1,a1,-1770 # 9a8 <malloc+0x104>
  9a:	4509                	li	a0,2
  9c:	00000097          	auipc	ra,0x0
  a0:	722080e7          	jalr	1826(ra) # 7be <fprintf>
        close(fd);
  a4:	8526                	mv	a0,s1
  a6:	00000097          	auipc	ra,0x0
  aa:	406080e7          	jalr	1030(ra) # 4ac <close>
        exit(1);
  ae:	4505                	li	a0,1
  b0:	00000097          	auipc	ra,0x0
  b4:	3d4080e7          	jalr	980(ra) # 484 <exit>
            if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
  b8:	854a                	mv	a0,s2
  ba:	00000097          	auipc	ra,0x0
  be:	1a6080e7          	jalr	422(ra) # 260 <strlen>
  c2:	2541                	addiw	a0,a0,16
  c4:	20000793          	li	a5,512
  c8:	00a7fb63          	bgeu	a5,a0,de <find+0xde>
                printf("find: path too long\n");
  cc:	00001517          	auipc	a0,0x1
  d0:	8f450513          	addi	a0,a0,-1804 # 9c0 <malloc+0x11c>
  d4:	00000097          	auipc	ra,0x0
  d8:	718080e7          	jalr	1816(ra) # 7ec <printf>
                break;
  dc:	bf95                	j	50 <find+0x50>
            strcpy(buf, path);
  de:	85ca                	mv	a1,s2
  e0:	dc040513          	addi	a0,s0,-576
  e4:	00000097          	auipc	ra,0x0
  e8:	134080e7          	jalr	308(ra) # 218 <strcpy>
            p = buf + strlen(buf);
  ec:	dc040513          	addi	a0,s0,-576
  f0:	00000097          	auipc	ra,0x0
  f4:	170080e7          	jalr	368(ra) # 260 <strlen>
  f8:	1502                	slli	a0,a0,0x20
  fa:	9101                	srli	a0,a0,0x20
  fc:	dc040793          	addi	a5,s0,-576
 100:	00a78933          	add	s2,a5,a0
            *p++ = '/';
 104:	00190a13          	addi	s4,s2,1
 108:	02f00793          	li	a5,47
 10c:	00f90023          	sb	a5,0(s2)
                if (st.type == T_DIR) {
 110:	4a85                	li	s5,1
            while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 112:	4641                	li	a2,16
 114:	db040593          	addi	a1,s0,-592
 118:	8526                	mv	a0,s1
 11a:	00000097          	auipc	ra,0x0
 11e:	382080e7          	jalr	898(ra) # 49c <read>
 122:	47c1                	li	a5,16
 124:	f2f516e3          	bne	a0,a5,50 <find+0x50>
                if (de.inum == 0) continue;  // skip empty entries
 128:	db045783          	lhu	a5,-592(s0)
 12c:	d3fd                	beqz	a5,112 <find+0x112>
                memmove(p, de.name, DIRSIZ);
 12e:	4639                	li	a2,14
 130:	db240593          	addi	a1,s0,-590
 134:	8552                	mv	a0,s4
 136:	00000097          	auipc	ra,0x0
 13a:	29c080e7          	jalr	668(ra) # 3d2 <memmove>
                p[DIRSIZ] = 0;
 13e:	000907a3          	sb	zero,15(s2)
                if (stat(buf, &st) < 0) {
 142:	d9840593          	addi	a1,s0,-616
 146:	dc040513          	addi	a0,s0,-576
 14a:	00000097          	auipc	ra,0x0
 14e:	1fa080e7          	jalr	506(ra) # 344 <stat>
 152:	02054963          	bltz	a0,184 <find+0x184>
                if (st.type == T_DIR) {
 156:	da041783          	lh	a5,-608(s0)
 15a:	05578063          	beq	a5,s5,19a <find+0x19a>
                    if (strcmp(de.name, name) == 0) {
 15e:	85ce                	mv	a1,s3
 160:	db240513          	addi	a0,s0,-590
 164:	00000097          	auipc	ra,0x0
 168:	0d0080e7          	jalr	208(ra) # 234 <strcmp>
 16c:	f15d                	bnez	a0,112 <find+0x112>
                        printf("%s\n", buf);
 16e:	dc040593          	addi	a1,s0,-576
 172:	00001517          	auipc	a0,0x1
 176:	87650513          	addi	a0,a0,-1930 # 9e8 <malloc+0x144>
 17a:	00000097          	auipc	ra,0x0
 17e:	672080e7          	jalr	1650(ra) # 7ec <printf>
 182:	bf41                	j	112 <find+0x112>
                    printf("find: cannot stat %s\n", buf);
 184:	dc040593          	addi	a1,s0,-576
 188:	00001517          	auipc	a0,0x1
 18c:	82050513          	addi	a0,a0,-2016 # 9a8 <malloc+0x104>
 190:	00000097          	auipc	ra,0x0
 194:	65c080e7          	jalr	1628(ra) # 7ec <printf>
                    continue;
 198:	bfad                	j	112 <find+0x112>
                    if (strcmp(de.name, ".") == 0 ||
 19a:	00001597          	auipc	a1,0x1
 19e:	83e58593          	addi	a1,a1,-1986 # 9d8 <malloc+0x134>
 1a2:	db240513          	addi	a0,s0,-590
 1a6:	00000097          	auipc	ra,0x0
 1aa:	08e080e7          	jalr	142(ra) # 234 <strcmp>
 1ae:	d135                	beqz	a0,112 <find+0x112>
                        strcmp(de.name, "..") == 0) {
 1b0:	00001597          	auipc	a1,0x1
 1b4:	83058593          	addi	a1,a1,-2000 # 9e0 <malloc+0x13c>
 1b8:	db240513          	addi	a0,s0,-590
 1bc:	00000097          	auipc	ra,0x0
 1c0:	078080e7          	jalr	120(ra) # 234 <strcmp>
                    if (strcmp(de.name, ".") == 0 ||
 1c4:	d539                	beqz	a0,112 <find+0x112>
                    find(buf, name);
 1c6:	85ce                	mv	a1,s3
 1c8:	dc040513          	addi	a0,s0,-576
 1cc:	00000097          	auipc	ra,0x0
 1d0:	e34080e7          	jalr	-460(ra) # 0 <find>
 1d4:	bf3d                	j	112 <find+0x112>

00000000000001d6 <main>:

int main(int argc, char *argv[]) {
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e406                	sd	ra,8(sp)
 1da:	e022                	sd	s0,0(sp)
 1dc:	0800                	addi	s0,sp,16
 1de:	87ae                	mv	a5,a1
    if (argc < 3) {
 1e0:	4709                	li	a4,2
 1e2:	02a74063          	blt	a4,a0,202 <main+0x2c>
        printf("Usage: %s <dir> <file>\n", argv[0]);
 1e6:	618c                	ld	a1,0(a1)
 1e8:	00001517          	auipc	a0,0x1
 1ec:	80850513          	addi	a0,a0,-2040 # 9f0 <malloc+0x14c>
 1f0:	00000097          	auipc	ra,0x0
 1f4:	5fc080e7          	jalr	1532(ra) # 7ec <printf>
        exit(1);
 1f8:	4505                	li	a0,1
 1fa:	00000097          	auipc	ra,0x0
 1fe:	28a080e7          	jalr	650(ra) # 484 <exit>
    }
    char *dir = argv[1];
    char *file = argv[2];
    find(dir, file);
 202:	698c                	ld	a1,16(a1)
 204:	6788                	ld	a0,8(a5)
 206:	00000097          	auipc	ra,0x0
 20a:	dfa080e7          	jalr	-518(ra) # 0 <find>
    exit(0);
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	274080e7          	jalr	628(ra) # 484 <exit>

0000000000000218 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 21e:	87aa                	mv	a5,a0
 220:	0585                	addi	a1,a1,1
 222:	0785                	addi	a5,a5,1
 224:	fff5c703          	lbu	a4,-1(a1)
 228:	fee78fa3          	sb	a4,-1(a5)
 22c:	fb75                	bnez	a4,220 <strcpy+0x8>
    ;
  return os;
}
 22e:	6422                	ld	s0,8(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret

0000000000000234 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 234:	1141                	addi	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 23a:	00054783          	lbu	a5,0(a0)
 23e:	cb91                	beqz	a5,252 <strcmp+0x1e>
 240:	0005c703          	lbu	a4,0(a1)
 244:	00f71763          	bne	a4,a5,252 <strcmp+0x1e>
    p++, q++;
 248:	0505                	addi	a0,a0,1
 24a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 24c:	00054783          	lbu	a5,0(a0)
 250:	fbe5                	bnez	a5,240 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 252:	0005c503          	lbu	a0,0(a1)
}
 256:	40a7853b          	subw	a0,a5,a0
 25a:	6422                	ld	s0,8(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret

0000000000000260 <strlen>:

uint
strlen(const char *s)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 266:	00054783          	lbu	a5,0(a0)
 26a:	cf91                	beqz	a5,286 <strlen+0x26>
 26c:	0505                	addi	a0,a0,1
 26e:	87aa                	mv	a5,a0
 270:	86be                	mv	a3,a5
 272:	0785                	addi	a5,a5,1
 274:	fff7c703          	lbu	a4,-1(a5)
 278:	ff65                	bnez	a4,270 <strlen+0x10>
 27a:	40a6853b          	subw	a0,a3,a0
 27e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 280:	6422                	ld	s0,8(sp)
 282:	0141                	addi	sp,sp,16
 284:	8082                	ret
  for(n = 0; s[n]; n++)
 286:	4501                	li	a0,0
 288:	bfe5                	j	280 <strlen+0x20>

000000000000028a <memset>:

void*
memset(void *dst, int c, uint n)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e422                	sd	s0,8(sp)
 28e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 290:	ca19                	beqz	a2,2a6 <memset+0x1c>
 292:	87aa                	mv	a5,a0
 294:	1602                	slli	a2,a2,0x20
 296:	9201                	srli	a2,a2,0x20
 298:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 29c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2a0:	0785                	addi	a5,a5,1
 2a2:	fee79de3          	bne	a5,a4,29c <memset+0x12>
  }
  return dst;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret

00000000000002ac <strchr>:

char*
strchr(const char *s, char c)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	cb99                	beqz	a5,2cc <strchr+0x20>
    if(*s == c)
 2b8:	00f58763          	beq	a1,a5,2c6 <strchr+0x1a>
  for(; *s; s++)
 2bc:	0505                	addi	a0,a0,1
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	fbfd                	bnez	a5,2b8 <strchr+0xc>
      return (char*)s;
  return 0;
 2c4:	4501                	li	a0,0
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  return 0;
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <strchr+0x1a>

00000000000002d0 <gets>:

char*
gets(char *buf, int max)
{
 2d0:	711d                	addi	sp,sp,-96
 2d2:	ec86                	sd	ra,88(sp)
 2d4:	e8a2                	sd	s0,80(sp)
 2d6:	e4a6                	sd	s1,72(sp)
 2d8:	e0ca                	sd	s2,64(sp)
 2da:	fc4e                	sd	s3,56(sp)
 2dc:	f852                	sd	s4,48(sp)
 2de:	f456                	sd	s5,40(sp)
 2e0:	f05a                	sd	s6,32(sp)
 2e2:	ec5e                	sd	s7,24(sp)
 2e4:	1080                	addi	s0,sp,96
 2e6:	8baa                	mv	s7,a0
 2e8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ea:	892a                	mv	s2,a0
 2ec:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2ee:	4aa9                	li	s5,10
 2f0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2f2:	89a6                	mv	s3,s1
 2f4:	2485                	addiw	s1,s1,1
 2f6:	0344d863          	bge	s1,s4,326 <gets+0x56>
    cc = read(0, &c, 1);
 2fa:	4605                	li	a2,1
 2fc:	faf40593          	addi	a1,s0,-81
 300:	4501                	li	a0,0
 302:	00000097          	auipc	ra,0x0
 306:	19a080e7          	jalr	410(ra) # 49c <read>
    if(cc < 1)
 30a:	00a05e63          	blez	a0,326 <gets+0x56>
    buf[i++] = c;
 30e:	faf44783          	lbu	a5,-81(s0)
 312:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 316:	01578763          	beq	a5,s5,324 <gets+0x54>
 31a:	0905                	addi	s2,s2,1
 31c:	fd679be3          	bne	a5,s6,2f2 <gets+0x22>
  for(i=0; i+1 < max; ){
 320:	89a6                	mv	s3,s1
 322:	a011                	j	326 <gets+0x56>
 324:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 326:	99de                	add	s3,s3,s7
 328:	00098023          	sb	zero,0(s3)
  return buf;
}
 32c:	855e                	mv	a0,s7
 32e:	60e6                	ld	ra,88(sp)
 330:	6446                	ld	s0,80(sp)
 332:	64a6                	ld	s1,72(sp)
 334:	6906                	ld	s2,64(sp)
 336:	79e2                	ld	s3,56(sp)
 338:	7a42                	ld	s4,48(sp)
 33a:	7aa2                	ld	s5,40(sp)
 33c:	7b02                	ld	s6,32(sp)
 33e:	6be2                	ld	s7,24(sp)
 340:	6125                	addi	sp,sp,96
 342:	8082                	ret

0000000000000344 <stat>:

int
stat(const char *n, struct stat *st)
{
 344:	1101                	addi	sp,sp,-32
 346:	ec06                	sd	ra,24(sp)
 348:	e822                	sd	s0,16(sp)
 34a:	e426                	sd	s1,8(sp)
 34c:	e04a                	sd	s2,0(sp)
 34e:	1000                	addi	s0,sp,32
 350:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 352:	4581                	li	a1,0
 354:	00000097          	auipc	ra,0x0
 358:	170080e7          	jalr	368(ra) # 4c4 <open>
  if(fd < 0)
 35c:	02054563          	bltz	a0,386 <stat+0x42>
 360:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 362:	85ca                	mv	a1,s2
 364:	00000097          	auipc	ra,0x0
 368:	178080e7          	jalr	376(ra) # 4dc <fstat>
 36c:	892a                	mv	s2,a0
  close(fd);
 36e:	8526                	mv	a0,s1
 370:	00000097          	auipc	ra,0x0
 374:	13c080e7          	jalr	316(ra) # 4ac <close>
  return r;
}
 378:	854a                	mv	a0,s2
 37a:	60e2                	ld	ra,24(sp)
 37c:	6442                	ld	s0,16(sp)
 37e:	64a2                	ld	s1,8(sp)
 380:	6902                	ld	s2,0(sp)
 382:	6105                	addi	sp,sp,32
 384:	8082                	ret
    return -1;
 386:	597d                	li	s2,-1
 388:	bfc5                	j	378 <stat+0x34>

000000000000038a <atoi>:

int
atoi(const char *s)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 390:	00054683          	lbu	a3,0(a0)
 394:	fd06879b          	addiw	a5,a3,-48
 398:	0ff7f793          	zext.b	a5,a5
 39c:	4625                	li	a2,9
 39e:	02f66863          	bltu	a2,a5,3ce <atoi+0x44>
 3a2:	872a                	mv	a4,a0
  n = 0;
 3a4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3a6:	0705                	addi	a4,a4,1
 3a8:	0025179b          	slliw	a5,a0,0x2
 3ac:	9fa9                	addw	a5,a5,a0
 3ae:	0017979b          	slliw	a5,a5,0x1
 3b2:	9fb5                	addw	a5,a5,a3
 3b4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3b8:	00074683          	lbu	a3,0(a4)
 3bc:	fd06879b          	addiw	a5,a3,-48
 3c0:	0ff7f793          	zext.b	a5,a5
 3c4:	fef671e3          	bgeu	a2,a5,3a6 <atoi+0x1c>
  return n;
}
 3c8:	6422                	ld	s0,8(sp)
 3ca:	0141                	addi	sp,sp,16
 3cc:	8082                	ret
  n = 0;
 3ce:	4501                	li	a0,0
 3d0:	bfe5                	j	3c8 <atoi+0x3e>

00000000000003d2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d2:	1141                	addi	sp,sp,-16
 3d4:	e422                	sd	s0,8(sp)
 3d6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3d8:	02b57463          	bgeu	a0,a1,400 <memmove+0x2e>
    while(n-- > 0)
 3dc:	00c05f63          	blez	a2,3fa <memmove+0x28>
 3e0:	1602                	slli	a2,a2,0x20
 3e2:	9201                	srli	a2,a2,0x20
 3e4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3e8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3ea:	0585                	addi	a1,a1,1
 3ec:	0705                	addi	a4,a4,1
 3ee:	fff5c683          	lbu	a3,-1(a1)
 3f2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3f6:	fee79ae3          	bne	a5,a4,3ea <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3fa:	6422                	ld	s0,8(sp)
 3fc:	0141                	addi	sp,sp,16
 3fe:	8082                	ret
    dst += n;
 400:	00c50733          	add	a4,a0,a2
    src += n;
 404:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 406:	fec05ae3          	blez	a2,3fa <memmove+0x28>
 40a:	fff6079b          	addiw	a5,a2,-1
 40e:	1782                	slli	a5,a5,0x20
 410:	9381                	srli	a5,a5,0x20
 412:	fff7c793          	not	a5,a5
 416:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 418:	15fd                	addi	a1,a1,-1
 41a:	177d                	addi	a4,a4,-1
 41c:	0005c683          	lbu	a3,0(a1)
 420:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 424:	fee79ae3          	bne	a5,a4,418 <memmove+0x46>
 428:	bfc9                	j	3fa <memmove+0x28>

000000000000042a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 42a:	1141                	addi	sp,sp,-16
 42c:	e422                	sd	s0,8(sp)
 42e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 430:	ca05                	beqz	a2,460 <memcmp+0x36>
 432:	fff6069b          	addiw	a3,a2,-1
 436:	1682                	slli	a3,a3,0x20
 438:	9281                	srli	a3,a3,0x20
 43a:	0685                	addi	a3,a3,1
 43c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 43e:	00054783          	lbu	a5,0(a0)
 442:	0005c703          	lbu	a4,0(a1)
 446:	00e79863          	bne	a5,a4,456 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 44a:	0505                	addi	a0,a0,1
    p2++;
 44c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 44e:	fed518e3          	bne	a0,a3,43e <memcmp+0x14>
  }
  return 0;
 452:	4501                	li	a0,0
 454:	a019                	j	45a <memcmp+0x30>
      return *p1 - *p2;
 456:	40e7853b          	subw	a0,a5,a4
}
 45a:	6422                	ld	s0,8(sp)
 45c:	0141                	addi	sp,sp,16
 45e:	8082                	ret
  return 0;
 460:	4501                	li	a0,0
 462:	bfe5                	j	45a <memcmp+0x30>

0000000000000464 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 464:	1141                	addi	sp,sp,-16
 466:	e406                	sd	ra,8(sp)
 468:	e022                	sd	s0,0(sp)
 46a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 46c:	00000097          	auipc	ra,0x0
 470:	f66080e7          	jalr	-154(ra) # 3d2 <memmove>
}
 474:	60a2                	ld	ra,8(sp)
 476:	6402                	ld	s0,0(sp)
 478:	0141                	addi	sp,sp,16
 47a:	8082                	ret

000000000000047c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 47c:	4885                	li	a7,1
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <exit>:
.global exit
exit:
 li a7, SYS_exit
 484:	4889                	li	a7,2
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <wait>:
.global wait
wait:
 li a7, SYS_wait
 48c:	488d                	li	a7,3
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 494:	4891                	li	a7,4
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <read>:
.global read
read:
 li a7, SYS_read
 49c:	4895                	li	a7,5
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <write>:
.global write
write:
 li a7, SYS_write
 4a4:	48c1                	li	a7,16
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <close>:
.global close
close:
 li a7, SYS_close
 4ac:	48d5                	li	a7,21
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4b4:	4899                	li	a7,6
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <exec>:
.global exec
exec:
 li a7, SYS_exec
 4bc:	489d                	li	a7,7
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <open>:
.global open
open:
 li a7, SYS_open
 4c4:	48bd                	li	a7,15
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4cc:	48c5                	li	a7,17
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4d4:	48c9                	li	a7,18
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4dc:	48a1                	li	a7,8
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <link>:
.global link
link:
 li a7, SYS_link
 4e4:	48cd                	li	a7,19
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ec:	48d1                	li	a7,20
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4f4:	48a5                	li	a7,9
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <dup>:
.global dup
dup:
 li a7, SYS_dup
 4fc:	48a9                	li	a7,10
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 504:	48ad                	li	a7,11
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 50c:	48b1                	li	a7,12
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 514:	48b5                	li	a7,13
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 51c:	48b9                	li	a7,14
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 524:	1101                	addi	sp,sp,-32
 526:	ec06                	sd	ra,24(sp)
 528:	e822                	sd	s0,16(sp)
 52a:	1000                	addi	s0,sp,32
 52c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 530:	4605                	li	a2,1
 532:	fef40593          	addi	a1,s0,-17
 536:	00000097          	auipc	ra,0x0
 53a:	f6e080e7          	jalr	-146(ra) # 4a4 <write>
}
 53e:	60e2                	ld	ra,24(sp)
 540:	6442                	ld	s0,16(sp)
 542:	6105                	addi	sp,sp,32
 544:	8082                	ret

0000000000000546 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 546:	7139                	addi	sp,sp,-64
 548:	fc06                	sd	ra,56(sp)
 54a:	f822                	sd	s0,48(sp)
 54c:	f426                	sd	s1,40(sp)
 54e:	f04a                	sd	s2,32(sp)
 550:	ec4e                	sd	s3,24(sp)
 552:	0080                	addi	s0,sp,64
 554:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 556:	c299                	beqz	a3,55c <printint+0x16>
 558:	0805c963          	bltz	a1,5ea <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 55c:	2581                	sext.w	a1,a1
  neg = 0;
 55e:	4881                	li	a7,0
 560:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 564:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 566:	2601                	sext.w	a2,a2
 568:	00000517          	auipc	a0,0x0
 56c:	50050513          	addi	a0,a0,1280 # a68 <digits>
 570:	883a                	mv	a6,a4
 572:	2705                	addiw	a4,a4,1
 574:	02c5f7bb          	remuw	a5,a1,a2
 578:	1782                	slli	a5,a5,0x20
 57a:	9381                	srli	a5,a5,0x20
 57c:	97aa                	add	a5,a5,a0
 57e:	0007c783          	lbu	a5,0(a5)
 582:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 586:	0005879b          	sext.w	a5,a1
 58a:	02c5d5bb          	divuw	a1,a1,a2
 58e:	0685                	addi	a3,a3,1
 590:	fec7f0e3          	bgeu	a5,a2,570 <printint+0x2a>
  if(neg)
 594:	00088c63          	beqz	a7,5ac <printint+0x66>
    buf[i++] = '-';
 598:	fd070793          	addi	a5,a4,-48
 59c:	00878733          	add	a4,a5,s0
 5a0:	02d00793          	li	a5,45
 5a4:	fef70823          	sb	a5,-16(a4)
 5a8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5ac:	02e05863          	blez	a4,5dc <printint+0x96>
 5b0:	fc040793          	addi	a5,s0,-64
 5b4:	00e78933          	add	s2,a5,a4
 5b8:	fff78993          	addi	s3,a5,-1
 5bc:	99ba                	add	s3,s3,a4
 5be:	377d                	addiw	a4,a4,-1
 5c0:	1702                	slli	a4,a4,0x20
 5c2:	9301                	srli	a4,a4,0x20
 5c4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5c8:	fff94583          	lbu	a1,-1(s2)
 5cc:	8526                	mv	a0,s1
 5ce:	00000097          	auipc	ra,0x0
 5d2:	f56080e7          	jalr	-170(ra) # 524 <putc>
  while(--i >= 0)
 5d6:	197d                	addi	s2,s2,-1
 5d8:	ff3918e3          	bne	s2,s3,5c8 <printint+0x82>
}
 5dc:	70e2                	ld	ra,56(sp)
 5de:	7442                	ld	s0,48(sp)
 5e0:	74a2                	ld	s1,40(sp)
 5e2:	7902                	ld	s2,32(sp)
 5e4:	69e2                	ld	s3,24(sp)
 5e6:	6121                	addi	sp,sp,64
 5e8:	8082                	ret
    x = -xx;
 5ea:	40b005bb          	negw	a1,a1
    neg = 1;
 5ee:	4885                	li	a7,1
    x = -xx;
 5f0:	bf85                	j	560 <printint+0x1a>

00000000000005f2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5f2:	715d                	addi	sp,sp,-80
 5f4:	e486                	sd	ra,72(sp)
 5f6:	e0a2                	sd	s0,64(sp)
 5f8:	fc26                	sd	s1,56(sp)
 5fa:	f84a                	sd	s2,48(sp)
 5fc:	f44e                	sd	s3,40(sp)
 5fe:	f052                	sd	s4,32(sp)
 600:	ec56                	sd	s5,24(sp)
 602:	e85a                	sd	s6,16(sp)
 604:	e45e                	sd	s7,8(sp)
 606:	e062                	sd	s8,0(sp)
 608:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 60a:	0005c903          	lbu	s2,0(a1)
 60e:	18090c63          	beqz	s2,7a6 <vprintf+0x1b4>
 612:	8aaa                	mv	s5,a0
 614:	8bb2                	mv	s7,a2
 616:	00158493          	addi	s1,a1,1
  state = 0;
 61a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 61c:	02500a13          	li	s4,37
 620:	4b55                	li	s6,21
 622:	a839                	j	640 <vprintf+0x4e>
        putc(fd, c);
 624:	85ca                	mv	a1,s2
 626:	8556                	mv	a0,s5
 628:	00000097          	auipc	ra,0x0
 62c:	efc080e7          	jalr	-260(ra) # 524 <putc>
 630:	a019                	j	636 <vprintf+0x44>
    } else if(state == '%'){
 632:	01498d63          	beq	s3,s4,64c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 636:	0485                	addi	s1,s1,1
 638:	fff4c903          	lbu	s2,-1(s1)
 63c:	16090563          	beqz	s2,7a6 <vprintf+0x1b4>
    if(state == 0){
 640:	fe0999e3          	bnez	s3,632 <vprintf+0x40>
      if(c == '%'){
 644:	ff4910e3          	bne	s2,s4,624 <vprintf+0x32>
        state = '%';
 648:	89d2                	mv	s3,s4
 64a:	b7f5                	j	636 <vprintf+0x44>
      if(c == 'd'){
 64c:	13490263          	beq	s2,s4,770 <vprintf+0x17e>
 650:	f9d9079b          	addiw	a5,s2,-99
 654:	0ff7f793          	zext.b	a5,a5
 658:	12fb6563          	bltu	s6,a5,782 <vprintf+0x190>
 65c:	f9d9079b          	addiw	a5,s2,-99
 660:	0ff7f713          	zext.b	a4,a5
 664:	10eb6f63          	bltu	s6,a4,782 <vprintf+0x190>
 668:	00271793          	slli	a5,a4,0x2
 66c:	00000717          	auipc	a4,0x0
 670:	3a470713          	addi	a4,a4,932 # a10 <malloc+0x16c>
 674:	97ba                	add	a5,a5,a4
 676:	439c                	lw	a5,0(a5)
 678:	97ba                	add	a5,a5,a4
 67a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 67c:	008b8913          	addi	s2,s7,8
 680:	4685                	li	a3,1
 682:	4629                	li	a2,10
 684:	000ba583          	lw	a1,0(s7)
 688:	8556                	mv	a0,s5
 68a:	00000097          	auipc	ra,0x0
 68e:	ebc080e7          	jalr	-324(ra) # 546 <printint>
 692:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 694:	4981                	li	s3,0
 696:	b745                	j	636 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 698:	008b8913          	addi	s2,s7,8
 69c:	4681                	li	a3,0
 69e:	4629                	li	a2,10
 6a0:	000ba583          	lw	a1,0(s7)
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	ea0080e7          	jalr	-352(ra) # 546 <printint>
 6ae:	8bca                	mv	s7,s2
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	b751                	j	636 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 6b4:	008b8913          	addi	s2,s7,8
 6b8:	4681                	li	a3,0
 6ba:	4641                	li	a2,16
 6bc:	000ba583          	lw	a1,0(s7)
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	e84080e7          	jalr	-380(ra) # 546 <printint>
 6ca:	8bca                	mv	s7,s2
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b7a5                	j	636 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 6d0:	008b8c13          	addi	s8,s7,8
 6d4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6d8:	03000593          	li	a1,48
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	e46080e7          	jalr	-442(ra) # 524 <putc>
  putc(fd, 'x');
 6e6:	07800593          	li	a1,120
 6ea:	8556                	mv	a0,s5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	e38080e7          	jalr	-456(ra) # 524 <putc>
 6f4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f6:	00000b97          	auipc	s7,0x0
 6fa:	372b8b93          	addi	s7,s7,882 # a68 <digits>
 6fe:	03c9d793          	srli	a5,s3,0x3c
 702:	97de                	add	a5,a5,s7
 704:	0007c583          	lbu	a1,0(a5)
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	e1a080e7          	jalr	-486(ra) # 524 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 712:	0992                	slli	s3,s3,0x4
 714:	397d                	addiw	s2,s2,-1
 716:	fe0914e3          	bnez	s2,6fe <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 71a:	8be2                	mv	s7,s8
      state = 0;
 71c:	4981                	li	s3,0
 71e:	bf21                	j	636 <vprintf+0x44>
        s = va_arg(ap, char*);
 720:	008b8993          	addi	s3,s7,8
 724:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 728:	02090163          	beqz	s2,74a <vprintf+0x158>
        while(*s != 0){
 72c:	00094583          	lbu	a1,0(s2)
 730:	c9a5                	beqz	a1,7a0 <vprintf+0x1ae>
          putc(fd, *s);
 732:	8556                	mv	a0,s5
 734:	00000097          	auipc	ra,0x0
 738:	df0080e7          	jalr	-528(ra) # 524 <putc>
          s++;
 73c:	0905                	addi	s2,s2,1
        while(*s != 0){
 73e:	00094583          	lbu	a1,0(s2)
 742:	f9e5                	bnez	a1,732 <vprintf+0x140>
        s = va_arg(ap, char*);
 744:	8bce                	mv	s7,s3
      state = 0;
 746:	4981                	li	s3,0
 748:	b5fd                	j	636 <vprintf+0x44>
          s = "(null)";
 74a:	00000917          	auipc	s2,0x0
 74e:	2be90913          	addi	s2,s2,702 # a08 <malloc+0x164>
        while(*s != 0){
 752:	02800593          	li	a1,40
 756:	bff1                	j	732 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 758:	008b8913          	addi	s2,s7,8
 75c:	000bc583          	lbu	a1,0(s7)
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	dc2080e7          	jalr	-574(ra) # 524 <putc>
 76a:	8bca                	mv	s7,s2
      state = 0;
 76c:	4981                	li	s3,0
 76e:	b5e1                	j	636 <vprintf+0x44>
        putc(fd, c);
 770:	02500593          	li	a1,37
 774:	8556                	mv	a0,s5
 776:	00000097          	auipc	ra,0x0
 77a:	dae080e7          	jalr	-594(ra) # 524 <putc>
      state = 0;
 77e:	4981                	li	s3,0
 780:	bd5d                	j	636 <vprintf+0x44>
        putc(fd, '%');
 782:	02500593          	li	a1,37
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	d9c080e7          	jalr	-612(ra) # 524 <putc>
        putc(fd, c);
 790:	85ca                	mv	a1,s2
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	d90080e7          	jalr	-624(ra) # 524 <putc>
      state = 0;
 79c:	4981                	li	s3,0
 79e:	bd61                	j	636 <vprintf+0x44>
        s = va_arg(ap, char*);
 7a0:	8bce                	mv	s7,s3
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	bd49                	j	636 <vprintf+0x44>
    }
  }
}
 7a6:	60a6                	ld	ra,72(sp)
 7a8:	6406                	ld	s0,64(sp)
 7aa:	74e2                	ld	s1,56(sp)
 7ac:	7942                	ld	s2,48(sp)
 7ae:	79a2                	ld	s3,40(sp)
 7b0:	7a02                	ld	s4,32(sp)
 7b2:	6ae2                	ld	s5,24(sp)
 7b4:	6b42                	ld	s6,16(sp)
 7b6:	6ba2                	ld	s7,8(sp)
 7b8:	6c02                	ld	s8,0(sp)
 7ba:	6161                	addi	sp,sp,80
 7bc:	8082                	ret

00000000000007be <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7be:	715d                	addi	sp,sp,-80
 7c0:	ec06                	sd	ra,24(sp)
 7c2:	e822                	sd	s0,16(sp)
 7c4:	1000                	addi	s0,sp,32
 7c6:	e010                	sd	a2,0(s0)
 7c8:	e414                	sd	a3,8(s0)
 7ca:	e818                	sd	a4,16(s0)
 7cc:	ec1c                	sd	a5,24(s0)
 7ce:	03043023          	sd	a6,32(s0)
 7d2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7da:	8622                	mv	a2,s0
 7dc:	00000097          	auipc	ra,0x0
 7e0:	e16080e7          	jalr	-490(ra) # 5f2 <vprintf>
}
 7e4:	60e2                	ld	ra,24(sp)
 7e6:	6442                	ld	s0,16(sp)
 7e8:	6161                	addi	sp,sp,80
 7ea:	8082                	ret

00000000000007ec <printf>:

void
printf(const char *fmt, ...)
{
 7ec:	711d                	addi	sp,sp,-96
 7ee:	ec06                	sd	ra,24(sp)
 7f0:	e822                	sd	s0,16(sp)
 7f2:	1000                	addi	s0,sp,32
 7f4:	e40c                	sd	a1,8(s0)
 7f6:	e810                	sd	a2,16(s0)
 7f8:	ec14                	sd	a3,24(s0)
 7fa:	f018                	sd	a4,32(s0)
 7fc:	f41c                	sd	a5,40(s0)
 7fe:	03043823          	sd	a6,48(s0)
 802:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 806:	00840613          	addi	a2,s0,8
 80a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 80e:	85aa                	mv	a1,a0
 810:	4505                	li	a0,1
 812:	00000097          	auipc	ra,0x0
 816:	de0080e7          	jalr	-544(ra) # 5f2 <vprintf>
}
 81a:	60e2                	ld	ra,24(sp)
 81c:	6442                	ld	s0,16(sp)
 81e:	6125                	addi	sp,sp,96
 820:	8082                	ret

0000000000000822 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 822:	1141                	addi	sp,sp,-16
 824:	e422                	sd	s0,8(sp)
 826:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 828:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82c:	00000797          	auipc	a5,0x0
 830:	2547b783          	ld	a5,596(a5) # a80 <freep>
 834:	a02d                	j	85e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 836:	4618                	lw	a4,8(a2)
 838:	9f2d                	addw	a4,a4,a1
 83a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 83e:	6398                	ld	a4,0(a5)
 840:	6310                	ld	a2,0(a4)
 842:	a83d                	j	880 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 844:	ff852703          	lw	a4,-8(a0)
 848:	9f31                	addw	a4,a4,a2
 84a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 84c:	ff053683          	ld	a3,-16(a0)
 850:	a091                	j	894 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 852:	6398                	ld	a4,0(a5)
 854:	00e7e463          	bltu	a5,a4,85c <free+0x3a>
 858:	00e6ea63          	bltu	a3,a4,86c <free+0x4a>
{
 85c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85e:	fed7fae3          	bgeu	a5,a3,852 <free+0x30>
 862:	6398                	ld	a4,0(a5)
 864:	00e6e463          	bltu	a3,a4,86c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 868:	fee7eae3          	bltu	a5,a4,85c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 86c:	ff852583          	lw	a1,-8(a0)
 870:	6390                	ld	a2,0(a5)
 872:	02059813          	slli	a6,a1,0x20
 876:	01c85713          	srli	a4,a6,0x1c
 87a:	9736                	add	a4,a4,a3
 87c:	fae60de3          	beq	a2,a4,836 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 880:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 884:	4790                	lw	a2,8(a5)
 886:	02061593          	slli	a1,a2,0x20
 88a:	01c5d713          	srli	a4,a1,0x1c
 88e:	973e                	add	a4,a4,a5
 890:	fae68ae3          	beq	a3,a4,844 <free+0x22>
    p->s.ptr = bp->s.ptr;
 894:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 896:	00000717          	auipc	a4,0x0
 89a:	1ef73523          	sd	a5,490(a4) # a80 <freep>
}
 89e:	6422                	ld	s0,8(sp)
 8a0:	0141                	addi	sp,sp,16
 8a2:	8082                	ret

00000000000008a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a4:	7139                	addi	sp,sp,-64
 8a6:	fc06                	sd	ra,56(sp)
 8a8:	f822                	sd	s0,48(sp)
 8aa:	f426                	sd	s1,40(sp)
 8ac:	f04a                	sd	s2,32(sp)
 8ae:	ec4e                	sd	s3,24(sp)
 8b0:	e852                	sd	s4,16(sp)
 8b2:	e456                	sd	s5,8(sp)
 8b4:	e05a                	sd	s6,0(sp)
 8b6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b8:	02051493          	slli	s1,a0,0x20
 8bc:	9081                	srli	s1,s1,0x20
 8be:	04bd                	addi	s1,s1,15
 8c0:	8091                	srli	s1,s1,0x4
 8c2:	0014899b          	addiw	s3,s1,1
 8c6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8c8:	00000517          	auipc	a0,0x0
 8cc:	1b853503          	ld	a0,440(a0) # a80 <freep>
 8d0:	c515                	beqz	a0,8fc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d4:	4798                	lw	a4,8(a5)
 8d6:	02977f63          	bgeu	a4,s1,914 <malloc+0x70>
  if(nu < 4096)
 8da:	8a4e                	mv	s4,s3
 8dc:	0009871b          	sext.w	a4,s3
 8e0:	6685                	lui	a3,0x1
 8e2:	00d77363          	bgeu	a4,a3,8e8 <malloc+0x44>
 8e6:	6a05                	lui	s4,0x1
 8e8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8ec:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f0:	00000917          	auipc	s2,0x0
 8f4:	19090913          	addi	s2,s2,400 # a80 <freep>
  if(p == (char*)-1)
 8f8:	5afd                	li	s5,-1
 8fa:	a895                	j	96e <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8fc:	004e2797          	auipc	a5,0x4e2
 900:	18c78793          	addi	a5,a5,396 # 4e2a88 <base>
 904:	00000717          	auipc	a4,0x0
 908:	16f73e23          	sd	a5,380(a4) # a80 <freep>
 90c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 90e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 912:	b7e1                	j	8da <malloc+0x36>
      if(p->s.size == nunits)
 914:	02e48c63          	beq	s1,a4,94c <malloc+0xa8>
        p->s.size -= nunits;
 918:	4137073b          	subw	a4,a4,s3
 91c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 91e:	02071693          	slli	a3,a4,0x20
 922:	01c6d713          	srli	a4,a3,0x1c
 926:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 928:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 92c:	00000717          	auipc	a4,0x0
 930:	14a73a23          	sd	a0,340(a4) # a80 <freep>
      return (void*)(p + 1);
 934:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 938:	70e2                	ld	ra,56(sp)
 93a:	7442                	ld	s0,48(sp)
 93c:	74a2                	ld	s1,40(sp)
 93e:	7902                	ld	s2,32(sp)
 940:	69e2                	ld	s3,24(sp)
 942:	6a42                	ld	s4,16(sp)
 944:	6aa2                	ld	s5,8(sp)
 946:	6b02                	ld	s6,0(sp)
 948:	6121                	addi	sp,sp,64
 94a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 94c:	6398                	ld	a4,0(a5)
 94e:	e118                	sd	a4,0(a0)
 950:	bff1                	j	92c <malloc+0x88>
  hp->s.size = nu;
 952:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 956:	0541                	addi	a0,a0,16
 958:	00000097          	auipc	ra,0x0
 95c:	eca080e7          	jalr	-310(ra) # 822 <free>
  return freep;
 960:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 964:	d971                	beqz	a0,938 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 966:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 968:	4798                	lw	a4,8(a5)
 96a:	fa9775e3          	bgeu	a4,s1,914 <malloc+0x70>
    if(p == freep)
 96e:	00093703          	ld	a4,0(s2)
 972:	853e                	mv	a0,a5
 974:	fef719e3          	bne	a4,a5,966 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 978:	8552                	mv	a0,s4
 97a:	00000097          	auipc	ra,0x0
 97e:	b92080e7          	jalr	-1134(ra) # 50c <sbrk>
  if(p == (char*)-1)
 982:	fd5518e3          	bne	a0,s5,952 <malloc+0xae>
        return 0;
 986:	4501                	li	a0,0
 988:	bf45                	j	938 <malloc+0x94>
