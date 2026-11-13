
hfa_param_interleave.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #9.50000000
               	sub	x7, x29, #0x28
               	mov	x0, #0x3f800000         // =1065353216
               	movk	x0, #0x4000, lsl #48
               	stur	x0, [x29, #-0x28]
               	sub	x1, x29, #0x20
               	mov	x0, #0x40400000         // =1077936128
               	movk	x0, #0x4080, lsl #48
               	stur	x0, [x29, #-0x20]
               	sub	x2, x29, #0x18
               	mov	x0, #0x40a00000         // =1084227584
               	movk	x0, #0x40c0, lsl #48
               	stur	x0, [x29, #-0x18]
               	sub	x3, x29, #0x10
               	mov	x0, #0x40e00000         // =1088421888
               	movk	x0, #0x4100, lsl #48
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	mov	x4, #0x201              // =513
               	movk	x4, #0x403, lsl #16
               	stur	w4, [x29, #-0x8]
               	str	d0, [sp]
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x1]
               	ldr	s3, [x1, #0x4]
               	ldr	s4, [x2]
               	ldr	s5, [x2, #0x4]
               	ldr	s6, [x3]
               	ldr	s7, [x3, #0x4]
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
               	fmov	s0, #0.25000000
               	sub	x7, x29, #0x28
               	stur	xzr, [x29, #-0x28]
               	sub	x1, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	sub	x2, x29, #0x18
               	stur	xzr, [x29, #-0x18]
               	sub	x3, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	mov	x4, #0x201              // =513
               	movk	x4, #0x403, lsl #16
               	stur	w4, [x29, #-0x8]
               	str	d0, [sp]
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x1]
               	ldr	s3, [x1, #0x4]
               	ldr	s4, [x2]
               	ldr	s5, [x2, #0x4]
               	ldr	s6, [x3]
               	ldr	s7, [x3, #0x4]
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
