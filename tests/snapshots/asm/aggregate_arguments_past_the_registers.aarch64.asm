
aggregate_arguments_past_the_registers.aarch64:	file format elf64-littleaarch64

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

<tail>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x20]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x28]
               	str	x17, [x16, #0x8]
               	add	x0, x0, x1, lsl #1
               	add	x1, x2, x2, lsl #1
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	add	x1, x4, x4, lsl #2
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x6, x17
               	add	x0, x0, x1
               	ldur	d0, [x29, #-0x20]
               	fcvtzs	x1, d0
               	add	x0, x0, x1, lsl #3
               	ldur	x1, [x29, #-0x18]
               	add	x1, x1, x1, lsl #3
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x10]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0xb               // =11
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<four>:
               	add	x0, x0, x1, lsl #1
               	add	x1, x2, x2, lsl #1
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	add	x1, x4, x4, lsl #2
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x6, x17
               	add	x0, x0, x1
               	add	x0, x0, x7, lsl #3
               	ret

<fp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16, #0x8]
               	fmov	d19, #2.00000000
               	fmadd	d0, d1, d19, d0
               	fmov	d1, #3.00000000
               	fmadd	d0, d2, d1, d0
               	fmov	d1, #4.00000000
               	fmadd	d0, d3, d1, d0
               	fmov	d1, #5.00000000
               	fmadd	d0, d4, d1, d0
               	fmov	d1, #6.00000000
               	fmadd	d0, d5, d1, d0
               	fmov	d1, #7.00000000
               	fmadd	d0, d6, d1, d0
               	fmov	d1, #8.00000000
               	fmadd	d0, d7, d1, d0
               	ldur	d1, [x29, #-0x10]
               	fmov	d2, #9.00000000
               	fmadd	d0, d1, d2, d0
               	ldur	d1, [x29, #-0x8]
               	fmov	d2, #10.00000000
               	fmadd	d0, d1, d2, d0
               	scvtf	d1, x0
               	fmov	d2, #11.00000000
               	fmadd	d0, d1, d2, d0
               	fmov	d1, x1
               	fmov	d2, #12.00000000
               	fmadd	d0, d1, d2, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make>:
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x6, x0, #0x10
               	mov	x2, #0x3                // =3
               	stur	x2, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	sub	x5, x29, #0x60
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldp	x16, x17, [x7]
               	stp	x16, x17, [x5]
               	sub	x7, x29, #0x50
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldp	x16, x17, [x8]
               	stp	x16, x17, [x7]
               	add	x6, x6, #0x10
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x6
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	cmp	x0, #0x1e5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	ldur	x2, [x29, #-0x8]
               	lsl	x2, x2, #1
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	sub	x5, x29, #0x40
               	add	x5, x5, #0x10
               	sub	x5, x5, #0x10
               	ldur	x6, [x29, #-0x8]
               	scvtf	d0, x6
               	sub	x7, x29, #0x60
               	stur	d0, [x29, #-0x60]
               	ldur	x6, [x29, #-0x8]
               	stur	x6, [x29, #-0x58]
               	ldur	x6, [x29, #-0x8]
               	sub	x8, x29, #0x50
               	stur	x6, [x29, #-0x50]
               	mov	x6, #0xb                // =11
               	stur	x6, [x29, #-0x48]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x8
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	cmp	x0, #0x158
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	sub	x2, x29, #0x50
               	stur	x1, [x29, #-0x48]
               	ldur	x0, [x29, #-0x8]
               	sub	x6, x29, #0x60
               	stur	x0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x5
               	stur	x0, [x29, #-0x58]
               	sub	x0, x29, #0x40
               	add	x4, x0, #0x10
               	sub	x0, x29, #0x70
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	ldr	x7, [x6, #0x8]
               	ldr	x6, [x6]
               	bl	<addr>
               	cmp	x0, #0xc6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	ldr	x9, [x0]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	sub	x5, x29, #0x60
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldp	x16, x17, [x6]
               	stp	x16, x17, [x5]
               	sub	x7, x29, #0x50
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldp	x16, x17, [x6]
               	stp	x16, x17, [x7]
               	sub	x6, x29, #0x40
               	add	x6, x6, #0x10
               	add	x6, x6, #0x10
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x6
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	blr	x9
               	cmp	x0, #0x1e5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x1, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x1]
               	ldr	d3, [x1, #0x8]
               	ldr	d4, [x7]
               	ldr	d5, [x7, #0x8]
               	ldr	d6, [x2]
               	ldr	d7, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xc0]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
