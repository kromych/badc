
mem2reg_addr_taken_neighbor.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
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
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
