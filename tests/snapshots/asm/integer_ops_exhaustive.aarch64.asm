
integer_ops_exhaustive.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	mov	x21, #0x1               // =1
               	b	<addr>
               	cmp	x20, x21
               	cset	x13, hi
               	cmp	x13, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	adrp	x1, <page>
               	add	x1, x1, #0x15a
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x11, lo
               	cmp	x11, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x16d
               	adrp	x1, <page>
               	add	x1, x1, #0x177
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x11, hs
               	cmp	x11, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x18a
               	adrp	x1, <page>
               	add	x1, x1, #0x194
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x11, ls
               	cmp	x11, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	adrp	x1, <page>
               	add	x1, x1, #0x1b2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x11, ne
               	cmp	x11, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1c6
               	adrp	x1, <page>
               	add	x1, x1, #0x1d0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x20, eq
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x23, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1e4
               	adrp	x1, <page>
               	add	x1, x1, #0x1ee
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x22, x23
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x202
               	adrp	x1, <page>
               	add	x1, x1, #0x20c
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x23, x22
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x217
               	adrp	x0, <page>
               	add	x0, x0, #0x221
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x22, x23
               	cset	x20, le
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x22c
               	adrp	x1, <page>
               	add	x1, x1, #0x236
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x23, x22
               	cset	x23, ge
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x21, #0xfffe            // =65534
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x242
               	adrp	x1, <page>
               	add	x1, x1, #0x24c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, hi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x23, <page>
               	add	x23, x23, #0x258
               	adrp	x1, <page>
               	add	x1, x1, #0x262
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x20
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x26f
               	adrp	x0, <page>
               	add	x0, x0, #0x279
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x21
               	cset	x20, lo
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x1, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x287
               	adrp	x1, <page>
               	add	x1, x1, #0x291
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x1, x22
               	cset	x1, gt
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x29e
               	adrp	x1, <page>
               	add	x1, x1, #0x2a8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x22, #0x0
               	cset	x22, lt
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x23, #0xfe              // =254
               	mov	x22, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2b3
               	adrp	x1, <page>
               	add	x1, x1, #0x2bd
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x23, x22
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x2c8
               	adrp	x1, <page>
               	add	x1, x1, #0x2d2
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x22, x23
               	cset	x22, lt
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x23, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2de
               	adrp	x1, <page>
               	add	x1, x1, #0x2e8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x20, x23
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x2f4
               	adrp	x1, <page>
               	add	x1, x1, #0x2fe
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x23, x20
               	cset	x23, gt
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0x64              // =100
               	stur	w20, [x29, #-0x68]
               	sub	x1, x29, #0x68
               	ldr	w20, [x1]
               	add	x20, x20, #0x5
               	str	w20, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x308
               	adrp	x1, <page>
               	add	x1, x1, #0x312
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w0, [x29, #-0x68]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x20, x29, #0x68
               	ldr	w0, [x20]
               	sub	x0, x0, #0xa
               	str	w0, [x20]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x31c
               	adrp	x0, <page>
               	add	x0, x0, #0x326
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w1, [x29, #-0x68]
               	mov	x17, #0x5f              // =95
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x20, x29, #0x68
               	ldr	w1, [x20]
               	lsl	x1, x1, #1
               	str	w1, [x20]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x32f
               	adrp	x1, <page>
               	add	x1, x1, #0x339
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w0, [x29, #-0x68]
               	mov	x17, #0xbe              // =190
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x68
               	ldr	w1, [x0]
               	mov	x20, #0x5               // =5
               	udiv	x1, x1, x20
               	str	w1, [x0]
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x343
               	adrp	x1, <page>
               	add	x1, x1, #0x34d
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w20, [x29, #-0x68]
               	mov	x17, #0x26              // =38
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x20, x29, #0x68
               	ldr	w1, [x20]
               	mov	x0, #0x7                // =7
               	udiv	x17, x1, x0
               	msub	x1, x17, x0, x1
               	str	w1, [x20]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x356
               	adrp	x1, <page>
               	add	x1, x1, #0x360
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w0, [x29, #-0x68]
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	x0, x0, #0x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x369
               	adrp	x1, <page>
               	add	x1, x1, #0x373
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0x3e8             // =1000
               	stur	x20, [x29, #-0x78]
               	sub	x0, x29, #0x78
               	ldr	x20, [x0]
               	add	x20, x20, #0x19f
               	str	x20, [x0]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x37c
               	adrp	x0, <page>
               	add	x0, x0, #0x386
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x20, [x29, #-0x78]
               	cmp	x20, #0x587
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x20, x29, #0x78
               	ldr	x1, [x20]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	str	x1, [x20]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x394
               	adrp	x1, <page>
               	add	x1, x1, #0x39e
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x1, [x29, #-0x78]
               	mov	x17, #0x1095            // =4245
               	cmp	x1, x17
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x20, x29, #0x78
               	ldr	x1, [x20]
               	mov	x0, #0x5                // =5
               	udiv	x1, x1, x0
               	str	x1, [x20]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3a9
               	adrp	x1, <page>
               	add	x1, x1, #0x3b3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x1, [x29, #-0x78]
               	cmp	x1, #0x351
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0xff00            // =65280
               	movk	x20, #0xff00, lsl #16
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x1, x20, x17
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xf, lsl #16
               	orr	x21, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x24, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3bc
               	adrp	x1, <page>
               	add	x1, x1, #0x3c6
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	mov	x17, #0xf00             // =3840
               	movk	x17, #0xf00, lsl #16
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3cf
               	adrp	x1, <page>
               	add	x1, x1, #0x3d9
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xff0f, lsl #16
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3df
               	adrp	x1, <page>
               	add	x1, x1, #0x3e9
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3ef
               	adrp	x1, <page>
               	add	x1, x1, #0x3f9
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x10, #0x5678            // =22136
               	movk	x10, #0x1234, lsl #16
               	lsl	x10, x10, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x10, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3ff
               	adrp	x1, <page>
               	add	x1, x1, #0x409
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x10, x17
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	eor	x10, x10, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x10, x17
               	cmp	x10, #0x0
               	cset	x10, eq
               	cmp	x10, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x10, #0x1               // =1
               	lsl	x10, x10, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x10, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x40f
               	adrp	x1, <page>
               	add	x1, x1, #0x419
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x10, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x10, x17
               	cset	x10, eq
               	cmp	x10, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x10, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x422
               	adrp	x1, <page>
               	add	x1, x1, #0x42c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	lsl	x10, x10, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x10, x17
               	cset	x10, eq
               	cmp	x10, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x23, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x436
               	adrp	x1, <page>
               	add	x1, x1, #0x440
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x22, x17
               	cmp	x0, x23
               	cset	x0, hi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x44a
               	adrp	x1, <page>
               	add	x1, x1, #0x454
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x23, w23
               	cmp	x22, x23
               	cset	x22, lt
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	stur	w23, [x29, #-0xe0]
               	sub	x1, x29, #0xe0
               	ldr	w23, [x1]
               	add	x23, x23, #0x1
               	str	w23, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x460
               	adrp	x1, <page>
               	add	x1, x1, #0x46a
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w0, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x23, x29, #0xe0
               	ldr	w0, [x23]
               	add	x0, x0, #0x1
               	str	w0, [x23]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x475
               	adrp	x0, <page>
               	add	x0, x0, #0x47f
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w1, [x29, #-0xe0]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x23, #0xfe              // =254
               	sturb	w23, [x29, #-0xe8]
               	sub	x1, x29, #0xe8
               	ldrb	w23, [x1]
               	add	x23, x23, #0x1
               	strb	w23, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x48e
               	adrp	x1, <page>
               	add	x1, x1, #0x498
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldurb	w0, [x29, #-0xe8]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x23, x29, #0xe8
               	ldrb	w0, [x23]
               	add	x0, x0, #0x1
               	strb	w0, [x23]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x4aa
               	adrp	x0, <page>
               	add	x0, x0, #0x4b4
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldurb	w1, [x29, #-0xe8]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	stur	x23, [x29, #-0xf0]
               	sub	x1, x29, #0xf0
               	ldr	x23, [x1]
               	add	x23, x23, #0x1
               	str	x23, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4c7
               	adrp	x1, <page>
               	add	x1, x1, #0x4d1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x23, [x29, #-0xf0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x23, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x23, x29, #0xf0
               	ldr	x1, [x23]
               	add	x1, x1, #0x1
               	str	x1, [x23]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4e2
               	adrp	x1, <page>
               	add	x1, x1, #0x4ec
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x1, [x29, #-0xf0]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4fb
               	adrp	x1, <page>
               	add	x1, x1, #0x505
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x517
               	adrp	x1, <page>
               	add	x1, x1, #0x521
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x52c
               	adrp	x1, <page>
               	add	x1, x1, #0x536
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x544
               	adrp	x1, <page>
               	add	x1, x1, #0x54e
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x55a
               	adrp	x1, <page>
               	add	x1, x1, #0x564
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x570
               	adrp	x1, <page>
               	add	x1, x1, #0x57a
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x586
               	adrp	x1, <page>
               	add	x1, x1, #0x590
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x5a4
               	adrp	x1, <page>
               	add	x1, x1, #0x5ae
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x5ba
               	adrp	x1, <page>
               	add	x1, x1, #0x5c4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
