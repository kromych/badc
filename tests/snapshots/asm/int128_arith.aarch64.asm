
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
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	x0, [x6]
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
               	cset	x5, lo
               	add	x7, x5, #0x0
               	cmp	x4, #0x0
               	cset	x5, ne
               	cbnz	x4, <addr>
               	cmp	x7, #0x1
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x5, #0x1                // =1
               	cbz	x5, <addr>
               	sxtw	x0, w5
               	ret
               	ldr	x5, [x3]
               	cmp	x4, x5
               	cset	x8, lo
               	sub	x4, x4, x5
               	sub	x5, x7, #0x0
               	sub	x5, x5, x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x4, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x5, #0x0
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x2                // =2
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	add	x4, x0, x0
               	cmp	x4, x0
               	cset	x5, lo
               	add	x7, x1, x1
               	add	x5, x7, x5
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x4, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0xddfe            // =56830
               	movk	x17, #0x99bb, lsl #16
               	movk	x17, #0x5577, lsl #32
               	movk	x17, #0x1133, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x2, #0x3                // =3
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	ldr	x5, [x3]
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x7, hi
               	sub	x8, x2, x0
               	sub	x4, x5, x1
               	sub	x5, x4, x7
               	mov	x17, #0x9989            // =39305
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x8, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0x1101            // =4353
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x5, x17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x5, #0x4                // =4
               	cbz	x5, <addr>
               	sxtw	x0, w5
               	ret
               	ldr	x5, [x3]
               	cmp	x5, #0x0
               	cset	x9, hi
               	sub	x5, x2, x5
               	sub	x10, x2, x9
               	mov	x9, #0xffff             // =65535
               	movk	x9, #0xffff, lsl #16
               	movk	x9, #0xffff, lsl #32
               	movk	x9, #0xffff, lsl #48
               	cmp	x5, x9
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x10, x9
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x5, #0x5                // =5
               	cbz	x5, <addr>
               	sxtw	x0, w5
               	ret
               	sub	x5, x2, x1
               	sub	x5, x5, x7
               	cbnz	x4, <addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x2, #0x6                // =6
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	mvn	x2, x0
               	mvn	x4, x1
               	mov	x17, #0x9988            // =39304
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x2, x17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x4, x17
               	cset	x2, ne
               	cbz	x2, <addr>
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
               	cset	x2, ne
               	cbnz	x2, <addr>
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
               	orr	x5, x1, x2
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x5, x17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0x9                // =9
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	eor	x5, x0, x0
               	eor	x7, x1, x1
               	cmp	x5, #0x0
               	cset	x2, ne
               	cbnz	x5, <addr>
               	cmp	x7, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0xa                // =10
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ret
               	mov	x2, #0x0                // =0
               	eor	x4, x0, x2
               	eor	x8, x1, x2
               	orr	x8, x4, x8
               	mov	x4, #0x1                // =1
               	cbz	x8, <addr>
               	ldr	x4, [x3]
               	mov	x17, #0x0               // =0
               	eor	x4, x4, x17
               	mov	x17, #0x0               // =0
               	orr	x4, x4, x17
               	cmp	x4, #0x0
               	cset	x4, eq
               	cbnz	x4, <addr>
               	eor	x4, x5, x2
               	eor	x5, x7, x2
               	orr	x4, x4, x5
               	cmp	x4, #0x0
               	cset	x4, eq
               	cmp	x4, #0x0
               	cset	x4, eq
               	cbz	x4, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x4, [x3]
               	add	x4, x0, x4
               	cmp	x4, x0
               	cset	x5, lo
               	add	x7, x1, #0x0
               	add	x5, x7, x5
               	mov	x17, #0x6678            // =26232
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0xc                // =12
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	ldr	x4, [x6]
               	ldr	x7, [x3]
               	add	x5, x4, #0x0
               	cmp	x5, x4
               	cset	x4, lo
               	add	x7, x7, #0x0
               	add	x7, x7, x4
               	ldr	x4, [x6]
               	cmp	x5, x4
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x7, #0x1
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0xd                // =13
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	orr	x4, x1, x2
               	orr	x5, x2, x0
               	add	x2, x0, x4
               	cmp	x2, x0
               	cset	x0, lo
               	add	x1, x1, x5
               	add	x1, x1, x0
               	mov	x4, #0x5576             // =21878
               	movk	x4, #0x1133, lsl #16
               	movk	x4, #0xccef, lsl #32
               	movk	x4, #0x88aa, lsl #48
               	cmp	x2, x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x1, x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	ldr	x4, [x3]
               	mov	x0, #0x0                // =0
               	cmp	x2, x4
               	cset	x5, lo
               	sub	x2, x2, x4
               	sub	x1, x1, #0x0
               	sub	x4, x1, x5
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	mov	x17, #0x5               // =5
               	orr	x2, x2, x17
               	orr	x4, x4, x0
               	ldr	x1, [x3]
               	lsl	x1, x1, #63
               	eor	x2, x2, x0
               	eor	x3, x4, x1
               	mov	x17, #0x5505            // =21765
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x88aa, lsl #48
               	cmp	x2, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x17, #0x5576            // =21878
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x8aa, lsl #48
               	cmp	x3, x17
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x5, x2
               	b	<addr>
               	b	<addr>
               	mov	x5, x2
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	mov	x5, x2
               	b	<addr>
               	b	<addr>
