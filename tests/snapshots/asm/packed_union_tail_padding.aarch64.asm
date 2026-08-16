
packed_union_tail_padding.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xe0
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x20
               	sub	x0, x0, x1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x3c
               	sub	x1, x29, #0x98
               	sub	x0, x0, x1
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x3b]
               	sub	x0, x29, #0xd8
               	ldrb	w0, [x0, #0x3b]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
