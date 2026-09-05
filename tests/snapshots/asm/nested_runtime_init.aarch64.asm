
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
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	b	<addr>
               	add	x1, x0, #0x1
               	cmp	w0, w0
               	b.ne	<addr>
               	cmp	w1, w1
               	cset	x4, ne
               	mov	x2, x4
               	cbnz	x2, <addr>
               	lsl	x2, x0, #1
               	add	x3, x0, #0x3
               	cmp	w2, w2
               	b.ne	<addr>
               	cmp	w3, w3
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x0, #0x5
               	mov	x3, x5
               	cmp	w2, w2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x0, #0x2
               	cbnz	x4, <addr>
               	cmp	w2, w2
               	cset	x1, ne
               	cbnz	x1, <addr>
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
