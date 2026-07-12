
local_array_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x384
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<use_auto>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sxtw	x0, w0
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldrb	w10, [x2, #0x20]
               	strb	w10, [x1, #0x20]
               	ldrb	w10, [x2, #0x21]
               	strb	w10, [x1, #0x21]
               	ldrb	w10, [x2, #0x22]
               	strb	w10, [x1, #0x22]
               	ldrb	w10, [x2, #0x23]
               	strb	w10, [x1, #0x23]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x28
               	str	w0, [x1, #0x18]
               	add	x1, x0, #0x1
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x1c]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x20]
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0x28
               	str	w1, [x2]
               	mov	x2, #0xb                // =11
               	sub	x1, x29, #0x28
               	str	w2, [x1, #0x4]
               	mov	x2, #0xc                // =12
               	sub	x1, x29, #0x28
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	cmp	x1, #0xa
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0xc
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1, #0x18]
               	cmp	x1, x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1, #0x20]
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<use_fixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x1, x0
               	sxtw	x1, w1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cmp	x2, #0x9
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x4]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x0, #0x18]
               	cmp	x2, #0x9
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x1c]
               	cmp	x2, #0x8
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x0, #0xc]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x0, [x0, #0x24]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x24]
               	add	x0, x1, #0x1
               	sub	x2, x29, #0x30
               	str	w0, [x2, #0x28]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x30
               	str	w2, [x0, #0x2c]
               	mov	x2, #0x4                // =4
               	sub	x0, x29, #0x30
               	str	w2, [x0, #0xc]
               	mov	x2, #0x5                // =5
               	sub	x0, x29, #0x30
               	str	w2, [x0, #0x10]
               	mov	x2, #0x6                // =6
               	sub	x0, x29, #0x30
               	str	w2, [x0, #0x14]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x24]
               	cmp	x0, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x2, [x0, #0x28]
               	add	x0, x1, #0x1
               	sxtw	x0, w0
               	cmp	x2, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
