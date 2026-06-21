
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
               	sub	sp, sp, #0x120
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x2a              // =42
               	mov	x21, #0x63              // =99
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	str	w20, [x0]
               	sub	x0, x29, #0x18
               	str	w21, [x0, #0x4]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x63
               	cset	x22, ne
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x4]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x7                // =7
               	sub	x1, x29, #0x20
               	str	w0, [x1]
               	sub	x0, x29, #0x20
               	str	w21, [x0, #0x4]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x63
               	cset	x22, ne
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x20
               	ldrsw	x2, [x2, #0x4]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	sub	x1, x29, #0x28
               	str	w0, [x1]
               	mov	x0, #0x16               // =22
               	bl	<addr>
               	sub	x1, x29, #0x28
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x16
               	cset	x22, ne
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
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
               	sub	x0, x29, #0x38
               	str	w20, [x0]
               	sub	x0, x29, #0x38
               	str	w21, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	cset	x0, ne
               	mov	x22, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x63
               	cset	x22, ne
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x38
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x38
               	ldrsw	x2, [x2, #0x4]
               	sub	x3, x29, #0x38
               	ldrsw	x3, [x3, #0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
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
               	sub	x0, x29, #0x48
               	str	w21, [x0, #0x8]
               	sub	x0, x29, #0x48
               	str	w20, [x0]
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	cset	x0, ne
               	mov	x22, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x63
               	cset	x22, ne
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0x4]
               	sub	x3, x29, #0x48
               	ldrsw	x3, [x3, #0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
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
               	sub	x0, x29, #0x58
               	str	w20, [x0]
               	sub	x0, x29, #0x58
               	str	w21, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x63
               	cset	x20, ne
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x58
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x58
               	ldrsw	x2, [x2, #0x4]
               	sub	x3, x29, #0x58
               	ldrsw	x3, [x3, #0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
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
               	sub	x0, x29, #0x78
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
               	sub	x0, x29, #0x78
               	str	w21, [x0, #0x4]
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x63
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x78
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x78
               	ldrsw	x2, [x2, #0x4]
               	sub	x3, x29, #0x78
               	ldrsw	x3, [x3, #0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
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
