
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	add	x4, x2, #0x20
               	sxtw	x1, w0
               	lsl	x3, x1, #3
               	add	x4, x4, x3
               	ldrsw	x4, [x4]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	add	x4, x2, #0x20
               	add	x3, x4, x3
               	ldrsw	x3, [x3, #0x4]
               	cmp	w3, #0xa
               	cset	x3, ne
               	cbnz	x3, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	lsl	x3, x1, #3
               	add	x4, x2, x3
               	ldrsw	x4, [x4]
               	cbnz	x4, <addr>
               	add	x3, x2, x3
               	ldrsw	x3, [x3, #0x4]
               	cmp	w3, #0x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
