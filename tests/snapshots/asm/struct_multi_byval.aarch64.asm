
struct_multi_byval.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x20]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x28]
               	str	x16, [sp, #0x10]
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x16, x29, #0x18
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x4, [x16]
               	sub	x16, x29, #0x30
               	str	x5, [x16]
               	str	x6, [x16, #0x8]
               	mov	x5, x7
               	sxtw	x1, w1
               	sxtw	x5, w5
               	sub	x0, x29, #0x48
               	ldur	x2, [x29, #0x70]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	sub	x2, x29, #0x8
               	ldrsw	x2, [x2]
               	sub	x3, x29, #0x8
               	ldrsw	x3, [x3, #0x4]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	add	x1, x2, x1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x8]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x20
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x30
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x30
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x30
               	ldrsw	x2, [x2, #0x8]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x30
               	ldrsw	x2, [x2, #0xc]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x1, x1, x5
               	sxtw	x1, w1
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0x8]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0xc]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0x10]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x48
               	ldrsw	x2, [x2, #0x14]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldursw	x2, [x29, #0x80]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x80
               	ret

<make2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sub	x1, x29, #0x8
               	str	w0, [x1]
               	sub	x1, x29, #0x8
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	str	w0, [x1]
               	sub	x1, x29, #0x10
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x10
               	add	x2, x0, #0x2
               	sxtw	x2, w2
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x10
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	str	w0, [x1, #0xc]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make6>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x8, [x16]
               	sxtw	x0, w0
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x1, x29, #0x18
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x18
               	add	x2, x0, #0x2
               	sxtw	x2, w2
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x18
               	add	x2, x0, #0x3
               	sxtw	x2, w2
               	str	w2, [x1, #0xc]
               	sub	x1, x29, #0x18
               	add	x2, x0, #0x4
               	sxtw	x2, w2
               	str	w2, [x1, #0x10]
               	sub	x1, x29, #0x18
               	add	x0, x0, #0x5
               	sxtw	x0, w0
               	str	w0, [x1, #0x14]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	sub	x17, x29, #0x20
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x160
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, #0xd8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, #0xe0
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
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, #0xec
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	mov	x1, #0x3e8              // =1000
               	sub	x2, x29, #0x18
               	sub	x3, x29, #0x20
               	sub	x4, x29, #0x30
               	mov	x5, #0x7d0              // =2000
               	sub	x6, x29, #0x48
               	mov	x7, #0xbb8              // =3000
               	sub	sp, sp, #0x10
               	str	x6, [sp]
               	str	x7, [sp, #0x8]
               	mov	x7, x5
               	mov	x5, x4
               	mov	x4, x3
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x4, [x4]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldr	x0, [x0]
               	mov	x17, #0x1a12            // =6674
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	sub	x16, x29, #0xc8
               	str	x0, [x16]
               	sub	x0, x29, #0xc8
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0]
               	cmp	x0, #0x32
               	cset	x20, ne
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x33
               	cset	x20, ne
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3c               // =60
               	bl	<addr>
               	sub	x16, x29, #0xe0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3c
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x3d
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	mov	x21, #0x1               // =1
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x3e
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x3f
               	cset	x21, ne
               	b	<addr>
               	cbz	x21, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x46               // =70
               	sub	x8, x29, #0x110
               	bl	<addr>
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x90
               	ldrsw	x0, [x0]
               	cmp	x0, #0x46
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x90
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x47
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	mov	x21, #0x1               // =1
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x90
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x48
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	mov	x20, #0x1               // =1
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x90
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x49
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	mov	x21, #0x1               // =1
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x90
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x4a
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x90
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x4b
               	cset	x21, ne
               	b	<addr>
               	cbz	x21, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x50
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	bl	<addr>
               	sub	x16, x29, #0x140
               	str	x0, [x16]
               	sub	x0, x29, #0x140
               	sub	x1, x29, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xb0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x65
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0xb0
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x66
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x160
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
