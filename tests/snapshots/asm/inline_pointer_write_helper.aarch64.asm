
inline_pointer_write_helper.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	mov	x1, #0x28               // =40
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0, #0x4]
               	add	x1, x1, #0x5
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0, #0x8]
               	sub	x1, x1, #0x1
               	str	w1, [x0, #0x8]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x10
               	ldrsw	x2, [x1]
               	ldrsw	x3, [x0, #0x8]
               	str	w3, [x1]
               	str	w2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x0
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0, #0x4]
               	add	x1, x1, #0xb
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0, #0x8]
               	add	x1, x1, #0x15
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0, #0xc]
               	add	x1, x1, #0x1f
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0xb
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x15
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x1f
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
