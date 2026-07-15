
phi_class_diamond_join.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	x0, x1, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret
               	sub	x0, x2, #0x1
               	sxtw	x0, w0
               	b	<addr>

<main>:
               	mov	x0, #0xb                // =11
               	mov	x0, #0x13               // =19
               	mov	x0, #0x1e               // =30
               	ret
