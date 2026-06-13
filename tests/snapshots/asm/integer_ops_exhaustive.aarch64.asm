
integer_ops_exhaustive.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	mov	x21, #0x1               // =1
               	cmp	x20, x21
               	cset	x0, hi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	adrp	x1, <page>
               	add	x1, x1, #0x126
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, lo
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x139
               	adrp	x1, <page>
               	add	x1, x1, #0x143
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x156
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, ls
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x174
               	adrp	x1, <page>
               	add	x1, x1, #0x17e
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x192
               	adrp	x1, <page>
               	add	x1, x1, #0x19c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	adrp	x1, <page>
               	add	x1, x1, #0x1ba
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1ce
               	adrp	x1, <page>
               	add	x1, x1, #0x1d8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1e3
               	adrp	x1, <page>
               	add	x1, x1, #0x1ed
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, le
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1f8
               	adrp	x1, <page>
               	add	x1, x1, #0x202
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, ge
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x20e
               	adrp	x1, <page>
               	add	x1, x1, #0x218
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, hi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x224
               	adrp	x1, <page>
               	add	x1, x1, #0x22e
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x23b
               	adrp	x1, <page>
               	add	x1, x1, #0x245
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, lo
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x253
               	adrp	x1, <page>
               	add	x1, x1, #0x25d
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x0, x20
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x26a
               	adrp	x1, <page>
               	add	x1, x1, #0x274
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, #0x0
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0xfe              // =254
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x27f
               	adrp	x1, <page>
               	add	x1, x1, #0x289
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x294
               	adrp	x1, <page>
               	add	x1, x1, #0x29e
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2aa
               	adrp	x1, <page>
               	add	x1, x1, #0x2b4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2c0
               	adrp	x1, <page>
               	add	x1, x1, #0x2ca
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	add	x20, x0, #0x5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2d4
               	adrp	x1, <page>
               	add	x1, x1, #0x2de
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w20
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	w0, w20
               	sub	x20, x0, #0xa
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2e8
               	adrp	x1, <page>
               	add	x1, x1, #0x2f2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w20
               	mov	x17, #0x5f              // =95
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	w0, w20
               	lsl	x20, x0, #1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2fb
               	adrp	x1, <page>
               	add	x1, x1, #0x305
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w20
               	mov	x17, #0xbe              // =190
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	w0, w20
               	mov	x1, #0x5                // =5
               	udiv	x20, x0, x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x30f
               	adrp	x1, <page>
               	add	x1, x1, #0x319
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w20
               	mov	x17, #0x26              // =38
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	w0, w20
               	mov	x1, #0x7                // =7
               	udiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x322
               	adrp	x1, <page>
               	add	x1, x1, #0x32c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	x0, x0, #0x2
               	mov	w0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x335
               	adrp	x1, <page>
               	add	x1, x1, #0x33f
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x3e8              // =1000
               	add	x20, x0, #0x19f
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x348
               	adrp	x1, <page>
               	add	x1, x1, #0x352
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, #0x587
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x20, x20, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x360
               	adrp	x1, <page>
               	add	x1, x1, #0x36a
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0x1095            // =4245
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x5                // =5
               	udiv	x0, x20, x0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x375
               	adrp	x1, <page>
               	add	x1, x1, #0x37f
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x0, #0x351
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xff00             // =65280
               	movk	x0, #0xff00, lsl #16
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x1, x0, x17
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xf, lsl #16
               	orr	x20, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x21, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	mov	w22, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x388
               	adrp	x1, <page>
               	add	x1, x1, #0x392
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w1
               	mov	x17, #0xf00             // =3840
               	movk	x17, #0xf00, lsl #16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x39b
               	adrp	x1, <page>
               	add	x1, x1, #0x3a5
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w20
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xff0f, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3ab
               	adrp	x1, <page>
               	add	x1, x1, #0x3b5
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w21
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3bb
               	adrp	x1, <page>
               	add	x1, x1, #0x3c5
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w22
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	lsl	x0, x0, #4
               	mov	w0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3cb
               	adrp	x1, <page>
               	add	x1, x1, #0x3d5
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w0
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	lsl	x0, x0, #31
               	mov	w0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3db
               	adrp	x1, <page>
               	add	x1, x1, #0x3e5
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w0
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3ee
               	adrp	x1, <page>
               	add	x1, x1, #0x3f8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	lsl	x0, x0, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x402
               	adrp	x1, <page>
               	add	x1, x1, #0x40c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w20
               	cmp	x0, x21
               	cset	x0, hi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x416
               	adrp	x1, <page>
               	add	x1, x1, #0x420
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w21
               	cmp	x20, x0
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	add	x20, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x42c
               	adrp	x1, <page>
               	add	x1, x1, #0x436
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	w0, w20
               	add	x0, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x441
               	adrp	x1, <page>
               	add	x1, x1, #0x44b
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xfe               // =254
               	add	x20, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x45a
               	adrp	x1, <page>
               	add	x1, x1, #0x464
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x20, x17
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x20, x17
               	add	x0, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x476
               	adrp	x1, <page>
               	add	x1, x1, #0x480
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	add	x20, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x493
               	adrp	x1, <page>
               	add	x1, x1, #0x49d
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	add	x0, x20, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4ae
               	adrp	x1, <page>
               	add	x1, x1, #0x4b8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4c7
               	adrp	x1, <page>
               	add	x1, x1, #0x4d1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4e3
               	adrp	x1, <page>
               	add	x1, x1, #0x4ed
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4f8
               	adrp	x1, <page>
               	add	x1, x1, #0x502
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x510
               	adrp	x1, <page>
               	add	x1, x1, #0x51a
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x526
               	adrp	x1, <page>
               	add	x1, x1, #0x530
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x53c
               	adrp	x1, <page>
               	add	x1, x1, #0x546
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x552
               	adrp	x1, <page>
               	add	x1, x1, #0x55c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x570
               	adrp	x1, <page>
               	add	x1, x1, #0x57a
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x586
               	adrp	x1, <page>
               	add	x1, x1, #0x590
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
