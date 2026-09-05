
float_condition_negative_zero.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x2, #0x0                // =0
               	fmov	d16, x2
               	fneg	d0, d16
               	fmov	d16, x2
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x17, #0x2               // =2
               	orr	x1, x1, x17
               	mov	x0, x2
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.gt	<addr>
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x17, #0x4               // =4
               	orr	x1, x1, x17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x17, #0x8               // =8
               	orr	x1, x1, x17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x17, #0x10              // =16
               	orr	x1, x1, x17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x17, #0x20              // =32
               	orr	x1, x1, x17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	mov	x0, x2
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x17, #0x40              // =64
               	orr	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
