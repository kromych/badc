
nested_runtime_init.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x1, x29, #0x18
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	add	x1, x0, #0x1
               	sxtw	x3, w1
               	sub	x1, x29, #0x18
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldr	x3, [x1, #0x8]
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x28
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	lsl	x1, x0, #1
               	sub	x3, x29, #0x28
               	str	w1, [x3]
               	add	x1, x0, #0x3
               	sxtw	x3, w1
               	sub	x1, x29, #0x28
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x28
               	ldrsw	x3, [x1]
               	lsl	x1, x0, #1
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x28
               	ldr	x3, [x1, #0x8]
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x38
               	str	w0, [x1]
               	lsl	x1, x0, #1
               	sub	x3, x29, #0x38
               	str	w1, [x3, #0x4]
               	add	x1, x0, #0x5
               	sxtw	x3, w1
               	sub	x1, x29, #0x38
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x38
               	ldrsw	x1, [x1]
               	cmp	x1, x2
               	cset	x3, ne
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x38
               	ldrsw	x3, [x1, #0x4]
               	lsl	x1, x0, #1
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x38
               	ldr	x3, [x1, #0x8]
               	add	x1, x0, #0x5
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x48
               	str	w0, [x1]
               	add	x1, x0, #0x1
               	sub	x3, x29, #0x48
               	str	w1, [x3, #0x4]
               	add	x1, x0, #0x2
               	sub	x3, x29, #0x48
               	str	w1, [x3, #0x8]
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1]
               	cmp	x1, x2
               	cset	x3, ne
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x48
               	ldrsw	x3, [x1, #0x4]
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x48
               	ldrsw	x3, [x1, #0x8]
               	add	x1, x0, #0x2
               	sxtw	x1, w1
               	cmp	x3, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
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
