
argv_first_char.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	ldr	x0, [x1, #0x8]
               	ldrb	w0, [x0]
               	ret
