
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
               	stp	x20, x21, [sp, #-0x150]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x140]
               	add	x29, sp, #0x140
               	mov	x22, #0x0               // =0
               	mov	x23, #0x4               // =4
               	mov	x0, x23
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x21, x29, #0x100
               	ldr	x1, [x21]
               	ldr	x2, [x21, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	add	x0, x1, x2
               	add	x0, x0, #0x4
               	add	x0, x0, #0x5
               	add	x0, x0, #0x6
               	add	x0, x0, #0x7
               	add	x0, x0, #0x8
               	add	x0, x0, #0x9
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	mov	x0, x22
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	ldr	x1, [x21]
               	ldr	x2, [x21, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	add	x0, x1, x2
               	add	x0, x0, #0x0
               	add	x0, x0, #0x1
               	add	x0, x0, #0x2
               	add	x0, x0, #0x3
               	add	x0, x0, #0x4
               	add	x0, x0, #0x5
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x17, #0x2               // =2
               	orr	x20, x20, x17
               	mov	x0, x23
               	bl	<addr>
               	sub	x16, x29, #0xd0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x21, x29, #0xd0
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	add	x2, x0, #0x5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	add	x0, x1, x2
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x17, #0x4               // =4
               	orr	x20, x20, x17
               	mov	x23, #0x5               // =5
               	mov	x0, x23
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x22, x29, #0x100
               	ldr	x0, [x22]
               	ldr	x1, [x22, #0x8]
               	add	x2, x0, #0x5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	add	x0, x1, x2
               	cmp	x0, #0x1a
               	b.eq	<addr>
               	mov	x17, #0x8               // =8
               	orr	x20, x20, x17
               	mov	x0, x23
               	bl	<addr>
               	sub	x16, x29, #0xd0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	lsl	x0, x0, #1
               	add	x0, x0, x1
               	cmp	x0, #0x1a
               	b.eq	<addr>
               	mov	x17, #0x10              // =16
               	orr	x20, x20, x17
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0xd0
               	scvtf	d0, x1
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fdiv	d1, d0, d17
               	str	d1, [x0]
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x22, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	ldr	d1, [x22]
               	fadd	d1, d1, d0
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	mov	x1, #0x4018000000000000 // =4618441417868443648
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x17, #0x20              // =32
               	orr	x20, x20, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x17, #0x80              // =128
               	orr	x20, x20, x17
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, x22
               	b	<addr>
