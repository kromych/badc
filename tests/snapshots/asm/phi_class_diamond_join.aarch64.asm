
phi_class_diamond_join.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x1, w1
               	sxtw	x2, w2
               	add	x1, x1, #0x1
               	sub	x2, x2, #0x1
               	cmp	w0, #0x0
               	csel	x0, x1, x2, ne
               	ret

<main>:
               	mov	x0, #0x1e               // =30
               	ret
