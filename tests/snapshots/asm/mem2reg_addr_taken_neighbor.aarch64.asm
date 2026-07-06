
mem2reg_addr_taken_neighbor.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	lsl	x0, x0, #1
               	sub	x2, x29, #0x8
               	ldrsw	x1, [x2]
               	add	x1, x1, x0
               	str	w1, [x2]
               	sxtw	x1, w1
               	add	x1, x1, x0
               	str	w1, [x2]
               	sxtw	x1, w1
               	add	x0, x1, x0
               	str	w0, [x2]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
