
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <worker>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void worker(int p[2]) {
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	84aa                	mv	s1,a0
    int prime;
    close(p[1]);
   c:	4148                	lw	a0,4(a0)
   e:	00000097          	auipc	ra,0x0
  12:	3d0080e7          	jalr	976(ra) # 3de <close>
    // terminate if no data in pipe
    if (read(p[0], &prime, sizeof(int)) == 0) {
  16:	4611                	li	a2,4
  18:	fdc40593          	addi	a1,s0,-36
  1c:	4088                	lw	a0,0(s1)
  1e:	00000097          	auipc	ra,0x0
  22:	3b0080e7          	jalr	944(ra) # 3ce <read>
  26:	e919                	bnez	a0,3c <worker+0x3c>
        close(p[0]);
  28:	4088                	lw	a0,0(s1)
  2a:	00000097          	auipc	ra,0x0
  2e:	3b4080e7          	jalr	948(ra) # 3de <close>
        exit(0);
  32:	4501                	li	a0,0
  34:	00000097          	auipc	ra,0x0
  38:	382080e7          	jalr	898(ra) # 3b6 <exit>
    }
    printf("prime %d\n", prime);
  3c:	fdc42583          	lw	a1,-36(s0)
  40:	00001517          	auipc	a0,0x1
  44:	88050513          	addi	a0,a0,-1920 # 8c0 <malloc+0xea>
  48:	00000097          	auipc	ra,0x0
  4c:	6d6080e7          	jalr	1750(ra) # 71e <printf>
    int next_p[2];
    pipe(next_p);
  50:	fd040513          	addi	a0,s0,-48
  54:	00000097          	auipc	ra,0x0
  58:	372080e7          	jalr	882(ra) # 3c6 <pipe>
    if (fork() == 0) {
  5c:	00000097          	auipc	ra,0x0
  60:	352080e7          	jalr	850(ra) # 3ae <fork>
  64:	c91d                	beqz	a0,9a <worker+0x9a>
        worker(next_p);
    } else {
        int n;
        // try to read from pipe
        while (read(p[0], &n, sizeof(int)) != 0) {
  66:	4611                	li	a2,4
  68:	fcc40593          	addi	a1,s0,-52
  6c:	4088                	lw	a0,0(s1)
  6e:	00000097          	auipc	ra,0x0
  72:	360080e7          	jalr	864(ra) # 3ce <read>
  76:	c905                	beqz	a0,a6 <worker+0xa6>
            if (n % prime != 0) {  // pass to next worker if it is a prime
  78:	fcc42783          	lw	a5,-52(s0)
  7c:	fdc42703          	lw	a4,-36(s0)
  80:	02e7e7bb          	remw	a5,a5,a4
  84:	d3ed                	beqz	a5,66 <worker+0x66>
                write(next_p[1], &n, sizeof(int));
  86:	4611                	li	a2,4
  88:	fcc40593          	addi	a1,s0,-52
  8c:	fd442503          	lw	a0,-44(s0)
  90:	00000097          	auipc	ra,0x0
  94:	346080e7          	jalr	838(ra) # 3d6 <write>
  98:	b7f9                	j	66 <worker+0x66>
        worker(next_p);
  9a:	fd040513          	addi	a0,s0,-48
  9e:	00000097          	auipc	ra,0x0
  a2:	f62080e7          	jalr	-158(ra) # 0 <worker>
            }
        }
        // end of current sieve
        close(p[0]);
  a6:	4088                	lw	a0,0(s1)
  a8:	00000097          	auipc	ra,0x0
  ac:	336080e7          	jalr	822(ra) # 3de <close>
        close(next_p[1]);
  b0:	fd442503          	lw	a0,-44(s0)
  b4:	00000097          	auipc	ra,0x0
  b8:	32a080e7          	jalr	810(ra) # 3de <close>
        wait(0);
  bc:	4501                	li	a0,0
  be:	00000097          	auipc	ra,0x0
  c2:	300080e7          	jalr	768(ra) # 3be <wait>
    }
    exit(0);
  c6:	4501                	li	a0,0
  c8:	00000097          	auipc	ra,0x0
  cc:	2ee080e7          	jalr	750(ra) # 3b6 <exit>

00000000000000d0 <main>:
}

