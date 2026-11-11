
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
               	sub	sp, sp, #0x70
               	fmov	d0, #2.50000000
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x18]
               	fmov	d0, d0
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	add	x0, x0, #0x1
               	mov	x17, #0x1               // =1
               	movk	x17, #0x4004, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4b               // =75
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x10]
               	fmov	s0, s0
               	stur	s0, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x40]
               	eor	x0, x0, #0x1
               	mov	x17, #0x1               // =1
               	movk	x17, #0x3f80, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4d               // =77
               	add	sp, sp, #0x70
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
               	add	sp, sp, #0x70
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
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4f               // =79
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x60]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	mov	x17, #0x8               // =8
               	add	x16, x16, x17
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	ldur	x1, [x29, #-0x48]
               	stur	x1, [x29, #-0x58]
               	sub	x1, x29, #0x60
               	ldur	d0, [x29, #-0x60]
               	fadd	v0.2s, v0.2s, v0.2s
               	stur	d0, [x29, #-0x20]
               	ldur	x2, [x29, #-0x20]
               	mov	x17, #0x40400000        // =1077936128
               	movk	x17, #0xc080, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x52               // =82
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x58]
               	fadd	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x1c]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x28
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldur	d0, [x29, #-0x60]
               	fmul	v0.2s, v0.2s, v0.2s
               	stur	d0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x20]
               	fmov	s1, #2.25000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x1c]
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	d0, [x29, #-0x48]
               	str	d0, [sp]
               	ldr	d0, [sp]
               	fneg	v0.2s, v0.2s
               	stur	d0, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	sub	x1, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x40]
               	str	d0, [sp]
               	ldr	d0, [sp]
               	fneg	v0.2s, v0.2s
               	fadd	v0.2s, v0.2s, v0.2s
               	stur	d0, [x29, #-0x40]
               	ldur	x1, [x29, #-0x40]
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	ldur	s0, [x29, #-0x20]
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x1c]
               	fmov	s1, #-4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x58]
               	cbz	x1, <addr>
               	sub	x0, x29, #0x30
               	fadd	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x30]
               	sub	x1, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x38]
               	ldur	s1, [x29, #-0x34]
               	fadd	s0, s0, s1
               	dup	v0.2s, v0.s[0]
               	stur	d0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x50]
               	ldur	s0, [x29, #-0x50]
               	fmov	s1, #3.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x4c]
               	fmov	s1, #3.75000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5b               // =91
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x58]
               	cbz	x0, <addr>
               	sub	x0, x29, #0x30
               	fadd	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x30]
               	sub	x1, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x38]
               	ldur	s1, [x29, #-0x34]
               	fadd	s0, s0, s1
               	dup	v0.2s, v0.s[0]
               	stur	d0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x50]
               	ldur	s0, [x29, #-0x50]
               	fmov	s1, #-4.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x4c]
               	fmov	s1, #-4.75000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5e               // =94
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x58]
               	fmul	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	mov	x17, #0x3ec00000        // =1052770304
               	movk	x17, #0xc100, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x62               // =98
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x58]
               	mov	v16.16b, v0.16b
               	fmla	v16.2s, v0.2s, v1.2s
               	mov	v0.16b, v16.16b
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	fmov	d16, x0
               	sub	x16, x29, #0x38
               	str	d16, [x16]
               	ldur	s0, [x29, #-0x38]
               	fmov	s1, #1.87500000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x34]
               	fmov	s1, #-10.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x18]
               	stur	d0, [x29, #-0x30]
               	sub	x16, x29, #0x30
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	fadd	d0, d0, d0
               	mov	d0, v0.d[0]
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	fsub	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x20]
               	b	<addr>
               	fsub	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x20]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
