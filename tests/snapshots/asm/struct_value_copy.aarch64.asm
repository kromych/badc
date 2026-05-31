
struct_value_copy.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x15, x29, #0x8
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	mov	x14, #0x2               // =2
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	mov	x14, #0x63              // =99
               	str	w14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x4
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	sub	x13, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x13]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x10
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	mov	x0, #0x3e8              // =1000
               	str	w0, [x15]
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x4
               	mov	x0, #0x7d0              // =2000
               	str	w0, [x14]
               	sub	x15, x29, #0x10
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	mov	x0, #0x7                // =7
               	str	w0, [x15]
               	sub	x14, x29, #0x20
               	add	x14, x14, #0x4
               	mov	x0, #0xe                // =14
               	str	w0, [x14]
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x8
               	mov	x0, #0x15               // =21
               	str	w0, [x15]
               	sub	x14, x29, #0x30
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x14, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x14, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x14, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x14, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x14, x29, #0x30
               	ldrsw	x14, [x14]
               	cmp	x14, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x30
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	cmp	x14, #0xe
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x30
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	cmp	x14, #0x15
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	mov	x0, #0x32               // =50
               	str	w0, [x14]
               	sub	x15, x29, #0x8
               	add	x15, x15, #0x4
               	mov	x0, #0x3c               // =60
               	str	w0, [x15]
               	sub	x14, x29, #0x8
               	sub	x0, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldr	x10, [sp], #0x10
               	sub	x14, x29, #0x8
               	ldrsw	x14, [x14]
               	cmp	x14, #0x32
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	cmp	x14, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
