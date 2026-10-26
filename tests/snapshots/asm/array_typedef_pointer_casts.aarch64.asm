
array_typedef_pointer_casts.aarch64:	file format elf64-littleaarch64

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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x0, x3, #0xc
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	cmp	x2, x0
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x2, x0
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x4, [x2]
               	ldr	x4, [x4, #0x8]
               	cmp	x4, x0
               	b.ne	<addr>
               	ldr	x0, [x2]
               	ldr	x0, [x0]
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x0, [x1]
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	ldr	x0, [x2]
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x1]
               	add	x1, x0, #0xc
               	sub	x0, x1, x0
               	cmp	x0, #0xc
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
