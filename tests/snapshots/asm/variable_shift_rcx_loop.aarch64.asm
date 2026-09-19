
variable_shift_rcx_loop.aarch64:	file format elf64-littleaarch64

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

<g>:
               	mov	x5, x0
               	mov	x0, x3
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	cmp	x4, x5
               	b.ge	<addr>
               	add	x4, x3, x0
               	lsl	x6, x1, x2
               	add	x3, x3, x6
               	cmp	x4, x5
               	b.lt	<addr>
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x1, x0, #0x1
               	add	x0, x0, #0x10
               	cmp	x1, #0x64
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
