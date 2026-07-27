
inline_asm_pushsection.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<probe>:
               	mov	x1, #0x2a               // =42
               	nop
               	nop
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<fixup_style>:
               	nop
               	nop
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x0, #0x2a               // =42
               	nop
               	nop
               	nop
               	nop
               	mov	x0, #0x2a               // =42
               	ret