int main(int argc, char const *argv[]) {
  d0:	7179                	addi	sp,sp,-48
  d2:	f406                	sd	ra,40(sp)
  d4:	f022                	sd	s0,32(sp)
  d6:	ec26                	sd	s1,24(sp)
  d8:	1800                	addi	s0,sp,48
    int p[2];
    pipe(p);
  da:	fd840513          	addi	a0,s0,-40
  de:	00000097          	auipc	ra,0x0
  e2:	2e8080e7          	jalr	744(ra) # 3c6 <pipe>
    if (fork() == 0) {
  e6:	00000097          	auipc	ra,0x0
  ea:	2c8080e7          	jalr	712(ra) # 3ae <fork>
  ee:	c921                	beqz	a0,13e <main+0x6e>
        worker(p);
    } else {
        // wait for last worker to finish
        for (int i = 2; i <= 35; i++) {
  f0:	4789                	li	a5,2
  f2:	fcf42a23          	sw	a5,-44(s0)
  f6:	02300493          	li	s1,35
            write(p[1], &i, sizeof(i));
  fa:	4611                	li	a2,4
  fc:	fd440593          	addi	a1,s0,-44
 100:	fdc42503          	lw	a0,-36(s0)
 104:	00000097          	auipc	ra,0x0
 108:	2d2080e7          	jalr	722(ra) # 3d6 <write>
        for (int i = 2; i <= 35; i++) {
 10c:	fd442783          	lw	a5,-44(s0)
 110:	2785                	addiw	a5,a5,1
 112:	0007871b          	sext.w	a4,a5
 116:	fcf42a23          	sw	a5,-44(s0)
 11a:	fee4d0e3          	bge	s1,a4,fa <main+0x2a>
        }
        close(p[1]);
 11e:	fdc42503          	lw	a0,-36(s0)
 122:	00000097          	auipc	ra,0x0
 126:	2bc080e7          	jalr	700(ra) # 3de <close>
        wait(0);
 12a:	4501                	li	a0,0
 12c:	00000097          	auipc	ra,0x0
 130:	292080e7          	jalr	658(ra) # 3be <wait>
    }

    exit(0);
 134:	4501                	li	a0,0
 136:	00000097          	auipc	ra,0x0
 13a:	280080e7          	jalr	640(ra) # 3b6 <exit>
        worker(p);
 13e:	fd840513          	addi	a0,s0,-40
 142:	00000097          	auipc	ra,0x0
 146:	ebe080e7          	jalr	-322(ra) # 0 <worker>

000000000000014a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e422                	sd	s0,8(sp)
 14e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 150:	87aa                	mv	a5,a0
 152:	0585                	addi	a1,a1,1
 154:	0785                	addi	a5,a5,1
 156:	fff5c703          	lbu	a4,-1(a1)
 15a:	fee78fa3          	sb	a4,-1(a5)
 15e:	fb75                	bnez	a4,152 <strcpy+0x8>
    ;
  return os;
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret

0000000000000166 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 166:	1141                	addi	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cb91                	beqz	a5,184 <strcmp+0x1e>
 172:	0005c703          	lbu	a4,0(a1)
 176:	00f71763          	bne	a4,a5,184 <strcmp+0x1e>
    p++, q++;
 17a:	0505                	addi	a0,a0,1
 17c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 17e:	00054783          	lbu	a5,0(a0)
 182:	fbe5                	bnez	a5,172 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 184:	0005c503          	lbu	a0,0(a1)
}
 188:	40a7853b          	subw	a0,a5,a0
 18c:	6422                	ld	s0,8(sp)
 18e:	0141                	addi	sp,sp,16
 190:	8082                	ret

0000000000000192 <strlen>:

uint
strlen(const char *s)
{
 192:	1141                	addi	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 198:	00054783          	lbu	a5,0(a0)
 19c:	cf91                	beqz	a5,1b8 <strlen+0x26>
 19e:	0505                	addi	a0,a0,1
 1a0:	87aa                	mv	a5,a0
 1a2:	86be                	mv	a3,a5
 1a4:	0785                	addi	a5,a5,1
 1a6:	fff7c703          	lbu	a4,-1(a5)
 1aa:	ff65                	bnez	a4,1a2 <strlen+0x10>
 1ac:	40a6853b          	subw	a0,a3,a0
 1b0:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1b2:	6422                	ld	s0,8(sp)
 1b4:	0141                	addi	sp,sp,16
 1b6:	8082                	ret
  for(n = 0; s[n]; n++)
 1b8:	4501                	li	a0,0
 1ba:	bfe5                	j	1b2 <strlen+0x20>

00000000000001bc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1bc:	1141                	addi	sp,sp,-16
 1be:	e422                	sd	s0,8(sp)
 1c0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1c2:	ca19                	beqz	a2,1d8 <memset+0x1c>
 1c4:	87aa                	mv	a5,a0
 1c6:	1602                	slli	a2,a2,0x20
 1c8:	9201                	srli	a2,a2,0x20
 1ca:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ce:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1d2:	0785                	addi	a5,a5,1
 1d4:	fee79de3          	bne	a5,a4,1ce <memset+0x12>
  }
  return dst;
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <strchr>:

char*
strchr(const char *s, char c)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	cb99                	beqz	a5,1fe <strchr+0x20>
    if(*s == c)
 1ea:	00f58763          	beq	a1,a5,1f8 <strchr+0x1a>
  for(; *s; s++)
 1ee:	0505                	addi	a0,a0,1
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	fbfd                	bnez	a5,1ea <strchr+0xc>
      return (char*)s;
  return 0;
 1f6:	4501                	li	a0,0
}
 1f8:	6422                	ld	s0,8(sp)
 1fa:	0141                	addi	sp,sp,16
 1fc:	8082                	ret
  return 0;
 1fe:	4501                	li	a0,0
 200:	bfe5                	j	1f8 <strchr+0x1a>

