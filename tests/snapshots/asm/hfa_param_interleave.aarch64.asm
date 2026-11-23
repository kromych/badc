
hfa_param_interleave.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<sum>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	s19, [x29, #0x10]
               	fadd	s0, s0, s1
               	fadd	s0, s0, s2
               	fadd	s0, s0, s3
               	fadd	s0, s0, s4
               	fadd	s0, s0, s5
               	fadd	s0, s0, s6
               	fadd	s0, s0, s7
               	fadd	s0, s0, s19
               	and	x1, x0, #0xff
               	ubfx	x2, x0, #8, #8
               	add	x1, x1, x2
               	ubfx	x2, x0, #16, #8
               	add	x1, x1, x2
               	ubfx	x0, x0, #24, #8
               	add	x0, x1, x0
               	scvtf	s1, x0
               	fadd	s0, s0, s1
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	fmov	s19, #9.50000000
               	ldur	s0, [x29, #-0x28]
               	ldur	s1, [x29, #-0x24]
               	ldur	s2, [x29, #-0x20]
               	ldur	s3, [x29, #-0x1c]
               	ldur	s4, [x29, #-0x18]
               	ldur	s5, [x29, #-0x14]
               	ldur	s6, [x29, #-0x10]
               	ldur	s7, [x29, #-0xc]
               	str	d19, [sp]
               	ldr	w0, [x0]
               	bl	<addr>
               	mov	x16, #0x425e0000        // =1113456640
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	movi	d0, #0000000000000000
               	fmov	s1, #0.25000000
               	sub	x0, x29, #0x8
               	str	d1, [sp]
               	fmov	d1, d0
               	fmov	d7, d0
               	fmov	d6, d0
               	fmov	d5, d0
               	fmov	d4, d0
               	fmov	d3, d0
               	fmov	d2, d0
               	ldr	w0, [x0]
               	bl	<addr>
               	mov	x16, #0x41240000        // =1092878336
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
