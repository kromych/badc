
phi_class_for_loop_sum.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, x0
               	sxtw	x3, w3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, x3
               	b.lt	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
