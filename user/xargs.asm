
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readline>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"

int readline(char *new_argv[32], int curr_argc) {
   0:	bc010113          	addi	sp,sp,-1088
   4:	42113c23          	sd	ra,1080(sp)
   8:	42813823          	sd	s0,1072(sp)
   c:	42913423          	sd	s1,1064(sp)
  10:	43213023          	sd	s2,1056(sp)
  14:	41313c23          	sd	s3,1048(sp)
  18:	41413823          	sd	s4,1040(sp)
  1c:	41513423          	sd	s5,1032(sp)
  20:	41613023          	sd	s6,1024(sp)
  24:	44010413          	addi	s0,sp,1088
  28:	8b2a                	mv	s6,a0
  2a:	8aae                	mv	s5,a1
    // read from stdout, separate by lines
    char buf[1024];
    int n = 0;
    while (read(0, buf + n, 1)) {
  2c:	bc040913          	addi	s2,s0,-1088
    int n = 0;
  30:	4481                	li	s1,0
        if (n == 1023) {
  32:	3ff00993          	li	s3,1023
            fprintf(2, "argument is too long\n");
            exit(1);
        }
        if (buf[n] == '\n') {
  36:	4a29                	li	s4,10
    while (read(0, buf + n, 1)) {
  38:	4605                	li	a2,1
  3a:	85ca                	mv	a1,s2
  3c:	4501                	li	a0,0
  3e:	00000097          	auipc	ra,0x0
  42:	45e080e7          	jalr	1118(ra) # 49c <read>
  46:	c905                	beqz	a0,76 <readline+0x76>
        if (n == 1023) {
  48:	01348963          	beq	s1,s3,5a <readline+0x5a>
        if (buf[n] == '\n') {
  4c:	0905                	addi	s2,s2,1
  4e:	fff94783          	lbu	a5,-1(s2)
  52:	03478263          	beq	a5,s4,76 <readline+0x76>
            break;
        }
        n++;
  56:	2485                	addiw	s1,s1,1
  58:	b7c5                	j	38 <readline+0x38>
            fprintf(2, "argument is too long\n");
  5a:	00001597          	auipc	a1,0x1
  5e:	93658593          	addi	a1,a1,-1738 # 990 <malloc+0xec>
  62:	4509                	li	a0,2
  64:	00000097          	auipc	ra,0x0
  68:	75a080e7          	jalr	1882(ra) # 7be <fprintf>
            exit(1);
  6c:	4505                	li	a0,1
  6e:	00000097          	auipc	ra,0x0
  72:	416080e7          	jalr	1046(ra) # 484 <exit>
    }
    // parse the line into arguments by space
    buf[n] = 0;
  76:	fc048793          	addi	a5,s1,-64
  7a:	97a2                	add	a5,a5,s0
  7c:	c0078023          	sb	zero,-1024(a5)
    if (n == 0) return 0;
  80:	8526                	mv	a0,s1
  82:	c0b1                	beqz	s1,c6 <readline+0xc6>
    int offset = 0;
    while (offset < n) {
  84:	0a905663          	blez	s1,130 <readline+0x130>
  88:	003a9793          	slli	a5,s5,0x3
  8c:	00fb0833          	add	a6,s6,a5
  90:	8556                	mv	a0,s5
    int offset = 0;
  92:	4781                	li	a5,0
        new_argv[curr_argc++] = buf + offset;  // store argument
        while (buf[offset] != ' ' && offset < n) {
  94:	02000693          	li	a3,32
  98:	a8a9                	j	f2 <readline+0xf2>
            offset++;
        }
        while (buf[offset] == ' ' && offset < n) {
  9a:	fc078713          	addi	a4,a5,-64
  9e:	9722                	add	a4,a4,s0
  a0:	c0074703          	lbu	a4,-1024(a4)
  a4:	04d71463          	bne	a4,a3,ec <readline+0xec>
  a8:	0097df63          	bge	a5,s1,c6 <readline+0xc6>
  ac:	bc040713          	addi	a4,s0,-1088
  b0:	973e                	add	a4,a4,a5
            // clear buffer
            buf[offset++] = 0;
  b2:	2785                	addiw	a5,a5,1
  b4:	00070023          	sb	zero,0(a4)
        while (buf[offset] == ' ' && offset < n) {
  b8:	00174603          	lbu	a2,1(a4)
  bc:	02d61863          	bne	a2,a3,ec <readline+0xec>
  c0:	0705                	addi	a4,a4,1
  c2:	fef498e3          	bne	s1,a5,b2 <readline+0xb2>
        }
    }
    return curr_argc;
}
  c6:	43813083          	ld	ra,1080(sp)
  ca:	43013403          	ld	s0,1072(sp)
  ce:	42813483          	ld	s1,1064(sp)
  d2:	42013903          	ld	s2,1056(sp)
  d6:	41813983          	ld	s3,1048(sp)
  da:	41013a03          	ld	s4,1040(sp)
  de:	40813a83          	ld	s5,1032(sp)
  e2:	40013b03          	ld	s6,1024(sp)
  e6:	44010113          	addi	sp,sp,1088
  ea:	8082                	ret
    while (offset < n) {
  ec:	0821                	addi	a6,a6,8
  ee:	fc97dce3          	bge	a5,s1,c6 <readline+0xc6>
        new_argv[curr_argc++] = buf + offset;  // store argument
  f2:	2505                	addiw	a0,a0,1
  f4:	bc040713          	addi	a4,s0,-1088
  f8:	973e                	add	a4,a4,a5
  fa:	00e83023          	sd	a4,0(a6)
        while (buf[offset] != ' ' && offset < n) {
  fe:	fc078613          	addi	a2,a5,-64
 102:	9622                	add	a2,a2,s0
 104:	c0064603          	lbu	a2,-1024(a2)
 108:	fad600e3          	beq	a2,a3,a8 <readline+0xa8>
 10c:	fa97dde3          	bge	a5,s1,c6 <readline+0xc6>
            offset++;
 110:	2785                	addiw	a5,a5,1
        while (buf[offset] != ' ' && offset < n) {
 112:	00174603          	lbu	a2,1(a4)
 116:	f8d602e3          	beq	a2,a3,9a <readline+0x9a>
 11a:	0705                	addi	a4,a4,1
 11c:	fef49ae3          	bne	s1,a5,110 <readline+0x110>
        while (buf[offset] == ' ' && offset < n) {
 120:	fc078713          	addi	a4,a5,-64
 124:	9722                	add	a4,a4,s0
 126:	c0074703          	lbu	a4,-1024(a4)
 12a:	fcd711e3          	bne	a4,a3,ec <readline+0xec>
 12e:	bf61                	j	c6 <readline+0xc6>
    while (offset < n) {
 130:	8556                	mv	a0,s5
 132:	bf51                	j	c6 <readline+0xc6>

0000000000000134 <main>:

int main(int argc, char *argv[]) {
 134:	7169                	addi	sp,sp,-304
 136:	f606                	sd	ra,296(sp)
 138:	f222                	sd	s0,288(sp)
 13a:	ee26                	sd	s1,280(sp)
 13c:	ea4a                	sd	s2,272(sp)
 13e:	e64e                	sd	s3,264(sp)
 140:	1a00                	addi	s0,sp,304
    if (argc < 2) {
 142:	4785                	li	a5,1
 144:	08a7d263          	bge	a5,a0,1c8 <main+0x94>
 148:	89aa                	mv	s3,a0
 14a:	84ae                	mv	s1,a1
        fprintf(2, "Usage: xargs command\n");
        exit(1);
    }
    char *command = malloc(strlen(argv[1]) + 1);
 14c:	6588                	ld	a0,8(a1)
 14e:	00000097          	auipc	ra,0x0
 152:	112080e7          	jalr	274(ra) # 260 <strlen>
 156:	2505                	addiw	a0,a0,1
 158:	00000097          	auipc	ra,0x0
 15c:	74c080e7          	jalr	1868(ra) # 8a4 <malloc>
 160:	892a                	mv	s2,a0
    char *args[MAXARG];
    strcpy(command, argv[1]);
 162:	648c                	ld	a1,8(s1)
 164:	00000097          	auipc	ra,0x0
 168:	0b4080e7          	jalr	180(ra) # 218 <strcpy>
    for (int i = 1; i < argc; i++) {
 16c:	00848713          	addi	a4,s1,8
 170:	ed040793          	addi	a5,s0,-304
 174:	ffe9861b          	addiw	a2,s3,-2
 178:	02061693          	slli	a3,a2,0x20
 17c:	01d6d613          	srli	a2,a3,0x1d
 180:	ed840693          	addi	a3,s0,-296
 184:	9636                	add	a2,a2,a3
        args[i - 1] = argv[i];
 186:	6314                	ld	a3,0(a4)
 188:	e394                	sd	a3,0(a5)
    for (int i = 1; i < argc; i++) {
 18a:	0721                	addi	a4,a4,8
 18c:	07a1                	addi	a5,a5,8
 18e:	fec79ce3          	bne	a5,a2,186 <main+0x52>
    }
    int cur_argc = 0;
    while ((cur_argc = readline(args, argc - 1)) != 0) {
 192:	39fd                	addiw	s3,s3,-1
 194:	85ce                	mv	a1,s3
 196:	ed040513          	addi	a0,s0,-304
 19a:	00000097          	auipc	ra,0x0
 19e:	e66080e7          	jalr	-410(ra) # 0 <readline>
 1a2:	c53d                	beqz	a0,210 <main+0xdc>
        args[cur_argc] = 0;
 1a4:	050e                	slli	a0,a0,0x3
 1a6:	fd050793          	addi	a5,a0,-48
 1aa:	00878533          	add	a0,a5,s0
 1ae:	f0053023          	sd	zero,-256(a0)
        if (fork() == 0) {
 1b2:	00000097          	auipc	ra,0x0
 1b6:	2ca080e7          	jalr	714(ra) # 47c <fork>
 1ba:	c50d                	beqz	a0,1e4 <main+0xb0>
            exec(command, args);
            fprintf(2, "xargs: exec %s failed\n", command);
            exit(1);
        }
        wait(0);
 1bc:	4501                	li	a0,0
 1be:	00000097          	auipc	ra,0x0
 1c2:	2ce080e7          	jalr	718(ra) # 48c <wait>
 1c6:	b7f9                	j	194 <main+0x60>
        fprintf(2, "Usage: xargs command\n");
 1c8:	00000597          	auipc	a1,0x0
 1cc:	7e058593          	addi	a1,a1,2016 # 9a8 <malloc+0x104>
 1d0:	4509                	li	a0,2
 1d2:	00000097          	auipc	ra,0x0
 1d6:	5ec080e7          	jalr	1516(ra) # 7be <fprintf>
        exit(1);
 1da:	4505                	li	a0,1
 1dc:	00000097          	auipc	ra,0x0
 1e0:	2a8080e7          	jalr	680(ra) # 484 <exit>
            exec(command, args);
 1e4:	ed040593          	addi	a1,s0,-304
 1e8:	854a                	mv	a0,s2
 1ea:	00000097          	auipc	ra,0x0
 1ee:	2d2080e7          	jalr	722(ra) # 4bc <exec>
            fprintf(2, "xargs: exec %s failed\n", command);
 1f2:	864a                	mv	a2,s2
 1f4:	00000597          	auipc	a1,0x0
 1f8:	7cc58593          	addi	a1,a1,1996 # 9c0 <malloc+0x11c>
 1fc:	4509                	li	a0,2
 1fe:	00000097          	auipc	ra,0x0
 202:	5c0080e7          	jalr	1472(ra) # 7be <fprintf>
            exit(1);
 206:	4505                	li	a0,1
 208:	00000097          	auipc	ra,0x0
 20c:	27c080e7          	jalr	636(ra) # 484 <exit>
    }

    exit(0);
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
 56c:	4d050513          	addi	a0,a0,1232 # a38 <digits>
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
 670:	37470713          	addi	a4,a4,884 # 9e0 <malloc+0x13c>
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
 6fa:	342b8b93          	addi	s7,s7,834 # a38 <digits>
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
 74e:	28e90913          	addi	s2,s2,654 # 9d8 <malloc+0x134>
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
 830:	2247b783          	ld	a5,548(a5) # a50 <freep>
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
 89a:	1af73d23          	sd	a5,442(a4) # a50 <freep>
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
 8cc:	18853503          	ld	a0,392(a0) # a50 <freep>
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
 8f4:	16090913          	addi	s2,s2,352 # a50 <freep>
  if(p == (char*)-1)
 8f8:	5afd                	li	s5,-1
 8fa:	a895                	j	96e <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8fc:	00000797          	auipc	a5,0x0
 900:	15c78793          	addi	a5,a5,348 # a58 <base>
 904:	00000717          	auipc	a4,0x0
 908:	14f73623          	sd	a5,332(a4) # a50 <freep>
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
 930:	12a73223          	sd	a0,292(a4) # a50 <freep>
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
