
for_loop.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x1, x0
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
