
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
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	str	w1, [x0]
               	add	x0, x1, #0x1
               	sxtw	x0, w0
               	sub	x2, x29, #0x18
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	sxtw	x2, w1
               	cmp	x0, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	cmp	x0, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	lsl	x0, x1, #1
               	sub	x2, x29, #0x28
               	str	w0, [x2]
               	add	x0, x1, #0x3
               	sxtw	x0, w0
               	sub	x2, x29, #0x28
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0]
               	lsl	x2, x1, #1
               	sxtw	x2, w2
               	cmp	x0, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x8]
               	add	x2, x1, #0x3
               	sxtw	x2, w2
               	cmp	x0, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x38
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x38
               	str	w1, [x0]
               	lsl	x0, x1, #1
               	sub	x2, x29, #0x38
               	str	w0, [x2, #0x4]
               	add	x0, x1, #0x5
               	sxtw	x0, w0
               	sub	x2, x29, #0x38
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0]
               	sxtw	x2, w1
               	cmp	x0, x2
               	cset	x0, ne
               	mov	x3, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x4]
               	lsl	x2, x1, #1
               	sxtw	x2, w2
               	cmp	x0, x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x38
               	ldr	x0, [x0, #0x8]
               	add	x2, x1, #0x5
               	sxtw	x2, w2
               	cmp	x0, x2
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x48
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
               	sub	x0, x29, #0x48
               	str	w1, [x0]
               	add	x0, x1, #0x1
               	sub	x2, x29, #0x48
               	str	w0, [x2, #0x4]
               	add	x0, x1, #0x2
               	sub	x2, x29, #0x48
               	str	w0, [x2, #0x8]
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0]
               	sxtw	x2, w1
               	cmp	x0, x2
               	cset	x0, ne
               	mov	x3, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0, #0x4]
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	cmp	x0, x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0, #0x8]
               	add	x2, x1, #0x2
               	sxtw	x2, w2
               	cmp	x0, x2
               	cset	x3, ne
               	cbz	x3, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
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
