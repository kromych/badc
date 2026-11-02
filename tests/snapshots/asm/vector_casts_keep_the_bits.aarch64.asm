
vector_casts_keep_the_bits.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x5                // =5
               	movk	x0, #0x7, lsl #32
               	stur	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x4]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x8]
               	ldurh	w1, [x29, #-0x6]
               	ldurh	w2, [x29, #-0x4]
               	ldurh	w3, [x29, #-0x2]
               	sxth	x0, w0
               	cmp	w0, #0x5
               	b.ne	<addr>
               	sxth	x0, w1
               	cbnz	w0, <addr>
               	sxth	x0, w2
               	cmp	w0, #0x7
               	b.ne	<addr>
               	sxth	x0, w3
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