0000000000000202 <gets>:

char*
gets(char *buf, int max)
{
 202:	711d                	addi	sp,sp,-96
 204:	ec86                	sd	ra,88(sp)
 206:	e8a2                	sd	s0,80(sp)
 208:	e4a6                	sd	s1,72(sp)
 20a:	e0ca                	sd	s2,64(sp)
 20c:	fc4e                	sd	s3,56(sp)
 20e:	f852                	sd	s4,48(sp)
 210:	f456                	sd	s5,40(sp)
 212:	f05a                	sd	s6,32(sp)
 214:	ec5e                	sd	s7,24(sp)
 216:	1080                	addi	s0,sp,96
 218:	8baa                	mv	s7,a0
 21a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21c:	892a                	mv	s2,a0
 21e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 220:	4aa9                	li	s5,10
 222:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 224:	89a6                	mv	s3,s1
 226:	2485                	addiw	s1,s1,1
 228:	0344d863          	bge	s1,s4,258 <gets+0x56>
    cc = read(0, &c, 1);
 22c:	4605                	li	a2,1
 22e:	faf40593          	addi	a1,s0,-81
 232:	4501                	li	a0,0
 234:	00000097          	auipc	ra,0x0
 238:	19a080e7          	jalr	410(ra) # 3ce <read>
    if(cc < 1)
 23c:	00a05e63          	blez	a0,258 <gets+0x56>
    buf[i++] = c;
 240:	faf44783          	lbu	a5,-81(s0)
 244:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 248:	01578763          	beq	a5,s5,256 <gets+0x54>
 24c:	0905                	addi	s2,s2,1
 24e:	fd679be3          	bne	a5,s6,224 <gets+0x22>
  for(i=0; i+1 < max; ){
 252:	89a6                	mv	s3,s1
 254:	a011                	j	258 <gets+0x56>
 256:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 258:	99de                	add	s3,s3,s7
 25a:	00098023          	sb	zero,0(s3)
  return buf;
}
 25e:	855e                	mv	a0,s7
 260:	60e6                	ld	ra,88(sp)
 262:	6446                	ld	s0,80(sp)
 264:	64a6                	ld	s1,72(sp)
 266:	6906                	ld	s2,64(sp)
 268:	79e2                	ld	s3,56(sp)
 26a:	7a42                	ld	s4,48(sp)
 26c:	7aa2                	ld	s5,40(sp)
 26e:	7b02                	ld	s6,32(sp)
 270:	6be2                	ld	s7,24(sp)
 272:	6125                	addi	sp,sp,96
 274:	8082                	ret

0000000000000276 <stat>:

int
stat(const char *n, struct stat *st)
{
 276:	1101                	addi	sp,sp,-32
 278:	ec06                	sd	ra,24(sp)
 27a:	e822                	sd	s0,16(sp)
 27c:	e426                	sd	s1,8(sp)
 27e:	e04a                	sd	s2,0(sp)
 280:	1000                	addi	s0,sp,32
 282:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 284:	4581                	li	a1,0
 286:	00000097          	auipc	ra,0x0
 28a:	170080e7          	jalr	368(ra) # 3f6 <open>
  if(fd < 0)
 28e:	02054563          	bltz	a0,2b8 <stat+0x42>
 292:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 294:	85ca                	mv	a1,s2
 296:	00000097          	auipc	ra,0x0
 29a:	178080e7          	jalr	376(ra) # 40e <fstat>
 29e:	892a                	mv	s2,a0
  close(fd);
 2a0:	8526                	mv	a0,s1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	13c080e7          	jalr	316(ra) # 3de <close>
  return r;
}
 2aa:	854a                	mv	a0,s2
 2ac:	60e2                	ld	ra,24(sp)
 2ae:	6442                	ld	s0,16(sp)
 2b0:	64a2                	ld	s1,8(sp)
 2b2:	6902                	ld	s2,0(sp)
 2b4:	6105                	addi	sp,sp,32
 2b6:	8082                	ret
    return -1;
 2b8:	597d                	li	s2,-1
 2ba:	bfc5                	j	2aa <stat+0x34>

00000000000002bc <atoi>:

int
atoi(const char *s)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c2:	00054683          	lbu	a3,0(a0)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	4625                	li	a2,9
 2d0:	02f66863          	bltu	a2,a5,300 <atoi+0x44>
 2d4:	872a                	mv	a4,a0
  n = 0;
 2d6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d8:	0705                	addi	a4,a4,1
 2da:	0025179b          	slliw	a5,a0,0x2
 2de:	9fa9                	addw	a5,a5,a0
 2e0:	0017979b          	slliw	a5,a5,0x1
 2e4:	9fb5                	addw	a5,a5,a3
 2e6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ea:	00074683          	lbu	a3,0(a4)
 2ee:	fd06879b          	addiw	a5,a3,-48
 2f2:	0ff7f793          	zext.b	a5,a5
 2f6:	fef671e3          	bgeu	a2,a5,2d8 <atoi+0x1c>
  return n;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret
  n = 0;
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <atoi+0x3e>

0000000000000304 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 30a:	02b57463          	bgeu	a0,a1,332 <memmove+0x2e>
    while(n-- > 0)
 30e:	00c05f63          	blez	a2,32c <memmove+0x28>
 312:	1602                	slli	a2,a2,0x20
 314:	9201                	srli	a2,a2,0x20
 316:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 31a:	872a                	mv	a4,a0
      *dst++ = *src++;
 31c:	0585                	addi	a1,a1,1
 31e:	0705                	addi	a4,a4,1
 320:	fff5c683          	lbu	a3,-1(a1)
 324:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 328:	fee79ae3          	bne	a5,a4,31c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
    dst += n;
 332:	00c50733          	add	a4,a0,a2
    src += n;
 336:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 338:	fec05ae3          	blez	a2,32c <memmove+0x28>
 33c:	fff6079b          	addiw	a5,a2,-1
 340:	1782                	slli	a5,a5,0x20
 342:	9381                	srli	a5,a5,0x20
 344:	fff7c793          	not	a5,a5
 348:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34a:	15fd                	addi	a1,a1,-1
 34c:	177d                	addi	a4,a4,-1
 34e:	0005c683          	lbu	a3,0(a1)
 352:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 356:	fee79ae3          	bne	a5,a4,34a <memmove+0x46>
 35a:	bfc9                	j	32c <memmove+0x28>

000000000000035c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e422                	sd	s0,8(sp)
 360:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 362:	ca05                	beqz	a2,392 <memcmp+0x36>
 364:	fff6069b          	addiw	a3,a2,-1
 368:	1682                	slli	a3,a3,0x20
 36a:	9281                	srli	a3,a3,0x20
 36c:	0685                	addi	a3,a3,1
 36e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 370:	00054783          	lbu	a5,0(a0)
 374:	0005c703          	lbu	a4,0(a1)
 378:	00e79863          	bne	a5,a4,388 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 37c:	0505                	addi	a0,a0,1
    p2++;
 37e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 380:	fed518e3          	bne	a0,a3,370 <memcmp+0x14>
  }
  return 0;
 384:	4501                	li	a0,0
 386:	a019                	j	38c <memcmp+0x30>
      return *p1 - *p2;
 388:	40e7853b          	subw	a0,a5,a4
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
  return 0;
 392:	4501                	li	a0,0
 394:	bfe5                	j	38c <memcmp+0x30>

