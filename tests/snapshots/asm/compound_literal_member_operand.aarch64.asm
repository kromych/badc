
compound_literal_member_operand.aarch64:	file format elf64-littleaarch64

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

<ne_rhs>:
               	cmn	w0, #0x1
               	cset	x0, ne
               	ret

<eq_rhs>:
               	cmn	w0, #0x1
               	cset	x0, eq
               	ret

<add_rhs>:
               	sub	x0, x0, #0x1
               	ret

<swapped>:
               	cmn	w0, #0x1
               	cset	x0, ne
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
