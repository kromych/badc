
runtime_range_designator.aarch64:	file format elf64-littleaarch64

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

<check_once_eval>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	sub	x1, x29, #0x48
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	str	wzr, [x1, #0x40]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	add	x4, x4, #0x1
               	str	w4, [x3]
               	mov	x3, #0xb                // =11
               	str	w3, [x1]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x4]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x8]
               	ldr	w3, [x1]
               	str	w3, [x1, #0xc]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x10]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x14]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x18]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x1c]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x20]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x24]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x28]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x2c]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x30]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x34]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x38]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x3c]
               	ldr	w3, [x1]
               	str	w3, [x1, #0x40]
               	ldrsw	x1, [x2]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, w0, sxtw #2]
               	cmp	w1, #0xb
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x11
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_resume_and_gap>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<check_override>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	ret
               	mov	x0, x1
               	ret

<check_widths>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x2, #0xc                // =12
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x5]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	stur	x0, [x29, #-0x18]
               	stur	x0, [x29, #-0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	scvtf	d0, x2
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x3
               	fdiv	d1, d0, d17
               	stur	d1, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	stur	x1, [x29, #-0x10]
               	sub	x1, x29, #0x30
               	str	xzr, [x1]
               	str	wzr, [x1, #0x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x6, [x4]
               	add	x6, x6, #0x1
               	str	w6, [x4]
               	scvtf	s2, x2
               	mov	x4, #0x40800000         // =1082130432
               	fmov	s17, w4
               	fdiv	s3, s2, s17
               	str	s3, [x1]
               	ldr	w6, [x1]
               	str	w6, [x1, #0x8]
               	ldrsw	x5, [x5]
               	cmp	w5, #0x5
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	ldur	d4, [x29, #-0x18]
               	fcmp	d4, d1
               	b.ne	<addr>
               	ldur	d4, [x29, #-0x10]
               	fcmp	d4, d1
               	b.ne	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	s0, [x1]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldr	s0, [x1, #0x8]
               	fcmp	s0, s3
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_deferred>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x3]
               	sub	x1, x29, #0x48
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	str	wzr, [x1, #0x40]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x2]
               	add	x4, x4, #0x1
               	str	w4, [x2]
               	mov	x2, #0x13               // =19
               	str	w2, [x1]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x4]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x8]
               	ldr	w2, [x1]
               	str	w2, [x1, #0xc]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x10]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x14]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x18]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x1c]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x20]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x24]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x28]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x2c]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x30]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x34]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x38]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x3c]
               	ldr	w2, [x1]
               	str	w2, [x1, #0x40]
               	ldrsw	x1, [x3]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x48
               	ldr	w1, [x1, w0, sxtw #2]
               	cmp	w1, #0x13
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x11
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
