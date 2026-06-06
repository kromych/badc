
sysv_variadic_host_abi.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x20
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	ldursw	x0, [x29, #0x10]
               	ldursw	x1, [x29, #0x20]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	mov	x1, #0x2                // =2
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldur	x0, [x29, #-0x10]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	sub	x2, x29, #0x8
               	ldr	x17, [x2]
               	add	x16, x17, #0x10
               	str	x16, [x2]
               	mov	x2, x17
               	ldr	x2, [x2]
               	add	x1, x1, x2
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	sub	x2, x29, #0x8
               	ldr	x17, [x2]
               	add	x16, x17, #0x10
               	str	x16, [x2]
               	mov	x2, x17
               	ldr	d0, [x2]
               	fcvtzs	x2, d0
               	add	x1, x1, x2
               	str	x1, [x0]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x10
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldr	d0, [x0]
               	sub	x1, x29, #0x8
               	ldr	x17, [x1]
               	add	x16, x17, #0x10
               	str	x16, [x1]
               	mov	x1, x17
               	ldr	d1, [x1]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	mov	x4, #0x3                // =3
               	mov	x5, #0x4010000000000000 // =4616189618054758400
               	mov	x6, #0x5                // =5
               	mov	x7, #0x4018000000000000 // =4618441417868443648
               	mov	x2, #0x7                // =7
               	mov	x8, #0x4020000000000000 // =4620693217682128896
               	mov	x9, #0x9                // =9
               	mov	x10, #0x4024000000000000 // =4621819117588971520
               	str	x10, [sp, #-0x10]!
               	str	x9, [sp, #-0x10]!
               	str	x8, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x7, [sp, #-0x10]!
               	str	x6, [sp, #-0x10]!
               	str	x5, [sp, #-0x10]!
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0xc0
               	cmp	x0, #0x3a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x3, #0x4008000000000000 // =4613937818241073152
               	mov	x4, #0x4010000000000000 // =4616189618054758400
               	mov	x5, #0x4014000000000000 // =4617315517961601024
               	mov	x6, #0x4018000000000000 // =4618441417868443648
               	mov	x7, #0x401c000000000000 // =4619567317775286272
               	mov	x8, #0x4020000000000000 // =4620693217682128896
               	mov	x9, #0x4022000000000000 // =4621256167635550208
               	str	x9, [sp, #-0x10]!
               	str	x8, [sp, #-0x10]!
               	str	x7, [sp, #-0x10]!
               	str	x6, [sp, #-0x10]!
               	str	x5, [sp, #-0x10]!
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0xa0
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4046, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
