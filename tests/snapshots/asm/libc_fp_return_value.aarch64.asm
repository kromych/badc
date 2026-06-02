
libc_fp_return_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0x120]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x130
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x130
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x148
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x14e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x155
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x130
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x130
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x1               // =1
               	stur	w15, [x29, #-0x8]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x15, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	b	<addr>
               	mov	x15, #0x999a            // =39322
               	movk	x15, #0x9999, lsl #16
               	movk	x15, #0x9999, lsl #32
               	movk	x15, #0x4005, lsl #48
               	fmov	d0, x15
               	bl	<addr>
               	fmov	x0, d0
               	mov	x15, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	b	<addr>
               	mov	x15, #0x6666            // =26214
               	movk	x15, #0x6666, lsl #16
               	movk	x15, #0x6666, lsl #32
               	movk	x15, #0x4002, lsl #48
               	fmov	d0, x15
               	bl	<addr>
               	fmov	x0, d0
               	mov	x15, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	b	<addr>
               	mov	x20, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	x16, d7
               	fmov	d0, x16
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	<addr>
               	mov	x20, #0x401c000000000000 // =4619567317775286272
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	<addr>
               	ldursw	x20, [x29, #-0x8]
               	cbz	x20, <addr>
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
