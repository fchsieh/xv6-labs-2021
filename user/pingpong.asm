
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]) {
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
    int p[2];
    if (pipe(p) < 0) {
   8:	fe840513          	addi	a0,s0,-24
   c:	00000097          	auipc	ra,0x0
  10:	35c080e7          	jalr	860(ra) # 368 <pipe>
  14:	06054363          	bltz	a0,7a <main+0x7a>
        printf("pipe error\n");
        exit(1);
    }
    if (fork() == 0) {
  18:	00000097          	auipc	ra,0x0
  1c:	338080e7          	jalr	824(ra) # 350 <fork>
  20:	e935                	bnez	a0,94 <main+0x94>
        // child
        char buf[1];
        read(p[0], buf, 1);
  22:	4605                	li	a2,1
  24:	fe040593          	addi	a1,s0,-32
  28:	fe842503          	lw	a0,-24(s0)
  2c:	00000097          	auipc	ra,0x0
  30:	344080e7          	jalr	836(ra) # 370 <read>
        close(p[0]);
  34:	fe842503          	lw	a0,-24(s0)
  38:	00000097          	auipc	ra,0x0
  3c:	348080e7          	jalr	840(ra) # 380 <close>
        printf("%d: received ping\n", getpid());
  40:	00000097          	auipc	ra,0x0
  44:	398080e7          	jalr	920(ra) # 3d8 <getpid>
  48:	85aa                	mv	a1,a0
  4a:	00001517          	auipc	a0,0x1
  4e:	82650513          	addi	a0,a0,-2010 # 870 <malloc+0xf8>
  52:	00000097          	auipc	ra,0x0
  56:	66e080e7          	jalr	1646(ra) # 6c0 <printf>
        write(p[1], "2", 1);
  5a:	4605                	li	a2,1
  5c:	00001597          	auipc	a1,0x1
  60:	82c58593          	addi	a1,a1,-2004 # 888 <malloc+0x110>
  64:	fec42503          	lw	a0,-20(s0)
  68:	00000097          	auipc	ra,0x0
  6c:	310080e7          	jalr	784(ra) # 378 <write>
        exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	2e6080e7          	jalr	742(ra) # 358 <exit>
        printf("pipe error\n");
  7a:	00000517          	auipc	a0,0x0
  7e:	7e650513          	addi	a0,a0,2022 # 860 <malloc+0xe8>
  82:	00000097          	auipc	ra,0x0
  86:	63e080e7          	jalr	1598(ra) # 6c0 <printf>
        exit(1);
  8a:	4505                	li	a0,1
  8c:	00000097          	auipc	ra,0x0
  90:	2cc080e7          	jalr	716(ra) # 358 <exit>
    } else {
        // parent
        char buf[1];
        write(p[1], "1", 1);
  94:	4605                	li	a2,1
  96:	00000597          	auipc	a1,0x0
  9a:	7fa58593          	addi	a1,a1,2042 # 890 <malloc+0x118>
  9e:	fec42503          	lw	a0,-20(s0)
  a2:	00000097          	auipc	ra,0x0
  a6:	2d6080e7          	jalr	726(ra) # 378 <write>
        close(p[1]);
  aa:	fec42503          	lw	a0,-20(s0)
  ae:	00000097          	auipc	ra,0x0
  b2:	2d2080e7          	jalr	722(ra) # 380 <close>
        read(p[0], buf, 1);
  b6:	4605                	li	a2,1
  b8:	fe040593          	addi	a1,s0,-32
  bc:	fe842503          	lw	a0,-24(s0)
  c0:	00000097          	auipc	ra,0x0
  c4:	2b0080e7          	jalr	688(ra) # 370 <read>
        printf("%d: received pong\n", getpid());
  c8:	00000097          	auipc	ra,0x0
  cc:	310080e7          	jalr	784(ra) # 3d8 <getpid>
  d0:	85aa                	mv	a1,a0
  d2:	00000517          	auipc	a0,0x0
  d6:	7c650513          	addi	a0,a0,1990 # 898 <malloc+0x120>
  da:	00000097          	auipc	ra,0x0
  de:	5e6080e7          	jalr	1510(ra) # 6c0 <printf>
        exit(0);
  e2:	4501                	li	a0,0
  e4:	00000097          	auipc	ra,0x0
  e8:	274080e7          	jalr	628(ra) # 358 <exit>

00000000000000ec <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f2:	87aa                	mv	a5,a0
  f4:	0585                	addi	a1,a1,1
  f6:	0785                	addi	a5,a5,1
  f8:	fff5c703          	lbu	a4,-1(a1)
  fc:	fee78fa3          	sb	a4,-1(a5)
 100:	fb75                	bnez	a4,f4 <strcpy+0x8>
    ;
  return os;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret

0000000000000108 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cb91                	beqz	a5,126 <strcmp+0x1e>
 114:	0005c703          	lbu	a4,0(a1)
 118:	00f71763          	bne	a4,a5,126 <strcmp+0x1e>
    p++, q++;
 11c:	0505                	addi	a0,a0,1
 11e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 120:	00054783          	lbu	a5,0(a0)
 124:	fbe5                	bnez	a5,114 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 126:	0005c503          	lbu	a0,0(a1)
}
 12a:	40a7853b          	subw	a0,a5,a0
 12e:	6422                	ld	s0,8(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <strlen>:

uint
strlen(const char *s)
{
 134:	1141                	addi	sp,sp,-16
 136:	e422                	sd	s0,8(sp)
 138:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	cf91                	beqz	a5,15a <strlen+0x26>
 140:	0505                	addi	a0,a0,1
 142:	87aa                	mv	a5,a0
 144:	86be                	mv	a3,a5
 146:	0785                	addi	a5,a5,1
 148:	fff7c703          	lbu	a4,-1(a5)
 14c:	ff65                	bnez	a4,144 <strlen+0x10>
 14e:	40a6853b          	subw	a0,a3,a0
 152:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 154:	6422                	ld	s0,8(sp)
 156:	0141                	addi	sp,sp,16
 158:	8082                	ret
  for(n = 0; s[n]; n++)
 15a:	4501                	li	a0,0
 15c:	bfe5                	j	154 <strlen+0x20>

000000000000015e <memset>:

void*
memset(void *dst, int c, uint n)
{
 15e:	1141                	addi	sp,sp,-16
 160:	e422                	sd	s0,8(sp)
 162:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 164:	ca19                	beqz	a2,17a <memset+0x1c>
 166:	87aa                	mv	a5,a0
 168:	1602                	slli	a2,a2,0x20
 16a:	9201                	srli	a2,a2,0x20
 16c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 170:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 174:	0785                	addi	a5,a5,1
 176:	fee79de3          	bne	a5,a4,170 <memset+0x12>
  }
  return dst;
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret

0000000000000180 <strchr>:

char*
strchr(const char *s, char c)
{
 180:	1141                	addi	sp,sp,-16
 182:	e422                	sd	s0,8(sp)
 184:	0800                	addi	s0,sp,16
  for(; *s; s++)
 186:	00054783          	lbu	a5,0(a0)
 18a:	cb99                	beqz	a5,1a0 <strchr+0x20>
    if(*s == c)
 18c:	00f58763          	beq	a1,a5,19a <strchr+0x1a>
  for(; *s; s++)
 190:	0505                	addi	a0,a0,1
 192:	00054783          	lbu	a5,0(a0)
 196:	fbfd                	bnez	a5,18c <strchr+0xc>
      return (char*)s;
  return 0;
 198:	4501                	li	a0,0
}
 19a:	6422                	ld	s0,8(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret
  return 0;
 1a0:	4501                	li	a0,0
 1a2:	bfe5                	j	19a <strchr+0x1a>

00000000000001a4 <gets>:

char*
gets(char *buf, int max)
{
 1a4:	711d                	addi	sp,sp,-96
 1a6:	ec86                	sd	ra,88(sp)
 1a8:	e8a2                	sd	s0,80(sp)
 1aa:	e4a6                	sd	s1,72(sp)
 1ac:	e0ca                	sd	s2,64(sp)
 1ae:	fc4e                	sd	s3,56(sp)
 1b0:	f852                	sd	s4,48(sp)
 1b2:	f456                	sd	s5,40(sp)
 1b4:	f05a                	sd	s6,32(sp)
 1b6:	ec5e                	sd	s7,24(sp)
 1b8:	1080                	addi	s0,sp,96
 1ba:	8baa                	mv	s7,a0
 1bc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1be:	892a                	mv	s2,a0
 1c0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c2:	4aa9                	li	s5,10
 1c4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c6:	89a6                	mv	s3,s1
 1c8:	2485                	addiw	s1,s1,1
 1ca:	0344d863          	bge	s1,s4,1fa <gets+0x56>
    cc = read(0, &c, 1);
 1ce:	4605                	li	a2,1
 1d0:	faf40593          	addi	a1,s0,-81
 1d4:	4501                	li	a0,0
 1d6:	00000097          	auipc	ra,0x0
 1da:	19a080e7          	jalr	410(ra) # 370 <read>
    if(cc < 1)
 1de:	00a05e63          	blez	a0,1fa <gets+0x56>
    buf[i++] = c;
 1e2:	faf44783          	lbu	a5,-81(s0)
 1e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ea:	01578763          	beq	a5,s5,1f8 <gets+0x54>
 1ee:	0905                	addi	s2,s2,1
 1f0:	fd679be3          	bne	a5,s6,1c6 <gets+0x22>
  for(i=0; i+1 < max; ){
 1f4:	89a6                	mv	s3,s1
 1f6:	a011                	j	1fa <gets+0x56>
 1f8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1fa:	99de                	add	s3,s3,s7
 1fc:	00098023          	sb	zero,0(s3)
  return buf;
}
 200:	855e                	mv	a0,s7
 202:	60e6                	ld	ra,88(sp)
 204:	6446                	ld	s0,80(sp)
 206:	64a6                	ld	s1,72(sp)
 208:	6906                	ld	s2,64(sp)
 20a:	79e2                	ld	s3,56(sp)
 20c:	7a42                	ld	s4,48(sp)
 20e:	7aa2                	ld	s5,40(sp)
 210:	7b02                	ld	s6,32(sp)
 212:	6be2                	ld	s7,24(sp)
 214:	6125                	addi	sp,sp,96
 216:	8082                	ret

0000000000000218 <stat>:

int
stat(const char *n, struct stat *st)
{
 218:	1101                	addi	sp,sp,-32
 21a:	ec06                	sd	ra,24(sp)
 21c:	e822                	sd	s0,16(sp)
 21e:	e426                	sd	s1,8(sp)
 220:	e04a                	sd	s2,0(sp)
 222:	1000                	addi	s0,sp,32
 224:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	4581                	li	a1,0
 228:	00000097          	auipc	ra,0x0
 22c:	170080e7          	jalr	368(ra) # 398 <open>
  if(fd < 0)
 230:	02054563          	bltz	a0,25a <stat+0x42>
 234:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 236:	85ca                	mv	a1,s2
 238:	00000097          	auipc	ra,0x0
 23c:	178080e7          	jalr	376(ra) # 3b0 <fstat>
 240:	892a                	mv	s2,a0
  close(fd);
 242:	8526                	mv	a0,s1
 244:	00000097          	auipc	ra,0x0
 248:	13c080e7          	jalr	316(ra) # 380 <close>
  return r;
}
 24c:	854a                	mv	a0,s2
 24e:	60e2                	ld	ra,24(sp)
 250:	6442                	ld	s0,16(sp)
 252:	64a2                	ld	s1,8(sp)
 254:	6902                	ld	s2,0(sp)
 256:	6105                	addi	sp,sp,32
 258:	8082                	ret
    return -1;
 25a:	597d                	li	s2,-1
 25c:	bfc5                	j	24c <stat+0x34>

000000000000025e <atoi>:

int
atoi(const char *s)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 264:	00054683          	lbu	a3,0(a0)
 268:	fd06879b          	addiw	a5,a3,-48
 26c:	0ff7f793          	zext.b	a5,a5
 270:	4625                	li	a2,9
 272:	02f66863          	bltu	a2,a5,2a2 <atoi+0x44>
 276:	872a                	mv	a4,a0
  n = 0;
 278:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 27a:	0705                	addi	a4,a4,1
 27c:	0025179b          	slliw	a5,a0,0x2
 280:	9fa9                	addw	a5,a5,a0
 282:	0017979b          	slliw	a5,a5,0x1
 286:	9fb5                	addw	a5,a5,a3
 288:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28c:	00074683          	lbu	a3,0(a4)
 290:	fd06879b          	addiw	a5,a3,-48
 294:	0ff7f793          	zext.b	a5,a5
 298:	fef671e3          	bgeu	a2,a5,27a <atoi+0x1c>
  return n;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
  n = 0;
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <atoi+0x3e>

00000000000002a6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ac:	02b57463          	bgeu	a0,a1,2d4 <memmove+0x2e>
    while(n-- > 0)
 2b0:	00c05f63          	blez	a2,2ce <memmove+0x28>
 2b4:	1602                	slli	a2,a2,0x20
 2b6:	9201                	srli	a2,a2,0x20
 2b8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2bc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2be:	0585                	addi	a1,a1,1
 2c0:	0705                	addi	a4,a4,1
 2c2:	fff5c683          	lbu	a3,-1(a1)
 2c6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ca:	fee79ae3          	bne	a5,a4,2be <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret
    dst += n;
 2d4:	00c50733          	add	a4,a0,a2
    src += n;
 2d8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2da:	fec05ae3          	blez	a2,2ce <memmove+0x28>
 2de:	fff6079b          	addiw	a5,a2,-1
 2e2:	1782                	slli	a5,a5,0x20
 2e4:	9381                	srli	a5,a5,0x20
 2e6:	fff7c793          	not	a5,a5
 2ea:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ec:	15fd                	addi	a1,a1,-1
 2ee:	177d                	addi	a4,a4,-1
 2f0:	0005c683          	lbu	a3,0(a1)
 2f4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f8:	fee79ae3          	bne	a5,a4,2ec <memmove+0x46>
 2fc:	bfc9                	j	2ce <memmove+0x28>

00000000000002fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 304:	ca05                	beqz	a2,334 <memcmp+0x36>
 306:	fff6069b          	addiw	a3,a2,-1
 30a:	1682                	slli	a3,a3,0x20
 30c:	9281                	srli	a3,a3,0x20
 30e:	0685                	addi	a3,a3,1
 310:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 312:	00054783          	lbu	a5,0(a0)
 316:	0005c703          	lbu	a4,0(a1)
 31a:	00e79863          	bne	a5,a4,32a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 31e:	0505                	addi	a0,a0,1
    p2++;
 320:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 322:	fed518e3          	bne	a0,a3,312 <memcmp+0x14>
  }
  return 0;
 326:	4501                	li	a0,0
 328:	a019                	j	32e <memcmp+0x30>
      return *p1 - *p2;
 32a:	40e7853b          	subw	a0,a5,a4
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  return 0;
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <memcmp+0x30>

0000000000000338 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 340:	00000097          	auipc	ra,0x0
 344:	f66080e7          	jalr	-154(ra) # 2a6 <memmove>
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 350:	4885                	li	a7,1
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <exit>:
.global exit
exit:
 li a7, SYS_exit
 358:	4889                	li	a7,2
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <wait>:
.global wait
wait:
 li a7, SYS_wait
 360:	488d                	li	a7,3
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 368:	4891                	li	a7,4
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <read>:
.global read
read:
 li a7, SYS_read
 370:	4895                	li	a7,5
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <write>:
.global write
write:
 li a7, SYS_write
 378:	48c1                	li	a7,16
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <close>:
.global close
close:
 li a7, SYS_close
 380:	48d5                	li	a7,21
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <kill>:
.global kill
kill:
 li a7, SYS_kill
 388:	4899                	li	a7,6
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <exec>:
.global exec
exec:
 li a7, SYS_exec
 390:	489d                	li	a7,7
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <open>:
.global open
open:
 li a7, SYS_open
 398:	48bd                	li	a7,15
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a0:	48c5                	li	a7,17
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a8:	48c9                	li	a7,18
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b0:	48a1                	li	a7,8
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <link>:
.global link
link:
 li a7, SYS_link
 3b8:	48cd                	li	a7,19
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c0:	48d1                	li	a7,20
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c8:	48a5                	li	a7,9
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d0:	48a9                	li	a7,10
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d8:	48ad                	li	a7,11
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e0:	48b1                	li	a7,12
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3e8:	48b5                	li	a7,13
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f0:	48b9                	li	a7,14
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3f8:	1101                	addi	sp,sp,-32
 3fa:	ec06                	sd	ra,24(sp)
 3fc:	e822                	sd	s0,16(sp)
 3fe:	1000                	addi	s0,sp,32
 400:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 404:	4605                	li	a2,1
 406:	fef40593          	addi	a1,s0,-17
 40a:	00000097          	auipc	ra,0x0
 40e:	f6e080e7          	jalr	-146(ra) # 378 <write>
}
 412:	60e2                	ld	ra,24(sp)
 414:	6442                	ld	s0,16(sp)
 416:	6105                	addi	sp,sp,32
 418:	8082                	ret

000000000000041a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41a:	7139                	addi	sp,sp,-64
 41c:	fc06                	sd	ra,56(sp)
 41e:	f822                	sd	s0,48(sp)
 420:	f426                	sd	s1,40(sp)
 422:	f04a                	sd	s2,32(sp)
 424:	ec4e                	sd	s3,24(sp)
 426:	0080                	addi	s0,sp,64
 428:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42a:	c299                	beqz	a3,430 <printint+0x16>
 42c:	0805c963          	bltz	a1,4be <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 430:	2581                	sext.w	a1,a1
  neg = 0;
 432:	4881                	li	a7,0
 434:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 438:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 43a:	2601                	sext.w	a2,a2
 43c:	00000517          	auipc	a0,0x0
 440:	4d450513          	addi	a0,a0,1236 # 910 <digits>
 444:	883a                	mv	a6,a4
 446:	2705                	addiw	a4,a4,1
 448:	02c5f7bb          	remuw	a5,a1,a2
 44c:	1782                	slli	a5,a5,0x20
 44e:	9381                	srli	a5,a5,0x20
 450:	97aa                	add	a5,a5,a0
 452:	0007c783          	lbu	a5,0(a5)
 456:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 45a:	0005879b          	sext.w	a5,a1
 45e:	02c5d5bb          	divuw	a1,a1,a2
 462:	0685                	addi	a3,a3,1
 464:	fec7f0e3          	bgeu	a5,a2,444 <printint+0x2a>
  if(neg)
 468:	00088c63          	beqz	a7,480 <printint+0x66>
    buf[i++] = '-';
 46c:	fd070793          	addi	a5,a4,-48
 470:	00878733          	add	a4,a5,s0
 474:	02d00793          	li	a5,45
 478:	fef70823          	sb	a5,-16(a4)
 47c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 480:	02e05863          	blez	a4,4b0 <printint+0x96>
 484:	fc040793          	addi	a5,s0,-64
 488:	00e78933          	add	s2,a5,a4
 48c:	fff78993          	addi	s3,a5,-1
 490:	99ba                	add	s3,s3,a4
 492:	377d                	addiw	a4,a4,-1
 494:	1702                	slli	a4,a4,0x20
 496:	9301                	srli	a4,a4,0x20
 498:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 49c:	fff94583          	lbu	a1,-1(s2)
 4a0:	8526                	mv	a0,s1
 4a2:	00000097          	auipc	ra,0x0
 4a6:	f56080e7          	jalr	-170(ra) # 3f8 <putc>
  while(--i >= 0)
 4aa:	197d                	addi	s2,s2,-1
 4ac:	ff3918e3          	bne	s2,s3,49c <printint+0x82>
}
 4b0:	70e2                	ld	ra,56(sp)
 4b2:	7442                	ld	s0,48(sp)
 4b4:	74a2                	ld	s1,40(sp)
 4b6:	7902                	ld	s2,32(sp)
 4b8:	69e2                	ld	s3,24(sp)
 4ba:	6121                	addi	sp,sp,64
 4bc:	8082                	ret
    x = -xx;
 4be:	40b005bb          	negw	a1,a1
    neg = 1;
 4c2:	4885                	li	a7,1
    x = -xx;
 4c4:	bf85                	j	434 <printint+0x1a>

00000000000004c6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c6:	715d                	addi	sp,sp,-80
 4c8:	e486                	sd	ra,72(sp)
 4ca:	e0a2                	sd	s0,64(sp)
 4cc:	fc26                	sd	s1,56(sp)
 4ce:	f84a                	sd	s2,48(sp)
 4d0:	f44e                	sd	s3,40(sp)
 4d2:	f052                	sd	s4,32(sp)
 4d4:	ec56                	sd	s5,24(sp)
 4d6:	e85a                	sd	s6,16(sp)
 4d8:	e45e                	sd	s7,8(sp)
 4da:	e062                	sd	s8,0(sp)
 4dc:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4de:	0005c903          	lbu	s2,0(a1)
 4e2:	18090c63          	beqz	s2,67a <vprintf+0x1b4>
 4e6:	8aaa                	mv	s5,a0
 4e8:	8bb2                	mv	s7,a2
 4ea:	00158493          	addi	s1,a1,1
  state = 0;
 4ee:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f0:	02500a13          	li	s4,37
 4f4:	4b55                	li	s6,21
 4f6:	a839                	j	514 <vprintf+0x4e>
        putc(fd, c);
 4f8:	85ca                	mv	a1,s2
 4fa:	8556                	mv	a0,s5
 4fc:	00000097          	auipc	ra,0x0
 500:	efc080e7          	jalr	-260(ra) # 3f8 <putc>
 504:	a019                	j	50a <vprintf+0x44>
    } else if(state == '%'){
 506:	01498d63          	beq	s3,s4,520 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 50a:	0485                	addi	s1,s1,1
 50c:	fff4c903          	lbu	s2,-1(s1)
 510:	16090563          	beqz	s2,67a <vprintf+0x1b4>
    if(state == 0){
 514:	fe0999e3          	bnez	s3,506 <vprintf+0x40>
      if(c == '%'){
 518:	ff4910e3          	bne	s2,s4,4f8 <vprintf+0x32>
        state = '%';
 51c:	89d2                	mv	s3,s4
 51e:	b7f5                	j	50a <vprintf+0x44>
      if(c == 'd'){
 520:	13490263          	beq	s2,s4,644 <vprintf+0x17e>
 524:	f9d9079b          	addiw	a5,s2,-99
 528:	0ff7f793          	zext.b	a5,a5
 52c:	12fb6563          	bltu	s6,a5,656 <vprintf+0x190>
 530:	f9d9079b          	addiw	a5,s2,-99
 534:	0ff7f713          	zext.b	a4,a5
 538:	10eb6f63          	bltu	s6,a4,656 <vprintf+0x190>
 53c:	00271793          	slli	a5,a4,0x2
 540:	00000717          	auipc	a4,0x0
 544:	37870713          	addi	a4,a4,888 # 8b8 <malloc+0x140>
 548:	97ba                	add	a5,a5,a4
 54a:	439c                	lw	a5,0(a5)
 54c:	97ba                	add	a5,a5,a4
 54e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 550:	008b8913          	addi	s2,s7,8
 554:	4685                	li	a3,1
 556:	4629                	li	a2,10
 558:	000ba583          	lw	a1,0(s7)
 55c:	8556                	mv	a0,s5
 55e:	00000097          	auipc	ra,0x0
 562:	ebc080e7          	jalr	-324(ra) # 41a <printint>
 566:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 568:	4981                	li	s3,0
 56a:	b745                	j	50a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 56c:	008b8913          	addi	s2,s7,8
 570:	4681                	li	a3,0
 572:	4629                	li	a2,10
 574:	000ba583          	lw	a1,0(s7)
 578:	8556                	mv	a0,s5
 57a:	00000097          	auipc	ra,0x0
 57e:	ea0080e7          	jalr	-352(ra) # 41a <printint>
 582:	8bca                	mv	s7,s2
      state = 0;
 584:	4981                	li	s3,0
 586:	b751                	j	50a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 588:	008b8913          	addi	s2,s7,8
 58c:	4681                	li	a3,0
 58e:	4641                	li	a2,16
 590:	000ba583          	lw	a1,0(s7)
 594:	8556                	mv	a0,s5
 596:	00000097          	auipc	ra,0x0
 59a:	e84080e7          	jalr	-380(ra) # 41a <printint>
 59e:	8bca                	mv	s7,s2
      state = 0;
 5a0:	4981                	li	s3,0
 5a2:	b7a5                	j	50a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5a4:	008b8c13          	addi	s8,s7,8
 5a8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5ac:	03000593          	li	a1,48
 5b0:	8556                	mv	a0,s5
 5b2:	00000097          	auipc	ra,0x0
 5b6:	e46080e7          	jalr	-442(ra) # 3f8 <putc>
  putc(fd, 'x');
 5ba:	07800593          	li	a1,120
 5be:	8556                	mv	a0,s5
 5c0:	00000097          	auipc	ra,0x0
 5c4:	e38080e7          	jalr	-456(ra) # 3f8 <putc>
 5c8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ca:	00000b97          	auipc	s7,0x0
 5ce:	346b8b93          	addi	s7,s7,838 # 910 <digits>
 5d2:	03c9d793          	srli	a5,s3,0x3c
 5d6:	97de                	add	a5,a5,s7
 5d8:	0007c583          	lbu	a1,0(a5)
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	e1a080e7          	jalr	-486(ra) # 3f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5e6:	0992                	slli	s3,s3,0x4
 5e8:	397d                	addiw	s2,s2,-1
 5ea:	fe0914e3          	bnez	s2,5d2 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5ee:	8be2                	mv	s7,s8
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	bf21                	j	50a <vprintf+0x44>
        s = va_arg(ap, char*);
 5f4:	008b8993          	addi	s3,s7,8
 5f8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5fc:	02090163          	beqz	s2,61e <vprintf+0x158>
        while(*s != 0){
 600:	00094583          	lbu	a1,0(s2)
 604:	c9a5                	beqz	a1,674 <vprintf+0x1ae>
          putc(fd, *s);
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	df0080e7          	jalr	-528(ra) # 3f8 <putc>
          s++;
 610:	0905                	addi	s2,s2,1
        while(*s != 0){
 612:	00094583          	lbu	a1,0(s2)
 616:	f9e5                	bnez	a1,606 <vprintf+0x140>
        s = va_arg(ap, char*);
 618:	8bce                	mv	s7,s3
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b5fd                	j	50a <vprintf+0x44>
          s = "(null)";
 61e:	00000917          	auipc	s2,0x0
 622:	29290913          	addi	s2,s2,658 # 8b0 <malloc+0x138>
        while(*s != 0){
 626:	02800593          	li	a1,40
 62a:	bff1                	j	606 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 62c:	008b8913          	addi	s2,s7,8
 630:	000bc583          	lbu	a1,0(s7)
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	dc2080e7          	jalr	-574(ra) # 3f8 <putc>
 63e:	8bca                	mv	s7,s2
      state = 0;
 640:	4981                	li	s3,0
 642:	b5e1                	j	50a <vprintf+0x44>
        putc(fd, c);
 644:	02500593          	li	a1,37
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	dae080e7          	jalr	-594(ra) # 3f8 <putc>
      state = 0;
 652:	4981                	li	s3,0
 654:	bd5d                	j	50a <vprintf+0x44>
        putc(fd, '%');
 656:	02500593          	li	a1,37
 65a:	8556                	mv	a0,s5
 65c:	00000097          	auipc	ra,0x0
 660:	d9c080e7          	jalr	-612(ra) # 3f8 <putc>
        putc(fd, c);
 664:	85ca                	mv	a1,s2
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	d90080e7          	jalr	-624(ra) # 3f8 <putc>
      state = 0;
 670:	4981                	li	s3,0
 672:	bd61                	j	50a <vprintf+0x44>
        s = va_arg(ap, char*);
 674:	8bce                	mv	s7,s3
      state = 0;
 676:	4981                	li	s3,0
 678:	bd49                	j	50a <vprintf+0x44>
    }
  }
}
 67a:	60a6                	ld	ra,72(sp)
 67c:	6406                	ld	s0,64(sp)
 67e:	74e2                	ld	s1,56(sp)
 680:	7942                	ld	s2,48(sp)
 682:	79a2                	ld	s3,40(sp)
 684:	7a02                	ld	s4,32(sp)
 686:	6ae2                	ld	s5,24(sp)
 688:	6b42                	ld	s6,16(sp)
 68a:	6ba2                	ld	s7,8(sp)
 68c:	6c02                	ld	s8,0(sp)
 68e:	6161                	addi	sp,sp,80
 690:	8082                	ret

0000000000000692 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 692:	715d                	addi	sp,sp,-80
 694:	ec06                	sd	ra,24(sp)
 696:	e822                	sd	s0,16(sp)
 698:	1000                	addi	s0,sp,32
 69a:	e010                	sd	a2,0(s0)
 69c:	e414                	sd	a3,8(s0)
 69e:	e818                	sd	a4,16(s0)
 6a0:	ec1c                	sd	a5,24(s0)
 6a2:	03043023          	sd	a6,32(s0)
 6a6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6aa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6ae:	8622                	mv	a2,s0
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e16080e7          	jalr	-490(ra) # 4c6 <vprintf>
}
 6b8:	60e2                	ld	ra,24(sp)
 6ba:	6442                	ld	s0,16(sp)
 6bc:	6161                	addi	sp,sp,80
 6be:	8082                	ret

00000000000006c0 <printf>:

void
printf(const char *fmt, ...)
{
 6c0:	711d                	addi	sp,sp,-96
 6c2:	ec06                	sd	ra,24(sp)
 6c4:	e822                	sd	s0,16(sp)
 6c6:	1000                	addi	s0,sp,32
 6c8:	e40c                	sd	a1,8(s0)
 6ca:	e810                	sd	a2,16(s0)
 6cc:	ec14                	sd	a3,24(s0)
 6ce:	f018                	sd	a4,32(s0)
 6d0:	f41c                	sd	a5,40(s0)
 6d2:	03043823          	sd	a6,48(s0)
 6d6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6da:	00840613          	addi	a2,s0,8
 6de:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6e2:	85aa                	mv	a1,a0
 6e4:	4505                	li	a0,1
 6e6:	00000097          	auipc	ra,0x0
 6ea:	de0080e7          	jalr	-544(ra) # 4c6 <vprintf>
}
 6ee:	60e2                	ld	ra,24(sp)
 6f0:	6442                	ld	s0,16(sp)
 6f2:	6125                	addi	sp,sp,96
 6f4:	8082                	ret

00000000000006f6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f6:	1141                	addi	sp,sp,-16
 6f8:	e422                	sd	s0,8(sp)
 6fa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6fc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 700:	00000797          	auipc	a5,0x0
 704:	2287b783          	ld	a5,552(a5) # 928 <freep>
 708:	a02d                	j	732 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 70a:	4618                	lw	a4,8(a2)
 70c:	9f2d                	addw	a4,a4,a1
 70e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 712:	6398                	ld	a4,0(a5)
 714:	6310                	ld	a2,0(a4)
 716:	a83d                	j	754 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 718:	ff852703          	lw	a4,-8(a0)
 71c:	9f31                	addw	a4,a4,a2
 71e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 720:	ff053683          	ld	a3,-16(a0)
 724:	a091                	j	768 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 726:	6398                	ld	a4,0(a5)
 728:	00e7e463          	bltu	a5,a4,730 <free+0x3a>
 72c:	00e6ea63          	bltu	a3,a4,740 <free+0x4a>
{
 730:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 732:	fed7fae3          	bgeu	a5,a3,726 <free+0x30>
 736:	6398                	ld	a4,0(a5)
 738:	00e6e463          	bltu	a3,a4,740 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73c:	fee7eae3          	bltu	a5,a4,730 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 740:	ff852583          	lw	a1,-8(a0)
 744:	6390                	ld	a2,0(a5)
 746:	02059813          	slli	a6,a1,0x20
 74a:	01c85713          	srli	a4,a6,0x1c
 74e:	9736                	add	a4,a4,a3
 750:	fae60de3          	beq	a2,a4,70a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 754:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 758:	4790                	lw	a2,8(a5)
 75a:	02061593          	slli	a1,a2,0x20
 75e:	01c5d713          	srli	a4,a1,0x1c
 762:	973e                	add	a4,a4,a5
 764:	fae68ae3          	beq	a3,a4,718 <free+0x22>
    p->s.ptr = bp->s.ptr;
 768:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 76a:	00000717          	auipc	a4,0x0
 76e:	1af73f23          	sd	a5,446(a4) # 928 <freep>
}
 772:	6422                	ld	s0,8(sp)
 774:	0141                	addi	sp,sp,16
 776:	8082                	ret

0000000000000778 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 778:	7139                	addi	sp,sp,-64
 77a:	fc06                	sd	ra,56(sp)
 77c:	f822                	sd	s0,48(sp)
 77e:	f426                	sd	s1,40(sp)
 780:	f04a                	sd	s2,32(sp)
 782:	ec4e                	sd	s3,24(sp)
 784:	e852                	sd	s4,16(sp)
 786:	e456                	sd	s5,8(sp)
 788:	e05a                	sd	s6,0(sp)
 78a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78c:	02051493          	slli	s1,a0,0x20
 790:	9081                	srli	s1,s1,0x20
 792:	04bd                	addi	s1,s1,15
 794:	8091                	srli	s1,s1,0x4
 796:	0014899b          	addiw	s3,s1,1
 79a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 79c:	00000517          	auipc	a0,0x0
 7a0:	18c53503          	ld	a0,396(a0) # 928 <freep>
 7a4:	c515                	beqz	a0,7d0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a8:	4798                	lw	a4,8(a5)
 7aa:	02977f63          	bgeu	a4,s1,7e8 <malloc+0x70>
  if(nu < 4096)
 7ae:	8a4e                	mv	s4,s3
 7b0:	0009871b          	sext.w	a4,s3
 7b4:	6685                	lui	a3,0x1
 7b6:	00d77363          	bgeu	a4,a3,7bc <malloc+0x44>
 7ba:	6a05                	lui	s4,0x1
 7bc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7c0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c4:	00000917          	auipc	s2,0x0
 7c8:	16490913          	addi	s2,s2,356 # 928 <freep>
  if(p == (char*)-1)
 7cc:	5afd                	li	s5,-1
 7ce:	a895                	j	842 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7d0:	00000797          	auipc	a5,0x0
 7d4:	16078793          	addi	a5,a5,352 # 930 <base>
 7d8:	00000717          	auipc	a4,0x0
 7dc:	14f73823          	sd	a5,336(a4) # 928 <freep>
 7e0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7e2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7e6:	b7e1                	j	7ae <malloc+0x36>
      if(p->s.size == nunits)
 7e8:	02e48c63          	beq	s1,a4,820 <malloc+0xa8>
        p->s.size -= nunits;
 7ec:	4137073b          	subw	a4,a4,s3
 7f0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7f2:	02071693          	slli	a3,a4,0x20
 7f6:	01c6d713          	srli	a4,a3,0x1c
 7fa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7fc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 800:	00000717          	auipc	a4,0x0
 804:	12a73423          	sd	a0,296(a4) # 928 <freep>
      return (void*)(p + 1);
 808:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 80c:	70e2                	ld	ra,56(sp)
 80e:	7442                	ld	s0,48(sp)
 810:	74a2                	ld	s1,40(sp)
 812:	7902                	ld	s2,32(sp)
 814:	69e2                	ld	s3,24(sp)
 816:	6a42                	ld	s4,16(sp)
 818:	6aa2                	ld	s5,8(sp)
 81a:	6b02                	ld	s6,0(sp)
 81c:	6121                	addi	sp,sp,64
 81e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 820:	6398                	ld	a4,0(a5)
 822:	e118                	sd	a4,0(a0)
 824:	bff1                	j	800 <malloc+0x88>
  hp->s.size = nu;
 826:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 82a:	0541                	addi	a0,a0,16
 82c:	00000097          	auipc	ra,0x0
 830:	eca080e7          	jalr	-310(ra) # 6f6 <free>
  return freep;
 834:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 838:	d971                	beqz	a0,80c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 83c:	4798                	lw	a4,8(a5)
 83e:	fa9775e3          	bgeu	a4,s1,7e8 <malloc+0x70>
    if(p == freep)
 842:	00093703          	ld	a4,0(s2)
 846:	853e                	mv	a0,a5
 848:	fef719e3          	bne	a4,a5,83a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 84c:	8552                	mv	a0,s4
 84e:	00000097          	auipc	ra,0x0
 852:	b92080e7          	jalr	-1134(ra) # 3e0 <sbrk>
  if(p == (char*)-1)
 856:	fd5518e3          	bne	a0,s5,826 <malloc+0xae>
        return 0;
 85a:	4501                	li	a0,0
 85c:	bf45                	j	80c <malloc+0x94>
