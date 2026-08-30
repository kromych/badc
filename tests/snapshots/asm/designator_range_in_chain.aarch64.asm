
designator_range_in_chain.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	add	x0, x0, #0x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	ldr	x0, [x0, #0x10]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	ldr	x0, [x0, #0x18]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x28]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	add	x1, x3, #0x4
               	sxtw	x2, w0
               	lsl	x4, x2, #3
               	add	x1, x1, x4
               	ldrsw	x1, [x1]
               	cmp	w1, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x1, x3, #0x4
               	add	x1, x1, x4
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	b	<addr>
