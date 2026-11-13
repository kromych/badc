
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
               	sub	sp, sp, #0xa0
               	stur	xzr, [x29, #-0x88]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x80]
               	stur	xzr, [x29, #-0x78]
               	mov	x2, #0x2                // =2
               	stur	x2, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x60]
               	stur	x2, [x29, #-0x58]
               	mov	x2, #0x4                // =4
               	stur	x2, [x29, #-0x50]
               	stur	x0, [x29, #-0x48]
               	mov	x3, #0x5                // =5
               	stur	x3, [x29, #-0x40]
               	stur	x2, [x29, #-0x38]
               	mov	x4, #0x6                // =6
               	stur	x4, [x29, #-0x30]
               	stur	x3, [x29, #-0x28]
               	mov	x5, #0x7                // =7
               	stur	x5, [x29, #-0x20]
               	stur	x4, [x29, #-0x18]
               	mov	x4, #0x8                // =8
               	stur	x4, [x29, #-0x10]
               	stur	x5, [x29, #-0x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldur	x5, [x29, #-0x50]
               	mov	x17, #0x3e8             // =1000
               	mul	x5, x5, x17
               	ldur	x6, [x29, #-0x48]
               	mov	x17, #0xa               // =10
               	mul	x6, x6, x17
               	add	x5, x5, x6
               	add	x5, x5, #0x3
               	mov	x6, #0x0                // =0
               	cmp	x4, #0x0
               	csel	x1, x1, x6, ne
               	add	x1, x5, x1
               	cmp	x1, #0xfc2
               	b.eq	<addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	d2, [x29, #-0x98]
               	fmov	d0, #4.00000000
               	ldur	d3, [x29, #-0x90]
               	fmov	d1, #2.00000000
               	fmul	d3, d3, d1
               	fmadd	d3, d2, d0, d3
               	fmov	d2, #1.00000000
               	fadd	d4, d3, d2
               	fmov	d3, #11.50000000
               	fcmp	d4, d3
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d4, [x29, #-0x98]
               	ldur	d5, [x29, #-0x90]
               	fmul	d1, d5, d1
               	fmadd	d0, d4, d0, d1
               	fadd	d0, d0, d2
               	fcmp	d0, d3
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
