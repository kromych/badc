
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
               	mov	x1, #0x0                // =0
               	str	w1, [x2]
               	sub	x0, x29, #0x48
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	w1, [x0, #0x40]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	add	x4, x4, #0x1
               	str	w4, [x3]
               	mov	x3, #0xb                // =11
               	str	w3, [x0]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x4]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x8]
               	ldr	w3, [x0]
               	str	w3, [x0, #0xc]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x10]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x14]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x18]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x1c]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x20]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x24]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x28]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x2c]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x30]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x34]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x38]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x3c]
               	ldr	w3, [x0]
               	str	w3, [x0, #0x40]
               	ldrsw	x0, [x2]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, x0, lsl #2]
               	cmp	x2, #0xb
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x11
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
               	cmp	x1, #0x2
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
               	sub	sp, sp, #0x60
               	mov	x2, #0xc                // =12
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x4]
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
               	stur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	scvtf	d0, x2
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x3
               	fdiv	d1, d0, d17
               	sub	x17, x29, #0x28
               	str	d1, [x17]
               	ldur	x1, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	sub	x1, x29, #0x58
               	str	x0, [x1]
               	str	w0, [x1, #0x8]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x5]
               	add	x6, x6, #0x1
               	str	w6, [x5]
               	scvtf	s2, x2
               	mov	x5, #0x40800000         // =1082130432
               	fmov	s17, w5
               	fdiv	s2, s2, s17
               	str	s2, [x1]
               	ldr	w5, [x1]
               	str	w5, [x1, #0x4]
               	str	w5, [x1, #0x8]
               	ldrsw	x1, [x4]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	sub	x16, x29, #0x30
               	ldr	d2, [x16]
               	fmov	d17, x0
               	fcmp	d2, d17
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	sub	x16, x29, #0x28
               	ldr	d2, [x16]
               	fcmp	d2, d1
               	cset	x4, ne
               	cbnz	x4, <addr>
               	sub	x16, x29, #0x20
               	ldr	d2, [x16]
               	fcmp	d2, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x58
               	ldr	s2, [x1]
               	scvtf	s0, x2
               	mov	x3, #0x40800000         // =1082130432
               	fmov	s17, w3
               	fdiv	s1, s0, s17
               	fcmp	s2, s1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	s2, [x1, #0x8]
               	fcmp	s2, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x4, x1
               	b	<addr>

<check_deferred>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x4]
               	sub	x0, x29, #0x48
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	w1, [x0, #0x40]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	mov	x2, #0x13               // =19
               	str	w2, [x0]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x4]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x8]
               	ldr	w2, [x0]
               	str	w2, [x0, #0xc]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x10]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x14]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x18]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x1c]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x20]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x24]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x28]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x2c]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x30]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x34]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x38]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x3c]
               	ldr	w2, [x0]
               	str	w2, [x0, #0x40]
               	ldrsw	x0, [x4]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x2, x29, #0x48
               	ldr	w2, [x2, x0, lsl #2]
               	cmp	x2, #0x13
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x11
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
