
inline_asm_hint.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x5
               	b.ge	<addr>
               	yield
               	add	x1, x1, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	w1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0xa
               	b.ge	<addr>
               	yield
               	add	x1, x1, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	cmp	w1, #0x2d
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
