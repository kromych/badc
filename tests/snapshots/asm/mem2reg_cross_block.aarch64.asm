
mem2reg_cross_block.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xe                // =14
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	sxtw	x3, w2
               	cmp	x3, #0x3
               	b.ge	<addr>
               	sxtw	x1, w1
               	add	x1, x1, x0
               	sxtw	x1, w1
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	b	<addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
