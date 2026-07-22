
int128_arith.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x30
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x28
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	cmp	x1, x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x310
               	stp	x20, x21, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	sub	x0, x29, #0x98
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21]
               	orr	x3, x1, x0
               	orr	x2, x2, x1
               	sub	x0, x29, #0xb8
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x0, x29, #0xc8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	add	x3, x2, x0
               	cmp	x3, x2
               	cset	x0, lo
               	add	x2, x1, #0x0
               	add	x2, x2, x0
               	sub	x0, x29, #0xd8
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x28
               	mov	x2, #0x1                // =1
               	mov	x3, x2
               	mov	x4, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x0, [x20]
               	mov	x3, #0x0                // =0
               	cmp	x1, x0
               	cset	x4, lo
               	sub	x1, x1, x0
               	sub	x0, x2, #0x0
               	sub	x2, x0, x4
               	sub	x0, x29, #0xe8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x1, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x38
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0x2                // =2
               	mov	x4, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x2, x1, x2
               	cmp	x2, x1
               	cset	x1, lo
               	add	x0, x3, x0
               	add	x1, x0, x1
               	sub	x0, x29, #0xf8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0xccee             // =52462
               	movk	x1, #0x88aa, lsl #16
               	movk	x1, #0x4466, lsl #32
               	movk	x1, #0x22, lsl #48
               	mov	x2, #0xddfe             // =56830
               	movk	x2, #0x99bb, lsl #16
               	movk	x2, #0x5577, lsl #32
               	movk	x2, #0x1133, lsl #48
               	mov	x3, #0x3                // =3
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x20]
               	sub	x0, x29, #0x108
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x118
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x3
               	cset	x4, lo
               	sub	x1, x1, x3
               	sub	x0, x2, x0
               	sub	x2, x0, x4
               	sub	x0, x29, #0x128
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x9989             // =39305
               	movk	x1, #0xbbaa, lsl #16
               	movk	x1, #0xddcc, lsl #32
               	movk	x1, #0xffee, lsl #48
               	mov	x2, #0x1101             // =4353
               	movk	x2, #0x3322, lsl #16
               	movk	x2, #0x5544, lsl #32
               	movk	x2, #0x7766, lsl #48
               	mov	x3, #0x4                // =4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x20]
               	sub	x0, x29, #0x138
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	cmp	x2, #0x0
               	cset	x0, hi
               	sub	x2, x1, x2
               	sub	x1, x1, x1
               	sub	x1, x1, x0
               	sub	x0, x29, #0x148
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x48
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0x5                // =5
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x158
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x10
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	cmp	x0, x2
               	cset	x3, lo
               	sub	x2, x0, x2
               	sub	x0, x0, x1
               	sub	x1, x0, x3
               	sub	x0, x29, #0x168
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x9989             // =39305
               	movk	x1, #0xbbaa, lsl #16
               	movk	x1, #0xddcc, lsl #32
               	movk	x1, #0xffee, lsl #48
               	mov	x2, #0x1100             // =4352
               	movk	x2, #0x3322, lsl #16
               	movk	x2, #0x5544, lsl #32
               	movk	x2, #0x7766, lsl #48
               	mov	x3, #0x6                // =6
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mvn	x1, x1
               	mvn	x2, x0
               	sub	x0, x29, #0x178
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x9988             // =39304
               	movk	x1, #0xbbaa, lsl #16
               	movk	x1, #0xddcc, lsl #32
               	movk	x1, #0xffee, lsl #48
               	mov	x2, #0x1100             // =4352
               	movk	x2, #0x3322, lsl #16
               	movk	x2, #0x5544, lsl #32
               	movk	x2, #0x7766, lsl #48
               	mov	x3, #0x7                // =7
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	sub	x0, x29, #0x188
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	mvn	x1, x1
               	mvn	x2, x2
               	sub	x0, x29, #0x198
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	and	x1, x3, x1
               	and	x2, x4, x2
               	sub	x0, x29, #0x1a8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x44550000         // =1146421248
               	movk	x1, #0x2233, lsl #32
               	movk	x1, #0x11, lsl #48
               	mov	x2, #0xeeff             // =61183
               	movk	x2, #0xccdd, lsl #16
               	movk	x2, #0xaabb, lsl #32
               	movk	x2, #0x8899, lsl #48
               	mov	x3, #0x8                // =8
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	ldr	x2, [x20]
               	sub	x0, x29, #0x1b8
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	lsl	x2, x2, #63
               	sub	x0, x29, #0x1c8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	orr	x1, x3, x1
               	orr	x2, x4, x2
               	sub	x0, x29, #0x1d8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x6677             // =26231
               	movk	x1, #0x4455, lsl #16
               	movk	x1, #0x2233, lsl #32
               	movk	x1, #0x11, lsl #48
               	mov	x2, #0xeeff             // =61183
               	movk	x2, #0xccdd, lsl #16
               	movk	x2, #0xaabb, lsl #32
               	movk	x2, #0x8899, lsl #48
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x2, x2, x0
               	sub	x0, x29, #0x1e8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldr	x2, [x20]
               	sub	x0, x29, #0x208
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x218
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	eor	x0, x1, x1
               	eor	x1, x2, x1
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x2, x2, x0
               	sub	x0, x29, #0x228
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	ldr	x2, [x20]
               	add	x2, x1, x2
               	cmp	x2, x1
               	cset	x1, lo
               	add	x0, x0, #0x0
               	add	x1, x0, x1
               	sub	x0, x29, #0x238
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x6678             // =26232
               	movk	x1, #0x4455, lsl #16
               	movk	x1, #0x2233, lsl #32
               	movk	x1, #0x11, lsl #48
               	mov	x2, #0xeeff             // =61183
               	movk	x2, #0xccdd, lsl #16
               	movk	x2, #0xaabb, lsl #32
               	movk	x2, #0x8899, lsl #48
               	mov	x3, #0xc                // =12
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x21]
               	mov	x1, #0x0                // =0
               	ldr	x2, [x20]
               	sub	x0, x29, #0x248
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x258
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	x1, x3, x1
               	cmp	x1, x3
               	cset	x0, lo
               	add	x2, x2, #0x0
               	add	x2, x2, x0
               	sub	x0, x29, #0x268
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	ldr	x1, [x21]
               	mov	x2, #0x1                // =1
               	mov	x3, #0xd                // =13
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x58
               	ldr	x3, [x0]
               	ldr	x6, [x0, #0x8]
               	sub	x1, x29, #0x58
               	ldr	x4, [x1, #0x8]
               	mov	x2, #0x0                // =0
               	sub	x1, x29, #0x278
               	str	x4, [x1]
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x58
               	ldr	x5, [x1]
               	sub	x1, x29, #0x288
               	str	x2, [x1]
               	str	x5, [x1, #0x8]
               	orr	x4, x4, x2
               	orr	x2, x2, x5
               	sub	x1, x29, #0x298
               	str	x4, [x1]
               	str	x2, [x1, #0x8]
               	add	x1, x3, x4
               	cmp	x1, x3
               	cset	x3, lo
               	add	x2, x6, x2
               	add	x2, x2, x3
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x58
               	mov	x1, #0x5576             // =21878
               	movk	x1, #0x1133, lsl #16
               	movk	x1, #0xccef, lsl #32
               	movk	x1, #0x88aa, lsl #48
               	mov	x3, #0xe                // =14
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x58
               	ldr	x2, [x1]
               	ldr	x4, [x1, #0x8]
               	ldr	x3, [x20]
               	mov	x0, #0x0                // =0
               	cmp	x2, x3
               	cset	x5, lo
               	sub	x2, x2, x3
               	sub	x3, x4, #0x0
               	sub	x3, x3, x5
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x58
               	ldr	x5, [x1]
               	ldr	x6, [x1, #0x8]
               	mov	x3, #0xff               // =255
               	sub	x2, x29, #0x2a8
               	str	x3, [x2]
               	str	x0, [x2, #0x8]
               	mvn	x3, x3
               	mvn	x4, x0
               	sub	x2, x29, #0x2b8
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	and	x2, x5, x3
               	and	x3, x6, x4
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x58
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0x5               // =5
               	orr	x2, x2, x17
               	orr	x3, x3, x0
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x58
               	ldr	x4, [x1]
               	ldr	x5, [x1, #0x8]
               	ldr	x3, [x20]
               	sub	x2, x29, #0x2c8
               	str	x3, [x2]
               	str	x0, [x2, #0x8]
               	lsl	x3, x3, #63
               	sub	x2, x29, #0x2d8
               	str	x0, [x2]
               	str	x3, [x2, #0x8]
               	eor	x0, x4, x0
               	eor	x2, x5, x3
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x0, x29, #0x58
               	mov	x1, #0x5505             // =21765
               	movk	x1, #0x1133, lsl #16
               	movk	x1, #0xccef, lsl #32
               	movk	x1, #0x88aa, lsl #48
               	mov	x2, #0x5576             // =21878
               	movk	x2, #0x1133, lsl #16
               	movk	x2, #0xccef, lsl #32
               	movk	x2, #0x8aa, lsl #48
               	mov	x3, #0xf                // =15
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	sub	x0, x29, #0x2e8
               	str	x1, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x2, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x68
               	ldr	x2, [x0]
               	ldr	x4, [x0, #0x8]
               	mov	x5, #0x1                // =1
               	add	x3, x2, #0x1
               	cmp	x3, x2
               	cset	x2, lo
               	add	x4, x4, #0x0
               	add	x2, x4, x2
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x68
               	mov	x3, #0x10               // =16
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x5
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x2, x29, #0x2f8
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	sub	x2, x1, #0x1
               	cmp	x2, x1
               	cset	x1, lo
               	sub	x3, x3, #0x1
               	add	x1, x3, x1
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x68
               	mov	x2, #0x0                // =0
               	mov	x3, #0x11               // =17
               	mov	x16, x4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
