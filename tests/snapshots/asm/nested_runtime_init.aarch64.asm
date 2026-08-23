
nested_runtime_init.aarch64:	file format elf64-littleaarch64

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
               	b	<addr>
               	add	x1, x0, #0x1
               	cmp	w0, w0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	cmp	w1, w1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	lsl	x2, x0, #1
               	add	x4, x0, #0x3
               	cmp	w2, w2
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	w4, w4
               	cset	x4, ne
               	cbnz	x4, <addr>
               	add	x5, x0, #0x5
               	cmp	w0, w0
               	mov	x4, #0x1                // =1
               	b.ne	<addr>
               	cbnz	x3, <addr>
               	cmp	w5, w5
               	cset	x3, ne
               	cbnz	x3, <addr>
               	add	x2, x0, #0x2
               	cmp	w0, w0
               	b.ne	<addr>
               	cmp	w1, w1
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	w2, w2
               	cset	x4, ne
               	cbz	x4, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	ret
