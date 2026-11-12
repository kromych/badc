
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x0, x2, #0xc
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x28]
               	cmp	x3, x0
               	b.ne	<addr>
               	adrp	x3, <page>
               	ldr	x3, [x3, <lo12>]
               	cmp	x3, x0
               	b.ne	<addr>
               	adrp	x3, <page>
               	ldr	x4, [x3, #0x38]
               	ldr	x5, [x4, #0x8]
               	cmp	x5, x0
               	b.ne	<addr>
               	ldr	x0, [x4]
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x0, [x1, #0x28]
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	ldr	x0, [x3, #0x38]
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x1, #0x28]
               	add	x1, x0, #0xc
               	sub	x0, x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	cmp	x0, #0xc
               	csel	x0, x1, x2, eq
               	ret
