
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
               	add	x2, x0, #0x1
               	sxtw	x7, w2
               	cmp	x1, x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	x7, x7
               	cset	x3, ne
               	cbnz	x3, <addr>
               	lsl	x3, x0, #1
               	sxtw	x6, w3
               	add	x5, x0, #0x3
               	sxtw	x8, w5
               	cmp	x6, x6
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x8, x8
               	cset	x5, ne
               	cbnz	x5, <addr>
               	add	x8, x0, #0x5
               	sxtw	x9, w8
               	cmp	x1, x1
               	mov	x5, #0x1                // =1
               	b.ne	<addr>
               	cbnz	x4, <addr>
               	cmp	x9, x9
               	cset	x4, ne
               	cbnz	x4, <addr>
               	add	x3, x0, #0x2
               	sxtw	x4, w3
               	cmp	x1, x1
               	b.ne	<addr>
               	cmp	x7, x7
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x4, x4
               	cset	x5, ne
               	cbz	x5, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x4, x5
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
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
