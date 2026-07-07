
nonconst_local_struct_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x19, [sp]
               	mov	x2, #0x2a               // =42
               	mov	x0, #0x63               // =99
               	sub	x1, x29, #0x18
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x18
               	str	w2, [x1]
               	sub	x1, x29, #0x18
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2a
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x18
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x7                // =7
               	sub	x3, x29, #0x20
               	str	w1, [x3]
               	sub	x1, x29, #0x20
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x20
               	ldrsw	x1, [x1]
               	cmp	x1, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x20
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x20
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0xb                // =11
               	sub	x3, x29, #0x28
               	str	w1, [x3]
               	mov	x3, #0x16               // =22
               	sub	x1, x29, #0x28
               	str	w3, [x1, #0x4]
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	cmp	x1, #0xb
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x16
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x28
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x4]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x38
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
               	sub	x1, x29, #0x38
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	str	w0, [x1, #0x8]
               	sub	x1, x29, #0x38
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2a
               	cset	x3, ne
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x38
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x38
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x38
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x38
               	ldrsw	x3, [x0, #0x4]
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	str	w0, [x1, #0x8]
               	sub	x1, x29, #0x48
               	str	w2, [x1]
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2a
               	cset	x3, ne
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x48
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x48
               	ldrsw	x3, [x0, #0x4]
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x58
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
               	sub	x1, x29, #0x58
               	str	w2, [x1]
               	sub	x1, x29, #0x58
               	str	w0, [x1, #0x8]
               	sub	x1, x29, #0x58
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2a
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x58
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x58
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x58
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x58
               	ldrsw	x3, [x0, #0x4]
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x68
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
               	sub	x1, x29, #0x78
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
               	sub	x1, x29, #0x78
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x63
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x78
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x78
               	ldrsw	x3, [x0, #0x4]
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
