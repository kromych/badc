
typedef_aligned_layout.aarch64:	file format elf64-littleaarch64

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

<locals_at_shifted_slots>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	sp, sp, #0x60
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, #0x1                // =1
               	add	x17, sp, #0x10
               	str	w0, [x17]
               	add	x1, sp, #0x20
               	mov	x0, #0x2                // =2
               	strb	w0, [x1]
               	mov	x2, sp
               	mov	x0, #0x3                // =3
               	strb	w0, [x2]
               	add	x3, sp, #0x30
               	mov	x0, #0x4                // =4
               	strb	w0, [x3]
               	add	x4, sp, #0x40
               	mov	x0, #0x5                // =5
               	str	w0, [x4]
               	add	x5, sp, #0x50
               	mov	x0, #0x6                // =6
               	strb	w0, [x5]
               	sub	x0, x29, #0x58
               	mov	x6, #0x7                // =7
               	strb	w6, [x0]
               	add	x7, x0, #0x1
               	mov	x6, #0x8                // =8
               	str	w6, [x7]
               	add	x6, sp, #0x10
               	mov	x17, #0xf               // =15
               	and	x6, x6, x17
               	cbz	x6, <addr>
               	mov	x0, #0x1e               // =30
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x6, x1, x17
               	cbz	x6, <addr>
               	mov	x0, #0x1f               // =31
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x1f              // =31
               	and	x6, x2, x17
               	cbz	x6, <addr>
               	mov	x0, #0x20               // =32
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x6, x3, x17
               	cbz	x6, <addr>
               	mov	x0, #0x21               // =33
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x6, x4, x17
               	cbz	x6, <addr>
               	mov	x0, #0x22               // =34
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x6, x5, x17
               	cbz	x6, <addr>
               	mov	x0, #0x23               // =35
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x7               // =7
               	and	x6, x0, x17
               	cbz	x6, <addr>
               	mov	x0, #0x24               // =36
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x16, sp, #0x10
               	ldrsw	x6, [x16]
               	add	x6, x6, #0x9
               	ldrb	w1, [x1]
               	add	x1, x6, x1
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	ldrsw	x2, [x4]
               	add	x1, x1, x2
               	ldrb	w2, [x5]
               	add	x1, x1, x2
               	ldrb	w2, [x0]
               	add	x1, x1, x2
               	ldrsw	x0, [x7]
               	add	x0, x1, x0
               	sub	x0, x0, #0x9
               	sub	x0, x0, #0x24
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<declarator_vs_typedef>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x1
               	sub	x17, x29, #0x20
               	str	d16, [x17]
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	sub	x17, x29, #0x30
               	str	d16, [x17]
               	sub	x2, x29, #0x10
               	sub	x1, x29, #0x30
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x35               // =53
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	d0, x0
               	sub	x16, x29, #0x20
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	sub	x16, x29, #0x30
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	sub	x0, x0, #0x6
               	ldrsw	x1, [x2]
               	sub	x1, x1, #0x1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x40               // =64
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x41               // =65
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x42               // =66
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x43               // =67
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x44               // =68
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x45               // =69
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x4c               // =76
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x3
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x4e               // =78
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
