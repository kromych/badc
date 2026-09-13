
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
               	b	<addr>
               	sub	x2, x29, #0x48
               	sxtw	x1, w0
               	ldrsw	x2, [x2, x1, lsl #2]
               	cmp	w2, #0xb
               	b.ne	<addr>
               	add	x0, x1, #0x1
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
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	ret

<check_override>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
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
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	ret
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	ret

<check_widths>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x3, #0xc                // =12
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x6]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x2]
               	add	x4, x4, #0x1
               	str	w4, [x2]
               	scvtf	d0, x3
               	mov	x4, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x4
               	fdiv	d1, d0, d17
               	str	d1, [x0, #0x8]
               	ldr	x2, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	sub	x2, x29, #0x30
               	str	xzr, [x2]
               	str	wzr, [x2, #0x8]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x7, [x5]
               	add	x7, x7, #0x1
               	str	w7, [x5]
               	scvtf	s2, x3
               	mov	x5, #0x40800000         // =1082130432
               	fmov	s17, w5
               	fdiv	s3, s2, s17
               	str	s3, [x2]
               	ldr	w7, [x2]
               	str	w7, [x2, #0x4]
               	str	w7, [x2, #0x8]
               	ldrsw	x2, [x6]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x1
               	mov	x2, x1
               	mov	x2, x1
               	mov	x2, x1
               	mov	x2, x1
               	mov	x2, x1
               	ldr	d4, [x0]
               	fmov	d17, x1
               	fcmp	d4, d17
               	b.ne	<addr>
               	ldr	d4, [x0, #0x8]
               	fcmp	d4, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	d4, [x0, #0x10]
               	fcmp	d4, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	d0, [x0, #0x18]
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	s0, [x0]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldr	s0, [x0, #0x8]
               	fcmp	s0, s3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_deferred>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x4]
               	sub	x1, x29, #0x48
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	str	wzr, [x1, #0x40]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
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
               	ldrsw	x1, [x4]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x2, x29, #0x48
               	sxtw	x1, w0
               	ldr	w2, [x2, x1, lsl #2]
               	cmp	w2, #0x13
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x11
               	b.lt	<addr>
               	ldrsw	x0, [x4]
               	add	x0, x0, #0x1
               	str	w0, [x4]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
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
