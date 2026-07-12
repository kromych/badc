
warn_unused_symbols.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0xc                // =12
               	ret
