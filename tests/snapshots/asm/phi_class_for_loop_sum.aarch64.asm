
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
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w1, w2
               	b.ge	<addr>
               	add	x0, x0, x1
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	x1, x1, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
