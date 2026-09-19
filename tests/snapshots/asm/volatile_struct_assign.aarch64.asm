
volatile_struct_assign.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	mov	x0, #0x3                // =3
               	movk	x0, #0x4, lsl #32
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w2, [x1]
               	str	w2, [x0]
               	add	x1, x1, #0x4
               	ldr	w1, [x1]
               	str	w1, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x4
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x4]
               	mov	x3, x1
               	cmp	w3, #0x5
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	add	x0, x0, #0x4
               	str	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	ldr	w1, [x0]
               	add	x0, x0, #0x4
               	ldr	w0, [x0]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	cmp	w0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x4, #0x7                // =7
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	mul	x2, x1, x4
               	add	x2, x2, #0x1
               	and	x2, x2, #0xff
               	strb	w2, [x3, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x400
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x4243             // =16963
               	movk	x3, #0xf, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	mul	x4, x1, x3
               	sub	x4, x4, #0x5
               	str	x4, [x2, x1, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x100
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x1, x0
               	ldrb	w4, [x4]
               	add	x5, x3, x0
               	strb	w4, [x5]
               	add	x0, x0, #0x1
               	cmp	x0, #0x400
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x1, x0
               	ldrb	w3, [x3]
               	add	x4, x2, x0
               	strb	w3, [x4]
               	add	x0, x0, #0x1
               	cmp	x0, #0x400
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x1, x0
               	ldr	x4, [x4]
               	add	x5, x3, x0
               	str	x4, [x5]
               	add	x0, x0, #0x8
               	cmp	x0, #0x800
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x1, x0
               	ldr	x3, [x3]
               	add	x4, x2, x0
               	str	x3, [x4]
               	add	x0, x0, #0x8
               	cmp	x0, #0x800
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	ldrb	w4, [x2, x1]
               	mul	x1, x1, x3
               	add	x1, x1, #0x1
               	and	x1, x1, #0xff
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x400
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x4243             // =16963
               	movk	x3, #0xf, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x4, [x2, x1, lsl #3]
               	mul	x1, x1, x3
               	sub	x1, x1, #0x5
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x100
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
