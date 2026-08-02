
int128_arith.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	x0, [x6]
               	orr	x0, x1, x0
               	orr	x1, x2, x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	sub	x3, x3, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	cset	x4, lo
               	add	x7, x4, #0x0
               	cmp	x3, #0x0
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x7, #0x1
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x4, #0x1                // =1
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ret
               	ldr	x4, [x2]
               	cmp	x3, x4
               	cset	x5, lo
               	sub	x4, x3, x4
               	sub	x3, x7, #0x0
               	sub	x5, x3, x5
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
               	mov	x3, #0x2                // =2
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	add	x4, x0, x0
               	cmp	x4, x0
               	cset	x3, lo
               	add	x5, x1, x1
               	add	x5, x5, x3
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
               	mov	x3, #0x3                // =3
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	ldr	x4, [x2]
               	mov	x5, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x3, hi
               	sub	x5, x5, x0
               	sub	x4, x4, x1
               	sub	x7, x4, x3
               	mov	x17, #0x9989            // =39305
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0x1101            // =4353
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x7, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x3, #0x4                // =4
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	ldr	x4, [x2]
               	mov	x5, #0x0                // =0
               	cmp	x4, #0x0
               	cset	x3, hi
               	sub	x4, x5, x4
               	mov	x5, #0x0                // =0
               	sub	x7, x5, x3
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	cmp	x4, x5
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x7, x5
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x3, #0x5                // =5
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	mov	x4, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x3, hi
               	sub	x5, x4, x0
               	sub	x4, x4, x1
               	sub	x7, x4, x3
               	mov	x17, #0x9989            // =39305
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x7, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x3, #0x6                // =6
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	mvn	x4, x0
               	mvn	x5, x1
               	mov	x17, #0x9988            // =39304
               	movk	x17, #0xbbaa, lsl #16
               	movk	x17, #0xddcc, lsl #32
               	movk	x17, #0xffee, lsl #48
               	cmp	x4, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0x1100            // =4352
               	movk	x17, #0x3322, lsl #16
               	movk	x17, #0x5544, lsl #32
               	movk	x17, #0x7766, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x3, #0x7                // =7
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	mov	x17, #0xffff0000        // =4294901760
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x4, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x5, x1, x17
               	mov	x17, #0x44550000        // =1146421248
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
               	mov	x3, #0x8                // =8
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	ldr	x4, [x2]
               	lsl	x4, x4, #63
               	mov	x17, #0x0               // =0
               	orr	x5, x0, x17
               	orr	x7, x1, x4
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x7, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x3, #0x9                // =9
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	eor	x4, x0, x0
               	eor	x5, x1, x1
               	cmp	x4, #0x0
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x5, #0x0
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x3, #0xa                // =10
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	mov	x3, #0x0                // =0
               	eor	x4, x0, x3
               	eor	x3, x1, x3
               	orr	x3, x4, x3
               	cmp	x3, #0x0
               	cset	x4, eq
               	mov	x3, #0x1                // =1
               	cbnz	x4, <addr>
               	ldr	x4, [x2]
               	mov	x17, #0x0               // =0
               	eor	x3, x4, x17
               	mov	x17, #0x0               // =0
               	orr	x3, x3, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	eor	x4, x0, x0
               	eor	x5, x1, x1
               	mov	x3, #0x0                // =0
               	eor	x4, x4, x3
               	eor	x3, x5, x3
               	orr	x3, x4, x3
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x3, [x2]
               	add	x4, x0, x3
               	cmp	x4, x0
               	cset	x3, lo
               	add	x5, x1, #0x0
               	add	x5, x5, x3
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
               	mov	x3, #0xc                // =12
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	ldr	x4, [x6]
               	ldr	x7, [x2]
               	add	x5, x4, #0x0
               	cmp	x5, x4
               	cset	x3, lo
               	add	x4, x7, #0x0
               	add	x7, x4, x3
               	ldr	x4, [x6]
               	cmp	x5, x4
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x7, #0x1
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x3, #0xd                // =13
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	ret
               	mov	x4, #0x0                // =0
               	orr	x5, x1, x4
               	orr	x4, x4, x0
               	add	x3, x0, x5
               	cmp	x3, x0
               	cset	x0, lo
               	add	x1, x1, x4
               	add	x4, x1, x0
               	mov	x5, #0x5576             // =21878
               	movk	x5, #0x1133, lsl #16
               	movk	x5, #0xccef, lsl #32
               	movk	x5, #0x88aa, lsl #48
               	cmp	x3, x5
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	x4, x5
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	ldr	x0, [x2]
               	mov	x1, #0x0                // =0
               	cmp	x3, x0
               	cset	x5, lo
               	sub	x3, x3, x0
               	sub	x0, x4, #0x0
               	sub	x4, x0, x5
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	mov	x17, #0x5               // =5
               	orr	x3, x3, x17
               	orr	x4, x4, x1
               	ldr	x2, [x2]
               	lsl	x2, x2, #63
               	eor	x1, x3, x1
               	eor	x2, x4, x2
               	mov	x17, #0x5505            // =21765
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x88aa, lsl #48
               	cmp	x1, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x17, #0x5576            // =21878
               	movk	x17, #0x1133, lsl #16
               	movk	x17, #0xccef, lsl #32
               	movk	x17, #0x8aa, lsl #48
               	cmp	x2, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
