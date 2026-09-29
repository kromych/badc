
inline_asm_a64_adr.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adr	x0, <addr>
               	ldr	x0, [x0]
               	b	<addr>
  40047c: 2a 00 00 00  	.word	0x0000002a
  400480: 00 00 00 00  	.word	0x00000000
               	ret
