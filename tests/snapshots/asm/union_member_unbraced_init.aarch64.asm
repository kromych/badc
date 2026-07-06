
union_member_unbraced_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x1, [x0, #0x10]
               	cmp	x1, #0x2a
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x8                // =8
               	b	<addr>
               	sxtw	x1, w2
               	add	x1, x0, x1
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x10
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x2b
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x9
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x2a
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0, #0x18]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x28]
               	cmp	x0, #0x2b
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	ldr	d0, [x0]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x2a
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x38
               	ldr	d0, [x0]
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x2c
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
