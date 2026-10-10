
constant_condition_unsigned_operands.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xffffffff         // =4294967295
               	stur	w0, [x29, #-0x10]
               	mov	x0, #-0x2               // =-2
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x8]
               	cmp	w0, w1
               	cset	x0, hs
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x8]
               	mov	w1, w1
               	udiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
