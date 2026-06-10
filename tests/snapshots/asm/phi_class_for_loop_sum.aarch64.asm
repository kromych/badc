
phi_class_for_loop_sum.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	sxtw	x3, w1
               	cmp	x3, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	sxtw	x2, w2
               	sxtw	x3, w1
               	add	x2, x2, x3
               	sxtw	x2, w2
               	b	<addr>
               	sxtw	x0, w2
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
