
zero_length_array_sizeof.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	mov	x0, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, x0
               	cmp	w0, #0x4
               	cset	x3, eq
               	cbnz	w3, <addr>
               	and	x1, x0, #0x7
               	ldrb	w1, [x6, x1]
               	add	x0, x0, #0x1
               	cbnz	w3, <addr>
               	sub	x4, x29, #0x10
               	add	x3, x2, #0x1
               	and	x5, x1, #0xff
               	strb	w5, [x4, x2]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	mov	x2, x3
               	b	<addr>
               	mov	x2, x3
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x30]
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w1, [x29, #-0x10]
               	cmp	w1, #0x42
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xf]
               	cmp	w1, #0x41
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xe]
               	cmp	w1, #0x44
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xd]
               	cmp	w1, #0x43
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
