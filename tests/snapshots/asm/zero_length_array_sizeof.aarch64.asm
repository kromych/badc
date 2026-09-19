
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
               	mov	x1, x0
               	sub	x7, x29, #0x8
               	mov	w3, w0
               	cmp	w3, #0x4
               	cset	x4, eq
               	cbnz	x4, <addr>
               	and	x6, x3, #0x7
               	ldrb	w6, [x5, x6]
               	strb	w6, [x7]
               	add	x0, x3, #0x1
               	cbnz	x4, <addr>
               	sub	x3, x29, #0x10
               	sxtw	x2, w1
               	add	x1, x2, #0x1
               	ldurb	w4, [x29, #-0x8]
               	strb	w4, [x3, x2]
               	cmp	w1, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldrb	w2, [x1]
               	mov	x17, #0x42              // =66
               	eor	x2, x2, x17
               	cmp	w2, #0x0
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x1]
               	mov	x17, #0x41              // =65
               	eor	x2, x2, x17
               	cmp	w2, #0x0
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x2]
               	mov	x17, #0x44              // =68
               	eor	x2, x2, x17
               	cmp	w2, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x1, #0x3]
               	mov	x17, #0x43              // =67
               	eor	x1, x1, x17
               	cmp	w1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w0
               	eor	x0, x0, #0x4
               	cmp	w0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
