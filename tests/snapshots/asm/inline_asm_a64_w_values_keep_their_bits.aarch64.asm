
inline_asm_a64_w_values_keep_their_bits.aarch64:	file format elf64-littleaarch64

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

<run>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	fmov	d0, #2.50000000
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x18]
               	fmov	d0, d0
               	mov	x0, v0.d[0]
               	add	x0, x0, #0x1
               	mov	x17, #0x1               // =1
               	movk	x17, #0x4004, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4b               // =75
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x10]
               	fmov	s0, s0
               	fmov	s0, s0
               	smov	x0, v0.s[0]
               	eor	x0, x0, #0x1
               	mov	x17, #0x1               // =1
               	movk	x17, #0x3f80, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4d               // =77
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x18]
               	str	d0, [sp]
               	mov	x16, #0x3fe0000000000000 // =4602678819172646912
               	str	x16, [sp, #0x8]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	fmul	d0, d0, d1
               	fmov	d1, #1.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4e               // =78
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s1, [x29, #-0x10]
               	str	d1, [sp]
               	mov	x16, #0x40400000        // =1077936128
               	str	x16, [sp, #0x8]
               	ldr	d1, [sp]
               	ldr	d2, [sp, #0x8]
               	fmul	s0, s1, s2
               	fmov	s1, #1.00000000
               	fadd	s0, s0, s1
               	fmov	s2, #4.00000000
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x4f               // =79
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	fadd	v3.2s, v0.2s, v0.2s
               	mov	x0, v3.d[0]
               	mov	x17, #0x40400000        // =1077936128
               	movk	x17, #0xc080, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x52               // =82
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fadd	v3.2s, v0.2s, v1.2s
               	mov	s3, v3.s[1]
               	fmov	s4, #2.00000000
               	fcmp	s3, s4
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	fmul	v3.2s, v0.2s, v0.2s
               	stur	d3, [x29, #-0x20]
               	ldur	s3, [x29, #-0x20]
               	fmov	s4, #2.25000000
               	fcmp	s3, s4
               	b.ne	<addr>
               	ldur	s3, [x29, #-0x1c]
               	fcmp	s3, s2
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, d0
               	fneg	v2.2s, v2.2s
               	fneg	v2.2s, v2.2s
               	fadd	v2.2s, v2.2s, v2.2s
               	mov	s3, v2.s[0]
               	fmov	s4, #3.00000000
               	fcmp	s3, s4
               	b.ne	<addr>
               	mov	s2, v2.s[1]
               	fmov	s3, #-4.00000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	sub	x0, x29, #0x30
               	fadd	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x30]
               	ldr	d2, [x0]
               	mov	s3, v2.s[0]
               	mov	s2, v2.s[1]
               	fadd	s2, s3, s2
               	fmov	d3, d2
               	fmov	s4, #3.75000000
               	fcmp	s3, s4
               	b.ne	<addr>
               	fmov	s3, #3.75000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	mov	x0, #0x5b               // =91
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x30
               	fadd	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x30]
               	ldr	d2, [x1]
               	mov	s3, v2.s[0]
               	mov	s2, v2.s[1]
               	fadd	s2, s3, s2
               	fmov	d3, d2
               	fmov	s4, #-4.75000000
               	fcmp	s3, s4
               	b.ne	<addr>
               	fmov	s3, #-4.75000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	mov	x0, #0x5e               // =94
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v2.2s, v0.2s, v1.2s
               	mov	x1, v2.d[0]
               	mov	x17, #0x3ec00000        // =1052770304
               	movk	x17, #0xc100, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x62               // =98
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v16.16b, v0.16b
               	fmla	v16.2s, v0.2s, v1.2s
               	mov	v0.16b, v16.16b
               	stur	d0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x20]
               	fmov	s1, #1.87500000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x1c]
               	fmov	s1, #-10.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x18]
               	fadd	d0, d0, d0
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	fsub	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x20]
               	b	<addr>
               	sub	x0, x29, #0x20
               	fsub	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x20]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldp	x29, x30, [sp], #0x10
               	b	<addr>
