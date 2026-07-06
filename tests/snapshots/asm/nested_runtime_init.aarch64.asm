
nested_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x18
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x18
               	str	w1, [x2]
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	sub	x3, x29, #0x18
               	str	x2, [x3, #0x8]
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2]
               	cmp	x2, x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x2, x29, #0x18
               	ldr	x2, [x2, #0x8]
               	add	x3, x1, #0x1
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x2, x29, #0x28
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	lsl	x2, x1, #1
               	sub	x3, x29, #0x28
               	str	w2, [x3]
               	add	x2, x1, #0x3
               	sxtw	x2, w2
               	sub	x3, x29, #0x28
               	str	x2, [x3, #0x8]
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2]
               	lsl	x3, x1, #1
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x2, x29, #0x28
               	ldr	x2, [x2, #0x8]
               	add	x3, x1, #0x3
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x2, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x38
               	str	w1, [x2]
               	lsl	x2, x1, #1
               	sub	x3, x29, #0x38
               	str	w2, [x3, #0x4]
               	add	x2, x1, #0x5
               	sxtw	x2, w2
               	sub	x3, x29, #0x38
               	str	x2, [x3, #0x8]
               	sub	x2, x29, #0x38
               	ldrsw	x2, [x2]
               	cmp	x2, x0
               	cset	x2, ne
               	mov	x4, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x38
               	ldrsw	x2, [x2, #0x4]
               	lsl	x3, x1, #1
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x4, ne
               	cbnz	x4, <addr>
               	sub	x2, x29, #0x38
               	ldr	x2, [x2, #0x8]
               	add	x3, x1, #0x5
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x4, ne
               	cbnz	x4, <addr>
               	sub	x2, x29, #0x48
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
               	sub	x2, x29, #0x48
               	str	w1, [x2]
               	add	x2, x1, #0x1
               	sub	x3, x29, #0x48
               	str	w2, [x3, #0x4]
               	add	x2, x1, #0x2
               	sub	x3, x29, #0x48
               	str	w2, [x3, #0x8]
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2]
               	cmp	x2, x0
               	cset	x2, ne
               	mov	x4, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0x4]
               	add	x3, x1, #0x1
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x4, ne
               	cbnz	x4, <addr>
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0x8]
               	add	x3, x1, #0x2
               	sxtw	x3, w3
               	cmp	x2, x3
               	cset	x4, ne
               	cbz	x4, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
