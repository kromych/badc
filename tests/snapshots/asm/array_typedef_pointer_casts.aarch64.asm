
array_typedef_pointer_casts.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, #0xc
               	adrp	x3, <page>
               	ldr	x2, [x3, #0x28]
               	cmp	x2, x0
               	b.ne	<addr>
               	adrp	x4, <page>
               	ldr	x4, [x4, <lo12>]
               	cmp	x4, x0
               	b.ne	<addr>
               	adrp	x4, <page>
               	ldr	x4, [x4, <lo12>]
               	ldr	x5, [x4, #0x8]
               	cmp	x5, x0
               	b.ne	<addr>
               	ldr	x0, [x4]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x0, [x2, #0x8]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	ldr	x0, [x4]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x3, #0x28]
               	add	x1, x0, #0xc
               	sub	x0, x1, x0
               	cmp	x0, #0xc
               	mov	x17, #0x3               // =3
               	csel	x0, xzr, x17, eq
               	ret
