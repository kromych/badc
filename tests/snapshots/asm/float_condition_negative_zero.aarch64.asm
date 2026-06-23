
float_condition_negative_zero.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x0               // =0
               	fmov	d16, x20
               	fneg	d8, d16
               	fmov	d16, x20
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	fmov	d17, x20
               	fcmp	d8, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x17, #0x1               // =1
               	orr	x20, x20, x17
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	fcmp	d0, d8
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x17, #0x2               // =2
               	orr	x20, x20, x17
               	mov	x21, #0x0               // =0
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	add	x21, x21, #0x1
               	sxtw	x0, w21
               	cmp	x0, #0x2
               	b.le	<addr>
               	b	<addr>
               	sxtw	x0, w21
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x4               // =4
               	orr	x20, x20, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x8               // =8
               	orr	x20, x20, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x17, #0x10              // =16
               	orr	x20, x20, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x21, ne
               	cbz	x21, <addr>
               	mov	x21, #0x1               // =1
               	cbz	x21, <addr>
               	mov	x17, #0x20              // =32
               	orr	x20, x20, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x21, ne
               	cbnz	x21, <addr>
               	mov	x21, #0x0               // =0
               	cbz	x21, <addr>
               	mov	x17, #0x40              // =64
               	orr	x20, x20, x17
               	sxtw	x0, w20
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
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
               	b	<addr>
               	b	<addr>