0000000000000396 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 39e:	00000097          	auipc	ra,0x0
 3a2:	f66080e7          	jalr	-154(ra) # 304 <memmove>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ae:	4885                	li	a7,1
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b6:	4889                	li	a7,2
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <wait>:
.global wait
wait:
 li a7, SYS_wait
 3be:	488d                	li	a7,3
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c6:	4891                	li	a7,4
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <read>:
.global read
read:
 li a7, SYS_read
 3ce:	4895                	li	a7,5
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <write>:
.global write
write:
 li a7, SYS_write
 3d6:	48c1                	li	a7,16
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <close>:
.global close
close:
 li a7, SYS_close
 3de:	48d5                	li	a7,21
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e6:	4899                	li	a7,6
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ee:	489d                	li	a7,7
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <open>:
.global open
open:
 li a7, SYS_open
 3f6:	48bd                	li	a7,15
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fe:	48c5                	li	a7,17
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 406:	48c9                	li	a7,18
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40e:	48a1                	li	a7,8
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <link>:
.global link
link:
 li a7, SYS_link
 416:	48cd                	li	a7,19
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41e:	48d1                	li	a7,20
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 426:	48a5                	li	a7,9
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <dup>:
.global dup
dup:
 li a7, SYS_dup
 42e:	48a9                	li	a7,10
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 436:	48ad                	li	a7,11
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43e:	48b1                	li	a7,12
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 446:	48b5                	li	a7,13
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44e:	48b9                	li	a7,14
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 456:	1101                	addi	sp,sp,-32
 458:	ec06                	sd	ra,24(sp)
 45a:	e822                	sd	s0,16(sp)
 45c:	1000                	addi	s0,sp,32
 45e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 462:	4605                	li	a2,1
 464:	fef40593          	addi	a1,s0,-17
 468:	00000097          	auipc	ra,0x0
 46c:	f6e080e7          	jalr	-146(ra) # 3d6 <write>
}
 470:	60e2                	ld	ra,24(sp)
 472:	6442                	ld	s0,16(sp)
 474:	6105                	addi	sp,sp,32
 476:	8082                	ret

