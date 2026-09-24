
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
               	lsr	x1, x0, #8
               	lsr	x2, x0, #16
               	lsr	x3, x0, #24
               	ldr	s19, [x29, #0x10]
               	fadd	s0, s0, s1
               	fadd	s0, s0, s2
               	fadd	s0, s0, s3
               	fadd	s0, s0, s4
               	fadd	s0, s0, s5
               	fadd	s0, s0, s6
               	fadd	s0, s0, s7
               	fadd	s0, s0, s19
               	and	x0, x0, #0xff
               	and	x1, x1, #0xff
               	add	x0, x0, x1
               	and	x1, x2, #0xff
               	add	x0, x0, x1
               	and	x1, x3, #0xff
               	add	x0, x0, x1
               	scvtf	s1, x0
               	fadd	s0, s0, s1
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x7, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x7]
               	sub	x1, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x2, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x3, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x3]
               	sub	x0, x29, #0x10
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	w16, [x4]
               	str	w16, [x0]
               	fmov	s0, #9.50000000
               	sub	sp, sp, #0x10
               	str	d0, [sp]
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x1]
               	ldr	s3, [x1, #0x4]
               	ldr	s4, [x2]
               	ldr	s5, [x2, #0x4]
               	ldr	s6, [x3]
               	ldr	s7, [x3, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x16, #0x425e0000        // =1113456640
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x8
               	str	xzr, [x7]
               	fmov	s0, #0.25000000
               	sub	x0, x29, #0x10
               	sub	sp, sp, #0x10
               	str	d0, [sp]
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x7]
               	ldr	s3, [x7, #0x4]
               	ldr	s4, [x7]
               	ldr	s5, [x7, #0x4]
               	ldr	s6, [x7]
               	ldr	s7, [x7, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x16, #0x41240000        // =1092878336
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
