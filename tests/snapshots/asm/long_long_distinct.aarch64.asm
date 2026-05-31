
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x0, [x14]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x0, [x21]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
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
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
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
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x64              // =100
               	mov	x0, #0xc8               // =200
               	add	x15, x15, x0
               	cmp	x15, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x40
               	mov	x0, #0xa                // =10
               	str	x0, [x15]
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x8
               	mov	x0, #0x14               // =20
               	str	x0, [x13]
               	sub	x15, x29, #0x40
               	add	x15, x15, #0x10
               	mov	x0, #0x1e               // =30
               	str	x0, [x15]
               	sub	x13, x29, #0x40
               	add	x0, x13, #0x8
               	ldr	x15, [x0]
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x13, x13, #0x10
               	ldr	x15, [x13]
               	cmp	x15, #0x1e
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x60
               	mov	x0, #0x64               // =100
               	str	x0, [x15]
               	sub	x13, x29, #0x60
               	add	x13, x13, #0x8
               	mov	x0, #0xc8               // =200
               	str	x0, [x13]
               	sub	x15, x29, #0x60
               	add	x15, x15, #0x10
               	mov	x0, #0x12c              // =300
               	str	x0, [x15]
               	sub	x13, x29, #0x60
               	add	x0, x13, #0x8
               	ldr	x15, [x0]
               	cmp	x15, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x13, x13, #0x10
               	ldr	x15, [x13]
               	cmp	x15, #0x12c
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
