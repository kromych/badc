
inline_nested_aggregate_return.aarch64:	file format elf64-littleaarch64

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

<make_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldrsw	x2, [x21]
               	add	x2, x2, #0x1
               	str	w2, [x21]
               	add	x0, x1, x0
               	add	x0, x0, #0x4
               	add	x0, x0, #0x5
               	add	x0, x0, #0x6
               	add	x0, x0, #0x7
               	add	x0, x0, #0x8
               	add	x0, x0, #0x9
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	ldrsw	x2, [x21]
               	add	x2, x2, #0x1
               	str	w2, [x21]
               	add	x0, x1, x0
               	add	x0, x0, #0x0
               	add	x0, x0, #0x1
               	add	x0, x0, #0x2
               	add	x0, x0, #0x3
               	add	x0, x0, #0x4
               	add	x0, x0, #0x5
               	cmp	x0, #0x10
               	b.eq	<addr>
               	orr	x20, x20, #0x2
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x1, x29, #0x10
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, #0x5
               	ldrsw	x2, [x21]
               	add	x2, x2, #0x1
               	str	w2, [x21]
               	add	x0, x1, x0
               	cmp	x0, #0x16
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x1, x29, #0x10
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, #0x5
               	ldrsw	x2, [x21]
               	add	x2, x2, #0x1
               	str	w2, [x21]
               	add	x0, x1, x0
               	cmp	x0, #0x1a
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	lsl	x1, x1, #1
               	add	x0, x1, x0
               	cmp	x0, #0x1a
               	b.eq	<addr>
               	orr	x20, x20, #0x10
               	mov	x0, #0x6                // =6
               	scvtf	d0, x0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fdiv	d1, d0, d17
               	fadd	d0, d1, d0
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	mov	x1, #0x4018000000000000 // =4618441417868443648
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d1, d16, d17
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x1
               	str	w0, [x21]
               	ldrsw	x0, [x21]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	orr	x20, x20, #0x80
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
