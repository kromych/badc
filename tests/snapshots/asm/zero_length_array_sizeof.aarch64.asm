
zero_length_array_sizeof.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x18
               	mov	x1, #0x4                // =4
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x2, #0x7                // =7
               	str	w2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x3, [x0, #0x10]
               	sub	x0, x29, #0x18
               	sub	x4, x29, #0x28
               	ldr	w2, [x0, #0x4]
               	cmp	x2, #0x4
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, eq
               	mov	w5, w2
               	cbz	x5, <addr>
               	ldr	w5, [x0, #0x4]
               	mov	x17, #0x7               // =7
               	and	x5, x5, x17
               	add	x5, x3, x5
               	ldrb	w5, [x5]
               	strb	w5, [x4]
               	ldr	w4, [x0, #0x4]
               	add	x4, x4, #0x1
               	str	w4, [x0, #0x4]
               	mov	w0, w2
               	cbz	x0, <addr>
               	sub	x2, x29, #0x20
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	add	x0, x2, x0
               	ldurb	w2, [x29, #-0x28]
               	strb	w2, [x0]
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	w0, w0
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x44              // =68
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x43              // =67
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
