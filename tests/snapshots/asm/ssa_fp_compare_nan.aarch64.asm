
ssa_fp_compare_nan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
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
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fdiv	d0, d0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	bl	<addr>
               	fmov	d8, d0
               	mov	x20, #0x0               // =0
               	fmov	d17, x20
               	fcmp	d8, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x17, #0x1               // =1
               	orr	x20, x20, x17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	sxtw	x0, w20
               	mov	x17, #0x2               // =2
               	orr	x20, x0, x17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ls
               	cbz	x0, <addr>
               	sxtw	x0, w20
               	mov	x17, #0x4               // =4
               	orr	x20, x0, x17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ge
               	cbz	x0, <addr>
               	sxtw	x0, w20
               	mov	x17, #0x8               // =8
               	orr	x20, x0, x17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	sxtw	x0, w20
               	mov	x17, #0x10              // =16
               	orr	x20, x0, x17
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x0, w20
               	mov	x17, #0x20              // =32
               	orr	x20, x0, x17
               	b	<addr>
               	fcmp	d8, d8
               	cset	x0, mi
               	cbz	x0, <addr>
               	sxtw	x0, w20
               	mov	x17, #0x40              // =64
               	orr	x20, x0, x17
               	b	<addr>
               	fcmp	d8, d8
               	cset	x0, eq
               	cbz	x0, <addr>
               	sxtw	x0, w20
               	mov	x17, #0x80              // =128
               	orr	x20, x0, x17
               	b	<addr>
               	sxtw	x0, w20
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x12c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
