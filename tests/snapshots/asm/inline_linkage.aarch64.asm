
inline_linkage.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
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
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
