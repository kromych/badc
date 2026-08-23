
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

<via_global_scalar>:
               	mov	x0, #0x9                // =9
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
               	mov	x1, #0x3                // =3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	strb	w1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	ret

<via_deref>:
               	mov	x0, #0x1                // =1
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
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x21, #0x0               // =0
               	str	w21, [x20, #0x4]
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	ldrsw	x0, [x20, #0x4]
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	w21, [x22, #0x4]
               	mov	x23, #0x3               // =3
               	mov	x0, x23
               	bl	<addr>
               	ldrsw	x0, [x22, #0x4]
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	str	w21, [x20, #0x4]
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	ldrsw	x0, [x20, #0x4]
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, x23
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
