
long_long_distinct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x19, [sp]
               	b	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xcdef            // =52719
               	movk	x15, #0x89ab, lsl #16
               	movk	x15, #0x4567, lsl #32
               	movk	x15, #0x123, lsl #48
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x64              // =100
               	mov	x14, #0xc8              // =200
               	add	x15, x15, x14
               	cmp	x15, #0x12c
               	b.eq	<addr>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x40
               	mov	x14, #0xa               // =10
               	str	x14, [x15]
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x8
               	mov	x14, #0x14              // =20
               	str	x14, [x13]
               	sub	x15, x29, #0x40
               	add	x15, x15, #0x10
               	mov	x14, #0x1e              // =30
               	str	x14, [x15]
               	sub	x13, x29, #0x40
               	add	x14, x13, #0x8
               	ldr	x14, [x14]
               	cmp	x14, #0x14
               	b.eq	<addr>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x13, x13, #0x10
               	ldr	x13, [x13]
               	cmp	x13, #0x1e
               	b.eq	<addr>
               	mov	x14, #0xa               // =10
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x60
               	mov	x14, #0x64              // =100
               	str	x14, [x13]
               	sub	x15, x29, #0x60
               	add	x15, x15, #0x8
               	mov	x14, #0xc8              // =200
               	str	x14, [x15]
               	sub	x13, x29, #0x60
               	add	x13, x13, #0x10
               	mov	x14, #0x12c             // =300
               	str	x14, [x13]
               	sub	x15, x29, #0x60
               	add	x14, x15, #0x8
               	ldr	x14, [x14]
               	cmp	x14, #0xc8
               	b.eq	<addr>
               	mov	x13, #0xb               // =11
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x15, x15, #0x10
               	ldr	x15, [x15]
               	cmp	x15, #0x12c
               	b.eq	<addr>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
