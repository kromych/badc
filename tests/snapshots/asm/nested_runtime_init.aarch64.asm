
nested_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x0, #0x1
               	sxtw	x4, w2
               	cmp	x1, x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	cmp	x4, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	lsl	x2, x0, #1
               	sxtw	x2, w2
               	add	x3, x0, #0x3
               	sxtw	x4, w3
               	lsl	x3, x0, #1
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x0, #0x3
               	sxtw	x2, w2
               	cmp	x4, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	lsl	x2, x0, #1
               	sxtw	x3, w2
               	add	x2, x0, #0x5
               	sxtw	x5, w2
               	cmp	x1, x1
               	cset	x4, ne
               	mov	x2, #0x1                // =1
               	cbnz	x4, <addr>
               	lsl	x2, x0, #1
               	sxtw	x2, w2
               	cmp	x3, x2
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x0, #0x5
               	sxtw	x2, w2
               	cmp	x5, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x0, #0x1
               	sxtw	x3, w2
               	add	x2, x0, #0x2
               	sxtw	x4, w2
               	cmp	x1, x1
               	cset	x5, ne
               	mov	x2, #0x1                // =1
               	cbnz	x5, <addr>
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	cmp	x3, x2
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x0, #0x2
               	sxtw	x2, w2
               	cmp	x4, x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
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
               	b	<addr>
