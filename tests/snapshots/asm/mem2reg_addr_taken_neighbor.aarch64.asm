
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
               	sxtw	x0, w0
               	mov	x3, #0x0                // =0
               	stur	w3, [x29, #-0x8]
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sub	x1, x29, #0x8
               	sxtw	x2, w3
               	cmp	x2, #0x3
               	b.ge	<addr>
               	ldrsw	x2, [x1]
               	sxtw	x4, w0
               	add	x2, x2, x4
               	sxtw	x2, w2
               	str	w2, [x1]
               	sxtw	x2, w3
               	add	x2, x2, #0x1
               	sxtw	x3, w2
               	b	<addr>
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
