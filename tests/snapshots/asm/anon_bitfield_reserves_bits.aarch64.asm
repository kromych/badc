
anon_bitfield_reserves_bits.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	stur	wzr, [x29, #-0x10]
               	mov	x2, #0x1                // =1
               	stur	xzr, [x29, #-0x8]
               	stur	x2, [x29, #-0x10]
               	mov	x2, #0x3344             // =13124
               	movk	x2, #0x1122, lsl #16
               	movk	x2, #0x7788, lsl #32
               	movk	x2, #0x5566, lsl #48
               	stur	x2, [x29, #-0x8]
               	ldur	w2, [x29, #-0x10]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w2, [x29, #-0x8]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	ldur	w2, [x29, #-0x4]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x1, #0x8
               	sub	x1, x2, x1
               	cmp	x1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
