
struct_arg_indirect_subscript.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xb0
               	sub	x0, x29, #0x88
               	str	xzr, [x0]
               	add	x1, x0, #0x8
               	mov	x0, #0x1                // =1
               	str	x0, [x1]
               	str	xzr, [x1, #0x8]
               	mov	x2, #0x2                // =2
               	str	x2, [x1, #0x10]
               	add	x3, x1, #0x10
               	str	x0, [x3, #0x8]
               	mov	x0, #0x3                // =3
               	str	x0, [x1, #0x20]
               	add	x3, x1, #0x20
               	str	x2, [x3, #0x8]
               	mov	x2, #0x4                // =4
               	str	x2, [x1, #0x30]
               	add	x3, x1, #0x30
               	str	x0, [x3, #0x8]
               	mov	x3, #0x5                // =5
               	str	x3, [x1, #0x40]
               	add	x1, x1, #0x40
               	str	x2, [x1, #0x8]
               	sub	x4, x29, #0x88
               	add	x1, x4, #0x8
               	mov	x5, #0x6                // =6
               	str	x5, [x1, #0x50]
               	add	x6, x1, #0x50
               	str	x3, [x6, #0x8]
               	mov	x6, #0x7                // =7
               	str	x6, [x1, #0x60]
               	add	x7, x1, #0x60
               	str	x5, [x7, #0x8]
               	mov	x5, #0x8                // =8
               	str	x5, [x1, #0x70]
               	add	x5, x1, #0x70
               	str	x6, [x5, #0x8]
               	add	x1, x1, #0x30
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x6, [x1]
               	mov	x17, #0x3e8             // =1000
               	mul	x6, x6, x17
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x1, x6, x1
               	add	x6, x1, #0x3
               	cbz	x4, <addr>
               	mov	x1, #0x0                // =0
               	cbz	x5, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x6, x1
               	cmp	x1, #0xfc2
               	b.eq	<addr>
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x1                // =1
               	ldr	d2, [x1]
               	fmov	d0, #4.00000000
               	ldr	d3, [x1, #0x8]
               	fmov	d1, #2.00000000
               	fmul	d3, d3, d1
               	fmadd	d3, d2, d0, d3
               	scvtf	d2, x0
               	fadd	d4, d3, d2
               	fmov	d3, #1.50000000
               	fmov	d5, #2.25000000
               	fmul	d5, d5, d1
               	fmadd	d3, d3, d0, d5
               	fmov	d5, #1.00000000
               	fadd	d3, d3, d5
               	fcmp	d4, d3
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	d4, [x0]
               	ldr	d5, [x0, #0x8]
               	fmul	d1, d5, d1
               	fmadd	d0, d4, d0, d1
               	fadd	d0, d0, d2
               	fcmp	d0, d3
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
