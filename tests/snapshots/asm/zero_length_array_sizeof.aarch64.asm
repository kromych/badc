
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, x0
               	sub	x4, x29, #0x8
               	cmp	w0, #0x4
               	cset	x2, eq
               	cbnz	w2, <addr>
               	and	x5, x0, #0x7
               	ldrb	w5, [x3, x5]
               	strb	w5, [x4]
               	add	x0, x0, #0x1
               	cbnz	w2, <addr>
               	sub	x4, x29, #0x10
               	add	x2, x1, #0x1
               	ldurb	w5, [x29, #-0x8]
               	strb	w5, [x4, x1]
               	cmp	w2, #0x4
               	b.ge	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, x2
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
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x1]
               	mov	x17, #0x41              // =65
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x2]
               	mov	x17, #0x44              // =68
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	ldrb	w1, [x1, #0x3]
               	mov	x17, #0x43              // =67
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x0, #0x4
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
