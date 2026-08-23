
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
               	add	x2, x3, #0x20
               	lsl	x4, x1, #3
               	add	x2, x2, x4
               	ldrsw	x2, [x2]
               	cmp	x2, #0x9
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x3, #0x20
               	add	x2, x2, x4
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0xa
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	lsl	x4, x1, #3
               	add	x2, x3, x4
               	ldrsw	x5, [x2]
               	cmp	x5, #0x0
               	cset	x2, ne
               	cbnz	x5, <addr>
               	add	x2, x3, x4
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
