
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
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, x0
               	sub	x6, x29, #0x8
               	mov	w3, w0
               	cmp	w3, #0x4
               	cset	x4, eq
               	cmp	w4, #0x0
               	cset	x1, eq
               	cbnz	x4, <addr>
               	and	x4, x3, #0x7
               	add	x4, x5, x4
               	ldrb	w4, [x4]
               	strb	w4, [x6]
               	add	x0, x3, #0x1
               	cbz	x1, <addr>
               	sub	x3, x29, #0x10
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	add	x1, x3, x1
               	ldurb	w3, [x29, #-0x8]
               	strb	w3, [x1]
               	cmp	w2, #0x4
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldrb	w2, [x1]
               	mov	x17, #0x42              // =66
               	eor	x2, x2, x17
               	cbnz	x2, <addr>
               	ldrb	w2, [x1, #0x1]
               	mov	x17, #0x41              // =65
               	eor	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w2, [x1, #0x2]
               	mov	x17, #0x44              // =68
               	eor	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w1, [x1, #0x3]
               	mov	x17, #0x43              // =67
               	eor	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w0
               	eor	x0, x0, #0x4
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