0000000000000478 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 478:	7139                	addi	sp,sp,-64
 47a:	fc06                	sd	ra,56(sp)
 47c:	f822                	sd	s0,48(sp)
 47e:	f426                	sd	s1,40(sp)
 480:	f04a                	sd	s2,32(sp)
 482:	ec4e                	sd	s3,24(sp)
 484:	0080                	addi	s0,sp,64
 486:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 488:	c299                	beqz	a3,48e <printint+0x16>
 48a:	0805c963          	bltz	a1,51c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 48e:	2581                	sext.w	a1,a1
  neg = 0;
 490:	4881                	li	a7,0
 492:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 496:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 498:	2601                	sext.w	a2,a2
 49a:	00000517          	auipc	a0,0x0
 49e:	49650513          	addi	a0,a0,1174 # 930 <digits>
 4a2:	883a                	mv	a6,a4
 4a4:	2705                	addiw	a4,a4,1
 4a6:	02c5f7bb          	remuw	a5,a1,a2
 4aa:	1782                	slli	a5,a5,0x20
 4ac:	9381                	srli	a5,a5,0x20
 4ae:	97aa                	add	a5,a5,a0
 4b0:	0007c783          	lbu	a5,0(a5)
 4b4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4b8:	0005879b          	sext.w	a5,a1
 4bc:	02c5d5bb          	divuw	a1,a1,a2
 4c0:	0685                	addi	a3,a3,1
 4c2:	fec7f0e3          	bgeu	a5,a2,4a2 <printint+0x2a>
  if(neg)
 4c6:	00088c63          	beqz	a7,4de <printint+0x66>
    buf[i++] = '-';
 4ca:	fd070793          	addi	a5,a4,-48
 4ce:	00878733          	add	a4,a5,s0
 4d2:	02d00793          	li	a5,45
 4d6:	fef70823          	sb	a5,-16(a4)
 4da:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4de:	02e05863          	blez	a4,50e <printint+0x96>
 4e2:	fc040793          	addi	a5,s0,-64
 4e6:	00e78933          	add	s2,a5,a4
 4ea:	fff78993          	addi	s3,a5,-1
 4ee:	99ba                	add	s3,s3,a4
 4f0:	377d                	addiw	a4,a4,-1
 4f2:	1702                	slli	a4,a4,0x20
 4f4:	9301                	srli	a4,a4,0x20
 4f6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4fa:	fff94583          	lbu	a1,-1(s2)
 4fe:	8526                	mv	a0,s1
 500:	00000097          	auipc	ra,0x0
 504:	f56080e7          	jalr	-170(ra) # 456 <putc>
  while(--i >= 0)
 508:	197d                	addi	s2,s2,-1
 50a:	ff3918e3          	bne	s2,s3,4fa <printint+0x82>
}
 50e:	70e2                	ld	ra,56(sp)
 510:	7442                	ld	s0,48(sp)
 512:	74a2                	ld	s1,40(sp)
 514:	7902                	ld	s2,32(sp)
 516:	69e2                	ld	s3,24(sp)
 518:	6121                	addi	sp,sp,64
 51a:	8082                	ret
    x = -xx;
 51c:	40b005bb          	negw	a1,a1
    neg = 1;
 520:	4885                	li	a7,1
    x = -xx;
 522:	bf85                	j	492 <printint+0x1a>

