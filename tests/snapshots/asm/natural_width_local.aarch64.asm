
natural_width_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	add	x1, x1, #0x2c
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x2, w0
               	cmp	x2, #0x4
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	add	x0, x2, #0x8
               	sxtw	x2, w0
               	sxtw	x0, w2
               	ret
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	add	x0, x2, #0x2
               	sxtw	x2, w0
               	b	<addr>
               	add	x0, x2, #0x4
               	sxtw	x2, w0
               	b	<addr>
