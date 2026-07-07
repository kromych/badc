
natural_width_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	b	<addr>
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	b	<addr>
               	add	x0, x0, #0x8
               	sxtw	x0, w0
               	b	<addr>
