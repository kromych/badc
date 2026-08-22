
static_inline_function.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	b	<addr>
               	and	x3, x0, x2
               	add	x1, x1, x3
               	lsr	x0, x0, #1
               	cbnz	x0, <addr>
               	cmp	x1, #0x18
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x2, x0
               	ret
