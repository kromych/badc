
struct_initializers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	add	x15, x15, x14
               	sxtw	x0, w15
               	ret
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sub	x15, x15, x14
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x20, <page>
               	add	x20, x20, #0xd0
               	ldrsw	x14, [x20]
               	cmp	x14, #0x1
               	b.eq	<addr>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x20, #0x8
               	ldr	x14, [x14]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x9, x14
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x11, x0
               	cmp	x11, #0x5
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x11, x20, #0x10
               	ldr	x11, [x11]
               	mov	x0, #0xa                // =10
               	mov	x1, #0x4                // =4
               	mov	x9, x11
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x14, x0
               	cmp	x14, #0x6
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x20, #0x18
               	ldr	x20, [x20]
               	ldrb	w20, [x20]
               	mov	x17, #0x64              // =100
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x20, <page>
               	add	x20, x20, #0xf8
               	ldrsw	x20, [x20]
               	cmp	x20, #0x2
               	b.eq	<addr>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x20, <page>
               	add	x20, x20, #0xf8
               	add	x20, x20, #0x8
               	ldr	x20, [x20]
               	mov	x0, #0x7                // =7
               	mov	x1, #0x8                // =8
               	mov	x9, x20
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x14, x0
               	cmp	x14, #0xf
               	b.eq	<addr>
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	add	x14, x14, #0x18
               	ldr	x14, [x14]
               	ldrb	w14, [x14]
               	mov	x17, #0x61              // =97
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x1, #0x7                // =7
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0x120
               	ldrsw	x14, [x14]
               	cmp	x14, #0x3
               	b.eq	<addr>
               	mov	x1, #0x8                // =8
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0x120
               	add	x14, x14, #0x8
               	ldr	x14, [x14]
               	mov	x0, #0x1                // =1
               	mov	x9, x14
               	str	x0, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x1, x0
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x120
               	add	x1, x1, #0x10
               	ldr	x1, [x1]
               	mov	x0, #0x5                // =5
               	mov	x14, #0x1               // =1
               	mov	x9, x1
               	str	x14, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x20, x0
               	cmp	x20, #0x4
               	b.eq	<addr>
               	mov	x14, #0xa               // =10
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x20, <page>
               	add	x20, x20, #0x148
               	ldrsw	x20, [x20]
               	cmp	x20, #0xa
               	b.eq	<addr>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x20, <page>
               	add	x20, x20, #0x148
               	add	x20, x20, #0x4
               	ldrsw	x20, [x20]
               	cmp	x20, #0x14
               	b.eq	<addr>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x20, <page>
               	add	x20, x20, #0x150
               	ldrsw	x20, [x20]
               	cmp	x20, #0x1
               	b.eq	<addr>
               	mov	x14, #0xd               // =13
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x20, <page>
               	add	x20, x20, #0x150
               	add	x20, x20, #0x4
               	ldrsw	x20, [x20]
               	cmp	x20, #0x2
               	b.eq	<addr>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
