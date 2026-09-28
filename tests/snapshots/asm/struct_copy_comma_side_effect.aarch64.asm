
struct_copy_comma_side_effect.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	str	w0, [x1, #0x4]
               	mov	x2, #0x9                // =9
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x1]
               	ldr	w16, [x3, #0x8]
               	str	w16, [x1, #0x8]
               	str	w2, [x4]
               	ldrsw	x2, [x1, #0x4]
               	cmp	w2, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w0, [x2, #0x4]
               	mov	x4, #0x3                // =3
               	ldr	x16, [x3]
               	str	x16, [x2]
               	ldr	w16, [x3, #0x8]
               	str	w16, [x2, #0x8]
               	strb	w4, [x2]
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	str	w0, [x1, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x5, #0x1                // =1
               	ldr	x16, [x3]
               	str	x16, [x1]
               	ldr	w16, [x3, #0x8]
               	str	w16, [x1, #0x8]
               	strb	w5, [x2]
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0xf
               	b.eq	<addr>
               	mov	x0, x4
               	ret
               	ret
