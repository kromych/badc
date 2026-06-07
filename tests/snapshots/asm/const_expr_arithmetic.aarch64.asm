
const_expr_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	mov	x0, #0x20               // =32
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x338
               	mov	x1, #0x20               // =32
               	mov	x2, #0x4                // =4
               	sdiv	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x1               // =1
               	b	<addr>
               	mov	x0, #0x18               // =24
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x34b
               	mov	x1, #0x18               // =24
               	mov	x2, #0x4                // =4
               	sdiv	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	b	<addr>
               	mov	x0, #0x40               // =64
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x35e
               	mov	x1, #0x40               // =64
               	mov	x2, #0x4                // =4
               	sdiv	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x3               // =3
               	b	<addr>
               	mov	x0, #0x40               // =64
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x371
               	mov	x1, #0x40               // =64
               	mov	x20, #0x4               // =4
               	sdiv	x1, x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x18               // =24
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x384
               	mov	x1, #0x18               // =24
               	mov	x2, #0x4                // =4
               	sdiv	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x5               // =5
               	b	<addr>
               	mov	x0, #0x20               // =32
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x397
               	mov	x1, #0x20               // =32
               	mov	x2, #0x4                // =4
               	sdiv	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x6               // =6
               	b	<addr>
               	mov	x0, #0x18               // =24
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3ae
               	mov	x1, #0x18               // =24
               	mov	x2, #0x4                // =4
               	sdiv	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x7               // =7
               	b	<addr>
               	sxtw	x0, w20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
