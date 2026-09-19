
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, #0x8
               	ldr	x2, [x0]
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x2, [x0, #0x8]
               	cbnz	x2, <addr>
               	ldr	x2, [x0, #0x10]
               	cbnz	x2, <addr>
               	ldr	x0, [x0, #0x18]
               	cbnz	x0, <addr>
               	ldr	x0, [x1]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	ldr	x0, [x1, #0x28]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	w0, #0x3
               	b.ge	<addr>
               	add	x3, x1, #0x4
               	lsl	x2, x0, #3
               	add	x3, x3, x2
               	ldrsw	x3, [x3]
               	cmp	w3, #0x7
               	b.ne	<addr>
               	add	x3, x1, #0x4
               	add	x2, x3, x2
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0x8
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	ret
