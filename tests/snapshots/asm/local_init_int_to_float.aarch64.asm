
local_init_int_to_float.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x2a               // =42
               	scvtf	s0, x0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x98]
               	fcmp	s0, s1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x9c]
               	fcmp	s0, s1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3039             // =12345
               	scvtf	s0, x0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0xa0]
               	fcmp	s0, s1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0xa4]
               	fcmp	s0, s1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7               // =-7
               	scvtf	d0, x0
               	fmov	d1, #-7.50000000
               	fcmp	d0, d1
               	b.mi	<addr>
               	fmov	d1, #-6.50000000
               	fcmp	d0, d1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffffffff         // =4294967295
               	scvtf	s0, x0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0xa8]
               	fcmp	s0, s1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0xac]
               	fcmp	s0, s1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0xb0]
               	fcvtzs	x1, s0
               	cmp	w1, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x90]
               	fcvtzs	x1, d0
               	mov	x17, #-0x2              // =-2
               	cmp	w1, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
