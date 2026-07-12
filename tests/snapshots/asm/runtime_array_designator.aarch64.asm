
runtime_array_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x3, x0
               	sxtw	x3, w3
               	sxtw	x1, w1
               	sxtw	x2, w2
               	sub	x0, x29, #0x18
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x4, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	str	w3, [x0, #0xc]
               	sub	x0, x29, #0x18
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	str	w2, [x0, #0x8]
               	sub	x4, x29, #0x18
               	mov	x0, #0x0                // =0
               	ldrsw	x4, [x4]
               	cmp	x4, #0x0
               	cset	x4, eq
               	cbz	x4, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, x2
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_override>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sxtw	x1, w1
               	sub	x2, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x2, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x2, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x2, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x2, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x10
               	str	w0, [x2]
               	sub	x0, x29, #0x10
               	str	w1, [x0]
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrsw	x2, [x2]
               	cmp	x2, x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	mov	x1, #0x3                // =3
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
