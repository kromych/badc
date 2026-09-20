
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	cset	x0, ne
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<eq_rhs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	cset	x0, eq
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<add_rhs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<swapped>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	cset	x0, ne
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
