
switch_default_routing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x64               // =100
               	sxtw	x0, w0
               	ret
               	mov	x0, #0xa                // =10
               	b	<addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	b	<addr>
               	b	<addr>
