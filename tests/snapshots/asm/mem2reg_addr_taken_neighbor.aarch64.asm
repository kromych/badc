
mem2reg_addr_taken_neighbor.aarch64:	file format elf64-littleaarch64

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

<g>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	lsl	x0, x0, #1
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	add	x2, x2, x0
               	str	w2, [x1]
               	sxtw	x2, w2
               	add	x2, x2, x0
               	str	w2, [x1]
               	sxtw	x2, w2
               	add	x0, x2, x0
               	str	w0, [x1]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0xe
               	str	w1, [x0]
               	sxtw	x1, w1
               	add	x1, x1, #0xe
               	str	w1, [x0]
               	sxtw	x1, w1
               	add	x1, x1, #0xe
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
