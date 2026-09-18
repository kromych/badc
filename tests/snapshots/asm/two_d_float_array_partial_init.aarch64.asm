
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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20, #0x10]
               	cbz	x0, <addr>
               	ldr	x0, [x20, #0x10]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x20, #0x10]
               	ldr	x0, [x20, #0x10]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<main>:
               	str	d8, [sp, #-0x30]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x0               // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x20, x21
               	b	<addr>
               	sxtw	x3, w20
               	lsl	x0, x3, #4
               	add	x4, x2, x0
               	add	x4, x4, #0x0
               	ldr	s0, [x4]
               	add	x4, x1, x0
               	add	x4, x4, #0x0
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x5, #0x1                // =1
               	add	x4, x2, x0
               	ldr	s0, [x4, #0x4]
               	add	x4, x1, x0
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x5, #0x2                // =2
               	add	x4, x2, x0
               	ldr	s0, [x4, #0x8]
               	add	x4, x1, x0
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x4, #0x3                // =3
               	add	x3, x2, x0
               	ldr	s0, [x3, #0xc]
               	add	x0, x1, x0
               	ldr	s1, [x0, #0xc]
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0xc
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x8]
               	fadd	s0, s0, s1
               	fmov	s16, w1
               	fadd	s0, s16, s0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x30
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x40
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x50
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x60
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x70
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x80
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xa0
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xb0
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s8, s0, s1
               	fmov	s17, w1
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
               	mov	x4, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	sxtw	x2, w20
               	sxtw	x3, w21
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x0, x2, #4
               	add	x6, x1, x0
               	lsl	x1, x3, #2
               	add	x6, x6, x1
               	ldr	s0, [x6]
               	fcvt	d0, s0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	add	x0, x6, x0
               	add	x0, x0, x1
               	ldr	s1, [x0]
               	fcvt	d1, s1
               	mov	x0, x4
               	mov	x1, x5
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
               	b	<addr>
