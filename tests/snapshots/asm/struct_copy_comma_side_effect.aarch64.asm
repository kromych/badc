
struct_copy_comma_side_effect.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
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
               	str	w0, [x1]
               	sxtw	x0, w0
               	ret

<via_global_member>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	strb	w0, [x1]
               	ldrsw	x0, [x1, #0x4]
               	ret

<via_deref>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
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
               	strb	w0, [x1]
               	sxtb	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20, #0x4]
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	ldrsw	x0, [x20, #0x4]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x21, #0x4]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	ldrsw	x0, [x21, #0x4]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x20, #0x4]
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	ldrsw	x0, [x20, #0x4]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
