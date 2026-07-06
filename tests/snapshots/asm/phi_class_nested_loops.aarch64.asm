
phi_class_nested_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	mov	x5, #0x0                // =0
               	mov	x4, x5
               	b	<addr>
               	add	x5, x5, #0x1
               	sxtw	x5, w5
               	add	x4, x6, #0x1
               	sxtw	x6, w4
               	cmp	x6, x0
               	b.lt	<addr>
               	add	x2, x2, x5
               	sxtw	x2, w2
               	add	x1, x3, #0x1
               	sxtw	x3, w1
               	cmp	x3, x0
               	b.lt	<addr>
               	sxtw	x0, w2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
