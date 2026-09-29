
inline_asm_raw_bytes.aarch64:	file format elf64-littleaarch64

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
  400470: 1f 20 03 d5  	.word	0xd503201f
               	nop
               	mov	x0, #0x0                // =0
               	ret
