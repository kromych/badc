
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
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
               	ldrsw	x1, [x2]
               	add	x1, x1, #0x1
               	str	w1, [x2]
               	mov	x1, #0xb                // =11
               	stur	w1, [x29, #-0x48]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x44]
               	stur	w1, [x29, #-0x40]
               	stur	w1, [x29, #-0x3c]
               	stur	w1, [x29, #-0x38]
               	stur	w1, [x29, #-0x34]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x30]
               	stur	w1, [x29, #-0x2c]
               	stur	w1, [x29, #-0x28]
               	stur	w1, [x29, #-0x24]
               	stur	w1, [x29, #-0x20]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x1c]
               	stur	w1, [x29, #-0x18]
               	stur	w1, [x29, #-0x14]
               	stur	w1, [x29, #-0x10]
               	stur	w1, [x29, #-0xc]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x8]
               	ldrsw	x1, [x2]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	cbz	x0, <addr>
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x2, #0x66               // =102
               	cbz	x2, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w0, [x1]
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	stur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x40]
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	fmov	d0, #12.00000000
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	stur	d0, [x29, #-0x48]
               	ldur	x2, [x29, #-0x48]
               	stur	x2, [x29, #-0x40]
               	sub	x2, x29, #0x68
               	str	xzr, [x2]
               	str	wzr, [x2, #0x8]
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	fmov	s1, #12.00000000
               	fmov	s2, #4.00000000
               	fdiv	s1, s1, s2
               	stur	s1, [x29, #-0x68]
               	ldur	w2, [x29, #-0x68]
               	stur	w2, [x29, #-0x60]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	cbz	x0, <addr>
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	ldrsw	x1, [x2]
               	add	x1, x1, #0x1
               	str	w1, [x2]
               	mov	x1, #0x13               // =19
               	stur	w1, [x29, #-0x48]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x44]
               	stur	w1, [x29, #-0x40]
               	stur	w1, [x29, #-0x3c]
               	stur	w1, [x29, #-0x38]
               	stur	w1, [x29, #-0x34]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x30]
               	stur	w1, [x29, #-0x2c]
               	stur	w1, [x29, #-0x28]
               	stur	w1, [x29, #-0x24]
               	stur	w1, [x29, #-0x20]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x1c]
               	stur	w1, [x29, #-0x18]
               	stur	w1, [x29, #-0x14]
               	stur	w1, [x29, #-0x10]
               	stur	w1, [x29, #-0xc]
               	ldur	w1, [x29, #-0x48]
               	stur	w1, [x29, #-0x8]
               	ldrsw	x1, [x2]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	cbz	x0, <addr>
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x48
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, #0x13
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x11
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	ldur	d2, [x29, #-0x48]
               	fcmp	d2, d0
               	b.ne	<addr>
               	ldur	d2, [x29, #-0x40]
               	fcmp	d2, d0
               	b.ne	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	ldur	s0, [x29, #-0x68]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x60]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, #0xb
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x11
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
