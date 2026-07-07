
two_d_float_array_partial_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	ldr	x0, [x21, x20, lsl #3]
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x21, #0x0               // =0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x1, x3, #4
               	add	x4, x2, x1
               	lsl	x2, x0, #2
               	add	x4, x4, x2
               	ldr	s0, [x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x1, x4, x1
               	add	x1, x1, x2
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x4
               	b.lt	<addr>
               	add	x21, x3, #0x1
               	sxtw	x3, w21
               	cmp	x3, #0xc
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x18
               	str	s16, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x30
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x40
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x50
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x60
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x70
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x80
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xa0
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xb0
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	fadd	s1, s1, s2
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x4, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	sxtw	x2, w21
               	sxtw	x3, w20
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
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
