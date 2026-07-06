
control_flow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
