
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

<__c5_lazy_stream>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x10]
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	d8, [sp, #-0x30]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x0               // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x20, x21
               	lsl	x1, x20, #4
               	add	x0, x3, x1
               	ldr	s0, [x0]
               	add	x1, x2, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x5, #0x1                // =1
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x5, #0x2                // =2
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x4, #0x3                // =3
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0xc
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x8]
               	fadd	s0, s0, s1
               	fmov	s16, w1
               	fadd	s0, s16, s0
               	add	x1, x0, #0x10
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x20
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x30
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x40
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x50
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x60
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x70
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x80
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0x90
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x1, x0, #0xa0
               	ldr	s1, [x1]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	add	x0, x0, #0xb0
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s8, s0, s1
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s8, s17
               	b.eq	<addr>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	fcvt	d0, s8
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
               	mov	x21, x4
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x2, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x0, x20, #4
               	add	x4, x1, x0
               	lsl	x1, x21, #2
               	add	x4, x4, x1
               	ldr	s0, [x4]
               	fcvt	d0, s0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x0, x4, x0
               	add	x0, x0, x1
               	ldr	s1, [x0]
               	fcvt	d1, s1
               	mov	x0, x2
               	mov	x1, x3
               	mov	x2, x20
               	mov	x3, x21
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
               	mov	x21, x5
               	b	<addr>
               	mov	x21, x5
               	b	<addr>
