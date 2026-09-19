
phi_class_nested_loops.aarch64:	file format elf64-littleaarch64

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
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	cmp	w5, w0
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w2, w0
               	b.ge	<addr>
               	add	x1, x1, #0x1
               	add	x2, x2, #0x1
               	cmp	w2, w0
               	b.lt	<addr>
               	add	x4, x4, x1
               	add	x5, x5, #0x1
               	cmp	w5, w0
               	b.lt	<addr>
               	sxtw	x0, w4
               	ret

<main>:
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	cmp	w1, #0x7
               	b.lt	<addr>
               	add	x3, x3, x0
               	add	x4, x4, #0x1
               	cmp	w4, #0x7
               	b.lt	<addr>
               	sxtw	x0, w3
               	ret
