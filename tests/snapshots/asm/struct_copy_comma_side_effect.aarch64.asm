
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0, #0x4]
               	mov	x2, #0x9                // =9
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x5]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x5, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x5, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x5, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x5, #0xb]
               	ldr	x10, [sp], #0x10
               	str	w2, [x4]
               	ldrsw	x2, [x0, #0x4]
               	cmp	w2, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	w1, [x4, #0x4]
               	mov	x5, #0x3                // =3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x2, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x2, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x2, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x2, #0xb]
               	ldr	x10, [sp], #0x10
               	strb	w5, [x2]
               	ldrsw	x2, [x4, #0x4]
               	cmp	w2, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	str	w1, [x0, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x1                // =1
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	strb	w4, [x2]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, x5
               	ret
               	mov	x0, x1
               	ret
