
redecl_composite_keeps_prototype.aarch64:	file format elf64-littleaarch64

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

<take_wrap>:
               	add	x0, x0, #0x1
               	ret

<take_wrap2>:
               	add	x0, x0, #0x2
               	ret

<take_wrap3>:
               	add	x0, x0, #0x3
               	ret

<take_pairw>:
               	lsr	x1, x0, #32
               	lsl	x1, x1, #32
               	mov	w0, w0
               	orr	x0, x1, x0
               	ret

<add2>:
               	add	x0, x0, x1
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
