
two_d_float_array_partial_init.aarch64:	file format elf64-littleaarch64

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
               	mov	x3, #0x0                // =0
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, x3
               	lsl	x1, x2, #4
               	add	x0, x5, x1
               	ldr	s0, [x0]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x7, #0x1                // =1
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x7, #0x2                // =2
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x6, #0x3                // =3
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0xc
               	b.lt	<addr>
               	movi	d0, #0000000000000000
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x10]
               	ldr	s2, [x0, #0x14]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x18]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x20]
               	ldr	s2, [x0, #0x24]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x28]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x30]
               	ldr	s2, [x0, #0x34]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x38]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x40]
               	ldr	s2, [x0, #0x44]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x48]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x50]
               	ldr	s2, [x0, #0x54]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x58]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x60]
               	ldr	s2, [x0, #0x64]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x68]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x70]
               	ldr	s2, [x0, #0x74]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x78]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x80]
               	ldr	s2, [x0, #0x84]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x88]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x90]
               	ldr	s2, [x0, #0x94]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x98]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0xa0]
               	ldr	s2, [x0, #0xa4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0xa8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0xb0]
               	ldr	s2, [x0, #0xb4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0xb8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x6
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	lsl	x4, x2, #4
               	add	x6, x5, x4
               	lsl	x5, x3, #2
               	add	x6, x6, x5
               	ldr	s0, [x6]
               	fcvt	d0, s0
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	add	x4, x6, x4
               	add	x4, x4, x5
               	ldr	s1, [x4]
               	fcvt	d1, s1
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x7
               	b	<addr>
               	mov	x3, x7
               	b	<addr>
