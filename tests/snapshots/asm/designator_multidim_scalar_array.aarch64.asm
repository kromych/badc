
designator_multidim_scalar_array.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	add	x1, x3, #0x20
               	sxtw	x2, w0
               	lsl	x4, x2, #3
               	add	x1, x1, x4
               	ldrsw	x1, [x1]
               	cmp	w1, #0x9
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x1, x3, #0x20
               	add	x1, x1, x4
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0xa
               	cset	x1, ne
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	lsl	x4, x1, #3
               	add	x2, x3, x4
               	ldrsw	x5, [x2]
               	cmp	w5, #0x0
               	cset	x2, ne
               	cbnz	x5, <addr>
               	add	x2, x3, x4
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
