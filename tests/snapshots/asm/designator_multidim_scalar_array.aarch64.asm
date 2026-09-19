
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	w0, #0x4
               	b.ge	<addr>
               	add	x4, x1, #0x20
               	sxtw	x2, w0
               	lsl	x3, x2, #3
               	add	x4, x4, x3
               	ldrsw	x4, [x4]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	add	x2, x4, x3
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0xa
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sxtw	x2, w0
               	lsl	x3, x2, #3
               	add	x4, x1, x3
               	ldrsw	x4, [x4]
               	cbnz	x4, <addr>
               	add	x2, x1, x3
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
