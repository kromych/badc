
inline_linkage.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<sinl>:
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	ret

<einl>:
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x2, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	cbz	x2, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ret
               	b	<addr>
