
int128_arith.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x0, [x5]
               	orr	x0, x2, x0
               	orr	x1, x1, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	sub	x4, x4, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x4, x17
               	cset	x6, lo
               	add	x7, x6, #0x0
               	cbnz	x4, <addr>
               	cmp	x7, #0x1
               	cset	x6, ne
               	cbz	x6, <addr>
               	mov	x6, #0x1                // =1
               	cbz	x6, <addr>
               	sxtw	x0, w6
               	ret
               	ldr	x6, [x3]
               	cmp	x4, x6
               	cset	x8, lo
               	sub	x4, x4, x6
               	sub	x6, x7, #0x0
               	sub	x6, x6, x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	cmp	x6, #0x0
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x2                // =2
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	add	x4, x0, x0
               	cmp	x4, x0
               	cset	x6, lo
               	add	x7, x1, x1
               	add	x6, x7, x6
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #0xddfe            // =56830
               	movk	x17, #0x99bb, lsl #16
               	movk	x17, #0x5577, lsl #32
               	movk	x17, #0x1133, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x3                // =3
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	ldr	x4, [x3]
               	cmp	x0, #0x0
               	cset	x6, hi
               	sub	x2, x2, x0
               	sub	x4, x4, x1
               	sub	x4, x4, x6
               	mov	x17, #0x9989            // =39305
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0x1101            // =4353
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x4, x17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0x4                // =4
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	ldr	x4, [x3]
               	mov	x2, #0x0                // =0
               	cmp	x4, #0x0
               	cset	x7, hi
               	sub	x8, x2, x4
               	sub	x7, x2, x7
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	cmp	x8, x4
               	b.ne	<addr>
               	cmp	x7, x4
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x5                // =5
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	sub	x4, x2, x0
               	sub	x7, x2, x1
               	sub	x6, x7, x6
               	mov	x17, #0x9989            // =39305
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x6                // =6
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	mvn	x4, x0
               	mvn	x6, x1
               	mov	x17, #0x9988            // =39304
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x2, #0x7                // =7
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	mov	x17, #0xffff0000        // =4294901760
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x4, x1, x17
               	mov	x17, #0x44550000        // =1146421248
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x4, x17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0x8                // =8
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	ldr	x2, [x3]
               	lsl	x2, x2, #63
               	mov	x17, #0x0               // =0
               	orr	x4, x0, x17
               	orr	x2, x1, x2
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x2, x17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0x9                // =9
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	eor	x4, x0, x0
               	eor	x7, x1, x1
               	cbnz	x4, <addr>
               	cmp	x7, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0xa                // =10
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	mov	x2, #0x0                // =0
               	eor	x6, x0, x2
               	eor	x8, x1, x2
               	orr	x6, x6, x8
               	cbz	x6, <addr>
               	ldr	x6, [x3]
               	mov	x17, #0x0               // =0
               	eor	x6, x6, x17
               	mov	x17, #0x0               // =0
               	orr	x6, x6, x17
               	cmp	x6, #0x0
               	cset	x6, eq
               	cbnz	x6, <addr>
               	eor	x4, x4, x2
               	eor	x6, x7, x2
               	orr	x4, x4, x6
               	cmp	x4, #0x0
               	cset	x4, eq
               	cmp	w4, #0x0
               	cset	x4, eq
               	cbz	x4, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x4, [x3]
               	add	x4, x0, x4
               	cmp	x4, x0
               	cset	x6, lo
               	add	x7, x1, #0x0
               	add	x6, x7, x6
               	mov	x17, #0x6678            // =26232
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0xc                // =12
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	ldr	x4, [x5]
               	ldr	x7, [x3]
               	add	x6, x4, #0x0
               	cmp	x6, x4
               	cset	x4, lo
               	add	x7, x7, #0x0
               	add	x4, x7, x4
               	ldr	x5, [x5]
               	cmp	x6, x5
               	b.ne	<addr>
               	cmp	x4, #0x1
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0xd                // =13
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	orr	x4, x1, x2
               	orr	x5, x2, x0
               	add	x4, x0, x4
               	cmp	x4, x0
               	cset	x0, lo
               	add	x1, x1, x5
               	add	x1, x1, x0
               	mov	x0, #0x5576             // =21878
               	movk	x0, #0x1133, lsl #16
               	movk	x0, #0xccef, lsl #32
               	movk	x0, #0x88aa, lsl #48
               	cmp	x4, x0
               	b.ne	<addr>
               	cmp	x1, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0xe                // =14
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	ldr	x2, [x3]
               	mov	x0, #0x0                // =0
               	cmp	x4, x2
               	cset	x5, lo
               	sub	x2, x4, x2
               	sub	x1, x1, #0x0
               	sub	x1, x1, x5
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x5               // =5
               	orr	x2, x2, x17
               	orr	x1, x1, x0
               	ldr	x3, [x3]
               	lsl	x3, x3, #63
               	eor	x2, x2, x0
               	eor	x1, x1, x3
               	mov	x17, #0x5505            // =21765
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x88aa, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0x5576            // =21878
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x8aa, lsl #48
               	cmp	x1, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x1, #0xf                // =15
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	ret
               	mov	x1, x0
               	mov	x2, x0
               	mov	x1, x0
               	mov	x2, x0
               	ret
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x6, x2
               	b	<addr>