0000000000000524 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 524:	715d                	addi	sp,sp,-80
 526:	e486                	sd	ra,72(sp)
 528:	e0a2                	sd	s0,64(sp)
 52a:	fc26                	sd	s1,56(sp)
 52c:	f84a                	sd	s2,48(sp)
 52e:	f44e                	sd	s3,40(sp)
 530:	f052                	sd	s4,32(sp)
 532:	ec56                	sd	s5,24(sp)
 534:	e85a                	sd	s6,16(sp)
 536:	e45e                	sd	s7,8(sp)
 538:	e062                	sd	s8,0(sp)
 53a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 53c:	0005c903          	lbu	s2,0(a1)
 540:	18090c63          	beqz	s2,6d8 <vprintf+0x1b4>
 544:	8aaa                	mv	s5,a0
 546:	8bb2                	mv	s7,a2
 548:	00158493          	addi	s1,a1,1
  state = 0;
 54c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 54e:	02500a13          	li	s4,37
 552:	4b55                	li	s6,21
 554:	a839                	j	572 <vprintf+0x4e>
        putc(fd, c);
 556:	85ca                	mv	a1,s2
 558:	8556                	mv	a0,s5
 55a:	00000097          	auipc	ra,0x0
 55e:	efc080e7          	jalr	-260(ra) # 456 <putc>
 562:	a019                	j	568 <vprintf+0x44>
    } else if(state == '%'){
 564:	01498d63          	beq	s3,s4,57e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 568:	0485                	addi	s1,s1,1
 56a:	fff4c903          	lbu	s2,-1(s1)
 56e:	16090563          	beqz	s2,6d8 <vprintf+0x1b4>
    if(state == 0){
 572:	fe0999e3          	bnez	s3,564 <vprintf+0x40>
      if(c == '%'){
 576:	ff4910e3          	bne	s2,s4,556 <vprintf+0x32>
        state = '%';
 57a:	89d2                	mv	s3,s4
 57c:	b7f5                	j	568 <vprintf+0x44>
      if(c == 'd'){
 57e:	13490263          	beq	s2,s4,6a2 <vprintf+0x17e>
 582:	f9d9079b          	addiw	a5,s2,-99
 586:	0ff7f793          	zext.b	a5,a5
 58a:	12fb6563          	bltu	s6,a5,6b4 <vprintf+0x190>
 58e:	f9d9079b          	addiw	a5,s2,-99
 592:	0ff7f713          	zext.b	a4,a5
 596:	10eb6f63          	bltu	s6,a4,6b4 <vprintf+0x190>
 59a:	00271793          	slli	a5,a4,0x2
 59e:	00000717          	auipc	a4,0x0
 5a2:	33a70713          	addi	a4,a4,826 # 8d8 <malloc+0x102>
 5a6:	97ba                	add	a5,a5,a4
 5a8:	439c                	lw	a5,0(a5)
 5aa:	97ba                	add	a5,a5,a4
 5ac:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5ae:	008b8913          	addi	s2,s7,8
 5b2:	4685                	li	a3,1
 5b4:	4629                	li	a2,10
 5b6:	000ba583          	lw	a1,0(s7)
 5ba:	8556                	mv	a0,s5
 5bc:	00000097          	auipc	ra,0x0
 5c0:	ebc080e7          	jalr	-324(ra) # 478 <printint>
 5c4:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5c6:	4981                	li	s3,0
 5c8:	b745                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ca:	008b8913          	addi	s2,s7,8
 5ce:	4681                	li	a3,0
 5d0:	4629                	li	a2,10
 5d2:	000ba583          	lw	a1,0(s7)
 5d6:	8556                	mv	a0,s5
 5d8:	00000097          	auipc	ra,0x0
 5dc:	ea0080e7          	jalr	-352(ra) # 478 <printint>
 5e0:	8bca                	mv	s7,s2
      state = 0;
 5e2:	4981                	li	s3,0
 5e4:	b751                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5e6:	008b8913          	addi	s2,s7,8
 5ea:	4681                	li	a3,0
 5ec:	4641                	li	a2,16
 5ee:	000ba583          	lw	a1,0(s7)
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e84080e7          	jalr	-380(ra) # 478 <printint>
 5fc:	8bca                	mv	s7,s2
      state = 0;
 5fe:	4981                	li	s3,0
 600:	b7a5                	j	568 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 602:	008b8c13          	addi	s8,s7,8
 606:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 60a:	03000593          	li	a1,48
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	e46080e7          	jalr	-442(ra) # 456 <putc>
  putc(fd, 'x');
 618:	07800593          	li	a1,120
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	e38080e7          	jalr	-456(ra) # 456 <putc>
 626:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 628:	00000b97          	auipc	s7,0x0
 62c:	308b8b93          	addi	s7,s7,776 # 930 <digits>
 630:	03c9d793          	srli	a5,s3,0x3c
 634:	97de                	add	a5,a5,s7
 636:	0007c583          	lbu	a1,0(a5)
 63a:	8556                	mv	a0,s5
 63c:	00000097          	auipc	ra,0x0
 640:	e1a080e7          	jalr	-486(ra) # 456 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 644:	0992                	slli	s3,s3,0x4
 646:	397d                	addiw	s2,s2,-1
 648:	fe0914e3          	bnez	s2,630 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 64c:	8be2                	mv	s7,s8
      state = 0;
 64e:	4981                	li	s3,0
 650:	bf21                	j	568 <vprintf+0x44>
        s = va_arg(ap, char*);
 652:	008b8993          	addi	s3,s7,8
 656:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 65a:	02090163          	beqz	s2,67c <vprintf+0x158>
        while(*s != 0){
 65e:	00094583          	lbu	a1,0(s2)
 662:	c9a5                	beqz	a1,6d2 <vprintf+0x1ae>
          putc(fd, *s);
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	df0080e7          	jalr	-528(ra) # 456 <putc>
          s++;
 66e:	0905                	addi	s2,s2,1
        while(*s != 0){
 670:	00094583          	lbu	a1,0(s2)
 674:	f9e5                	bnez	a1,664 <vprintf+0x140>
        s = va_arg(ap, char*);
 676:	8bce                	mv	s7,s3
      state = 0;
 678:	4981                	li	s3,0
 67a:	b5fd                	j	568 <vprintf+0x44>
          s = "(null)";
 67c:	00000917          	auipc	s2,0x0
 680:	25490913          	addi	s2,s2,596 # 8d0 <malloc+0xfa>
        while(*s != 0){
 684:	02800593          	li	a1,40
 688:	bff1                	j	664 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 68a:	008b8913          	addi	s2,s7,8
 68e:	000bc583          	lbu	a1,0(s7)
 692:	8556                	mv	a0,s5
 694:	00000097          	auipc	ra,0x0
 698:	dc2080e7          	jalr	-574(ra) # 456 <putc>
 69c:	8bca                	mv	s7,s2
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	b5e1                	j	568 <vprintf+0x44>
        putc(fd, c);
 6a2:	02500593          	li	a1,37
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	dae080e7          	jalr	-594(ra) # 456 <putc>
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	bd5d                	j	568 <vprintf+0x44>
        putc(fd, '%');
 6b4:	02500593          	li	a1,37
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	d9c080e7          	jalr	-612(ra) # 456 <putc>
        putc(fd, c);
 6c2:	85ca                	mv	a1,s2
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	d90080e7          	jalr	-624(ra) # 456 <putc>
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	bd61                	j	568 <vprintf+0x44>
        s = va_arg(ap, char*);
 6d2:	8bce                	mv	s7,s3
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	bd49                	j	568 <vprintf+0x44>
    }
  }
}
 6d8:	60a6                	ld	ra,72(sp)
 6da:	6406                	ld	s0,64(sp)
 6dc:	74e2                	ld	s1,56(sp)
 6de:	7942                	ld	s2,48(sp)
 6e0:	79a2                	ld	s3,40(sp)
 6e2:	7a02                	ld	s4,32(sp)
 6e4:	6ae2                	ld	s5,24(sp)
 6e6:	6b42                	ld	s6,16(sp)
 6e8:	6ba2                	ld	s7,8(sp)
 6ea:	6c02                	ld	s8,0(sp)
 6ec:	6161                	addi	sp,sp,80
 6ee:	8082                	ret

00000000000006f0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6f0:	715d                	addi	sp,sp,-80
 6f2:	ec06                	sd	ra,24(sp)
 6f4:	e822                	sd	s0,16(sp)
 6f6:	1000                	addi	s0,sp,32
 6f8:	e010                	sd	a2,0(s0)
 6fa:	e414                	sd	a3,8(s0)
 6fc:	e818                	sd	a4,16(s0)
 6fe:	ec1c                	sd	a5,24(s0)
 700:	03043023          	sd	a6,32(s0)
 704:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 708:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 70c:	8622                	mv	a2,s0
 70e:	00000097          	auipc	ra,0x0
 712:	e16080e7          	jalr	-490(ra) # 524 <vprintf>
}
 716:	60e2                	ld	ra,24(sp)
 718:	6442                	ld	s0,16(sp)
 71a:	6161                	addi	sp,sp,80
 71c:	8082                	ret

000000000000071e <printf>:

void
printf(const char *fmt, ...)
{
 71e:	711d                	addi	sp,sp,-96
 720:	ec06                	sd	ra,24(sp)
 722:	e822                	sd	s0,16(sp)
 724:	1000                	addi	s0,sp,32
 726:	e40c                	sd	a1,8(s0)
 728:	e810                	sd	a2,16(s0)
 72a:	ec14                	sd	a3,24(s0)
 72c:	f018                	sd	a4,32(s0)
 72e:	f41c                	sd	a5,40(s0)
 730:	03043823          	sd	a6,48(s0)
 734:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 738:	00840613          	addi	a2,s0,8
 73c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 740:	85aa                	mv	a1,a0
 742:	4505                	li	a0,1
 744:	00000097          	auipc	ra,0x0
 748:	de0080e7          	jalr	-544(ra) # 524 <vprintf>
}
 74c:	60e2                	ld	ra,24(sp)
 74e:	6442                	ld	s0,16(sp)
 750:	6125                	addi	sp,sp,96
 752:	8082                	ret

0000000000000754 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 754:	1141                	addi	sp,sp,-16
 756:	e422                	sd	s0,8(sp)
 758:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 75a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75e:	00000797          	auipc	a5,0x0
 762:	1ea7b783          	ld	a5,490(a5) # 948 <freep>
 766:	a02d                	j	790 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 768:	4618                	lw	a4,8(a2)
 76a:	9f2d                	addw	a4,a4,a1
 76c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 770:	6398                	ld	a4,0(a5)
 772:	6310                	ld	a2,0(a4)
 774:	a83d                	j	7b2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 776:	ff852703          	lw	a4,-8(a0)
 77a:	9f31                	addw	a4,a4,a2
 77c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 77e:	ff053683          	ld	a3,-16(a0)
 782:	a091                	j	7c6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 784:	6398                	ld	a4,0(a5)
 786:	00e7e463          	bltu	a5,a4,78e <free+0x3a>
 78a:	00e6ea63          	bltu	a3,a4,79e <free+0x4a>
{
 78e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 790:	fed7fae3          	bgeu	a5,a3,784 <free+0x30>
 794:	6398                	ld	a4,0(a5)
 796:	00e6e463          	bltu	a3,a4,79e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79a:	fee7eae3          	bltu	a5,a4,78e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 79e:	ff852583          	lw	a1,-8(a0)
 7a2:	6390                	ld	a2,0(a5)
 7a4:	02059813          	slli	a6,a1,0x20
 7a8:	01c85713          	srli	a4,a6,0x1c
 7ac:	9736                	add	a4,a4,a3
 7ae:	fae60de3          	beq	a2,a4,768 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7b2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7b6:	4790                	lw	a2,8(a5)
 7b8:	02061593          	slli	a1,a2,0x20
 7bc:	01c5d713          	srli	a4,a1,0x1c
 7c0:	973e                	add	a4,a4,a5
 7c2:	fae68ae3          	beq	a3,a4,776 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7c6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c8:	00000717          	auipc	a4,0x0
 7cc:	18f73023          	sd	a5,384(a4) # 948 <freep>
}
 7d0:	6422                	ld	s0,8(sp)
 7d2:	0141                	addi	sp,sp,16
 7d4:	8082                	ret

00000000000007d6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d6:	7139                	addi	sp,sp,-64
 7d8:	fc06                	sd	ra,56(sp)
 7da:	f822                	sd	s0,48(sp)
 7dc:	f426                	sd	s1,40(sp)
 7de:	f04a                	sd	s2,32(sp)
 7e0:	ec4e                	sd	s3,24(sp)
 7e2:	e852                	sd	s4,16(sp)
 7e4:	e456                	sd	s5,8(sp)
 7e6:	e05a                	sd	s6,0(sp)
 7e8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ea:	02051493          	slli	s1,a0,0x20
 7ee:	9081                	srli	s1,s1,0x20
 7f0:	04bd                	addi	s1,s1,15
 7f2:	8091                	srli	s1,s1,0x4
 7f4:	0014899b          	addiw	s3,s1,1
 7f8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7fa:	00000517          	auipc	a0,0x0
 7fe:	14e53503          	ld	a0,334(a0) # 948 <freep>
 802:	c515                	beqz	a0,82e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 804:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 806:	4798                	lw	a4,8(a5)
 808:	02977f63          	bgeu	a4,s1,846 <malloc+0x70>
  if(nu < 4096)
 80c:	8a4e                	mv	s4,s3
 80e:	0009871b          	sext.w	a4,s3
 812:	6685                	lui	a3,0x1
 814:	00d77363          	bgeu	a4,a3,81a <malloc+0x44>
 818:	6a05                	lui	s4,0x1
 81a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 81e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 822:	00000917          	auipc	s2,0x0
 826:	12690913          	addi	s2,s2,294 # 948 <freep>
  if(p == (char*)-1)
 82a:	5afd                	li	s5,-1
 82c:	a895                	j	8a0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 82e:	00000797          	auipc	a5,0x0
 832:	12278793          	addi	a5,a5,290 # 950 <base>
 836:	00000717          	auipc	a4,0x0
 83a:	10f73923          	sd	a5,274(a4) # 948 <freep>
 83e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 840:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 844:	b7e1                	j	80c <malloc+0x36>
      if(p->s.size == nunits)
 846:	02e48c63          	beq	s1,a4,87e <malloc+0xa8>
        p->s.size -= nunits;
 84a:	4137073b          	subw	a4,a4,s3
 84e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 850:	02071693          	slli	a3,a4,0x20
 854:	01c6d713          	srli	a4,a3,0x1c
 858:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 85a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 85e:	00000717          	auipc	a4,0x0
 862:	0ea73523          	sd	a0,234(a4) # 948 <freep>
      return (void*)(p + 1);
 866:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 86a:	70e2                	ld	ra,56(sp)
 86c:	7442                	ld	s0,48(sp)
 86e:	74a2                	ld	s1,40(sp)
 870:	7902                	ld	s2,32(sp)
 872:	69e2                	ld	s3,24(sp)
 874:	6a42                	ld	s4,16(sp)
 876:	6aa2                	ld	s5,8(sp)
 878:	6b02                	ld	s6,0(sp)
 87a:	6121                	addi	sp,sp,64
 87c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 87e:	6398                	ld	a4,0(a5)
 880:	e118                	sd	a4,0(a0)
 882:	bff1                	j	85e <malloc+0x88>
  hp->s.size = nu;
 884:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 888:	0541                	addi	a0,a0,16
 88a:	00000097          	auipc	ra,0x0
 88e:	eca080e7          	jalr	-310(ra) # 754 <free>
  return freep;
 892:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 896:	d971                	beqz	a0,86a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 898:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 89a:	4798                	lw	a4,8(a5)
 89c:	fa9775e3          	bgeu	a4,s1,846 <malloc+0x70>
    if(p == freep)
 8a0:	00093703          	ld	a4,0(s2)
 8a4:	853e                	mv	a0,a5
 8a6:	fef719e3          	bne	a4,a5,898 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8aa:	8552                	mv	a0,s4
 8ac:	00000097          	auipc	ra,0x0
 8b0:	b92080e7          	jalr	-1134(ra) # 43e <sbrk>
  if(p == (char*)-1)
 8b4:	fd5518e3          	bne	a0,s5,884 <malloc+0xae>
        return 0;
 8b8:	4501                	li	a0,0
 8ba:	bf45                	j	86a <malloc+0x94>
