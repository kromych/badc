
runtime_range_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<check_once_eval>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	sub	x0, x29, #0x48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x2, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x2, #0x38]
               	str	x10, [x0, #0x38]
               	ldrb	w10, [x2, #0x40]
               	strb	w10, [x0, #0x40]
               	ldrb	w10, [x2, #0x41]
               	strb	w10, [x0, #0x41]
               	ldrb	w10, [x2, #0x42]
               	strb	w10, [x0, #0x42]
               	ldrb	w10, [x2, #0x43]
               	strb	w10, [x0, #0x43]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x0, #0xb                // =11
               	sub	x2, x29, #0x48
               	str	w0, [x2]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0xc]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x10]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x14]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x18]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x1c]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x20]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x24]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x28]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x2c]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x30]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x34]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x38]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x3c]
               	sub	x0, x29, #0x48
               	ldr	w2, [x0]
               	str	w2, [x0, #0x40]
               	ldrsw	x0, [x1]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, x1, lsl #2]
               	cmp	x2, #0xb
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x11
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<check_resume_and_gap>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret

<check_override>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret

<check_widths>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x1, #0xc                // =12
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	sub	x0, x29, #0x18
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	mov	x3, #0x41               // =65
               	sub	x0, x29, #0x18
               	strb	w3, [x0, #0x2]
               	sub	x0, x29, #0x18
               	mov	x3, #0x41               // =65
               	strb	w3, [x0, #0x3]
               	sub	x0, x29, #0x18
               	mov	x3, #0x41               // =65
               	strb	w3, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x3, #0x41               // =65
               	strb	w3, [x0, #0x5]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	sub	x0, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	mov	x0, #0xc                // =12
               	scvtf	d0, x0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	sub	x0, x29, #0x60
               	str	d0, [x0, #0x8]
               	sub	x0, x29, #0x60
               	ldr	x3, [x0, #0x8]
               	str	x3, [x0, #0x10]
               	sub	x0, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	mov	x0, #0xc                // =12
               	scvtf	s0, x0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s0, s0, s17
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x0, x29, #0x10
               	ldr	w3, [x0]
               	str	w3, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldr	w3, [x0]
               	str	w3, [x0, #0x8]
               	ldrsw	x0, [x2]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x2, #0x0                // =0
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0, #0x6]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x60
               	mov	x2, #0x0                // =0
               	ldr	d0, [x0]
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	ldr	d0, [x0, #0x8]
               	scvtf	d1, x1
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fdiv	d1, d1, d17
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x60
               	ldr	d0, [x0, #0x10]
               	scvtf	d1, x1
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fdiv	d1, d1, d17
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	ldr	d0, [x0, #0x18]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	s0, [x0]
               	scvtf	s1, x1
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s1, s1, s17
               	fcmp	s0, s1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	scvtf	s1, x1
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s1, s1, s17
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
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

<check_deferred>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x4]
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldrb	w10, [x1, #0x40]
               	strb	w10, [x0, #0x40]
               	ldrb	w10, [x1, #0x41]
               	strb	w10, [x0, #0x41]
               	ldrb	w10, [x1, #0x42]
               	strb	w10, [x0, #0x42]
               	ldrb	w10, [x1, #0x43]
               	strb	w10, [x0, #0x43]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x13               // =19
               	sub	x1, x29, #0x48
               	str	w0, [x1]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x10]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x14]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x18]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x1c]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x24]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x28]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x2c]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x34]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x38]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x3c]
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	str	w1, [x0, #0x40]
               	ldrsw	x0, [x4]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x48
               	ldr	w2, [x2, x1, lsl #2]
               	cmp	x2, #0x13
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x11
               	b.lt	<addr>
               	ldrsw	x0, [x4]
               	add	x0, x0, #0x1
               	str	w0, [x4]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

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
