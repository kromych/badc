
tentative_array_sized_later.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x2, x0, lsl #2
               	ldrsh	x3, [x1]
               	cbnz	w3, <addr>
               	ldrsh	x1, [x1, #0x2]
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x48
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	strh	w1, [x0, #0x11e]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x9                // =9
               	str	w0, [x1, #0xc]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	add	x1, x1, #0x8
               	cmp	x0, x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x17, #0x1111111111111111 // =1229782938247303441
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x60]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x80]
               	cmp	w0, #0x5
               	mov	x17, #0x6               // =6
               	csel	x0, xzr, x17, eq
               	ret
               	mov	x0, #0x2                // =2
               	ret
