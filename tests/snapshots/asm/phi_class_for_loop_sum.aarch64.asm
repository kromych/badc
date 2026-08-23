
phi_class_for_loop_sum.aarch64:	file format elf64-littleaarch64

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

<test>:
               	mov	x2, x0
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	add	x1, x1, x0
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	add	x1, x1, x0
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
