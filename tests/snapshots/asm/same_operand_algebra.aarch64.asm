
same_operand_algebra.aarch64:	file format elf64-littleaarch64

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

<xor_self>:
               	mov	x0, #0x0                // =0
               	ret

<sub_self>:
               	mov	x0, #0x0                // =0
               	ret

<and_self>:
               	ret

<or_self>:
               	ret

<or_all_ones>:
               	mov	x0, #-0x1               // =-1
               	ret

<or_all_ones_unsigned>:
               	mov	x0, #0xffffffff         // =4294967295
               	ret

<or_all_ones_char>:
               	mov	x0, #0xff               // =255
               	ret

<or_then_mask>:
               	mov	x0, #0x30               // =48
               	ret

<or_then_wider_mask>:
               	orr	x0, x0, #0xf0
               	and	x0, x0, #0x1f0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1234             // =4660
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	orr	x0, x0, #0xf0
               	and	x0, x0, #0x1f0
               	cmp	w0, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
