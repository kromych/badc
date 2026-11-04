
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
               	sub	sp, sp, #0xb0
               	fmov	d0, #2.50000000
               	stur	d0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x28]
               	fmov	d0, d0
               	stur	d0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x60]
               	add	x0, x0, #0x1
               	mov	x17, #0x1               // =1
               	movk	x17, #0x4004, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4b               // =75
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x20]
               	fmov	s0, s0
               	stur	s0, [x29, #-0x58]
               	ldursw	x0, [x29, #-0x58]
               	eor	x0, x0, #0x1
               	mov	x17, #0x1               // =1
               	movk	x17, #0x3f80, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4d               // =77
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x28]
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
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s1, [x29, #-0x20]
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
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x88]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	mov	x17, #0x8               // =8
               	add	x16, x16, x17
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x60]
               	sub	x1, x29, #0x60
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x80]
               	sub	x2, x29, #0x88
               	sub	x0, x29, #0x30
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x1, x29, #0x58
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #0x40400000        // =1077936128
               	movk	x17, #0xc080, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x52               // =82
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x88
               	sub	x2, x29, #0x80
               	sub	x0, x29, #0x40
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x30
               	ldr	x16, [x2]
               	str	x16, [x1]
               	sub	x2, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x58
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x30]
               	ldur	s0, [x29, #-0x2c]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x88
               	sub	x0, x29, #0x40
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x1, x29, #0x58
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x30]
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x30]
               	fmov	s1, #2.25000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x60]
               	str	d0, [sp]
               	ldr	d0, [sp]
               	fneg	v0.2s, v0.2s
               	stur	d0, [x29, #-0x60]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x58
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x58]
               	str	d0, [sp]
               	ldr	d0, [sp]
               	fneg	v0.2s, v0.2s
               	fadd	v0.2s, v0.2s, v0.2s
               	stur	d0, [x29, #-0x58]
               	sub	x2, x29, #0x58
               	ldur	x0, [x29, #-0x58]
               	stur	x0, [x29, #-0x30]
               	ldur	s0, [x29, #-0x30]
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fmov	s1, #-4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x18]
               	ldursw	x3, [x29, #-0x18]
               	sub	x1, x29, #0x88
               	sub	x4, x29, #0x80
               	sub	x0, x29, #0x48
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x40
               	ldr	x16, [x4]
               	str	x16, [x1]
               	cbz	x3, <addr>
               	sub	x3, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x3]
               	ldr	x16, [x1]
               	str	x16, [x2]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	sub	x0, x29, #0x10
               	ldur	x1, [x29, #-0x50]
               	stur	x1, [x29, #-0x10]
               	sub	x1, x29, #0x30
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x30]
               	ldur	s1, [x29, #-0x2c]
               	fadd	s0, s0, s1
               	dup	v0.2s, v0.s[0]
               	stur	d0, [x29, #-0x58]
               	sub	x2, x29, #0x58
               	ldur	x0, [x29, #-0x58]
               	stur	x0, [x29, #-0x68]
               	ldur	s0, [x29, #-0x68]
               	fmov	s1, #3.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x64]
               	fmov	s1, #3.75000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5b               // =91
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x18]
               	ldursw	x3, [x29, #-0x18]
               	sub	x1, x29, #0x88
               	sub	x4, x29, #0x80
               	sub	x0, x29, #0x48
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x40
               	ldr	x16, [x4]
               	str	x16, [x1]
               	cbz	x3, <addr>
               	sub	x3, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x3]
               	ldr	x16, [x1]
               	str	x16, [x2]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	sub	x0, x29, #0x10
               	ldur	x1, [x29, #-0x50]
               	stur	x1, [x29, #-0x10]
               	sub	x1, x29, #0x30
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x30]
               	ldur	s1, [x29, #-0x2c]
               	fadd	s0, s0, s1
               	dup	v0.2s, v0.s[0]
               	stur	d0, [x29, #-0x58]
               	ldur	x0, [x29, #-0x58]
               	stur	x0, [x29, #-0x68]
               	ldur	s0, [x29, #-0x68]
               	fmov	s1, #-4.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x64]
               	fmov	s1, #-4.75000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5e               // =94
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x58
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	sub	x1, x29, #0x70
               	stur	x0, [x29, #-0x70]
               	sub	x0, x29, #0x78
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x78]
               	mov	x17, #0x3ec00000        // =1052770304
               	movk	x17, #0xc100, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x62               // =98
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x2, x29, #0x58
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x50
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x50]
               	ldur	d0, [x29, #-0x60]
               	str	d0, [sp]
               	fmov	d16, x1
               	str	d16, [sp, #0x8]
               	fmov	d16, x2
               	str	d16, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	fmla	v0.2s, v1.2s, v2.2s
               	stur	d0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x60]
               	fmov	d16, x0
               	sub	x16, x29, #0x68
               	str	d16, [x16]
               	ldur	s0, [x29, #-0x68]
               	fmov	s1, #1.87500000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x64]
               	fmov	s1, #-10.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x28]
               	stur	d0, [x29, #-0x48]
               	sub	x16, x29, #0x48
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x0
               	fadd	d0, d16, d17
               	stur	d0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	sub	x1, x29, #0x40
               	stur	x0, [x29, #-0x40]
               	sub	x0, x29, #0x30
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	d0, [x29, #-0x30]
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x3]
               	ldr	x16, [x1]
               	str	x16, [x2]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fsub	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	sub	x0, x29, #0x8
               	ldur	x1, [x29, #-0x50]
               	stur	x1, [x29, #-0x8]
               	b	<addr>
               	sub	x3, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x3]
               	ldr	x16, [x1]
               	str	x16, [x2]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x58]
               	fmov	d16, x0
               	fmov	d17, x1
               	fsub	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x50]
               	sub	x0, x29, #0x8
               	ldur	x1, [x29, #-0x50]
               	stur	x1, [x29, #-0x8]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
