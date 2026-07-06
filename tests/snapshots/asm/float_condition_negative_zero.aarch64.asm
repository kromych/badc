
float_condition_negative_zero.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x1, #0x0                // =0
               	fmov	d16, x1
               	fneg	d0, d16
               	fmov	d16, x1
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d1, d0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x17, #0x2               // =2
               	orr	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	add	x2, x2, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x2
               	b.le	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x4               // =4
               	orr	x1, x1, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x8               // =8
               	orr	x1, x1, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	sxtw	x0, w2
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x17, #0x10              // =16
               	orr	x1, x1, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	cbz	x2, <addr>
               	mov	x17, #0x20              // =32
               	orr	x1, x1, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x17, #0x40              // =64
               	orr	x1, x1, x17
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
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
