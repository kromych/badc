
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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x9, x15
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x12, x0
               	cmp	x12, #0x5
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x12, <page>
               	add	x12, x12, #0xd0
               	add	x12, x12, #0x10
               	ldr	x12, [x12]
               	mov	x0, #0xa                // =10
               	mov	x1, #0x4                // =4
               	mov	x9, x12
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x15, x0
               	cmp	x15, #0x6
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	add	x15, x15, #0x18
               	ldr	x15, [x15]
               	ldrb	w15, [x15]
               	mov	x17, #0x64              // =100
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x1, #0x5                // =5
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf8
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	mov	x0, #0x7                // =7
               	mov	x1, #0x8                // =8
               	mov	x9, x15
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x12, x0
               	cmp	x12, #0xf
               	b.eq	<addr>
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x12, <page>
               	add	x12, x12, #0xf8
               	add	x12, x12, #0x18
               	ldr	x12, [x12]
               	ldrb	w12, [x12]
               	mov	x17, #0x61              // =97
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x1, #0x7                // =7
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x12, <page>
               	add	x12, x12, #0x120
               	ldrsw	x12, [x12]
               	cmp	x12, #0x3
               	b.eq	<addr>
               	mov	x1, #0x8                // =8
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x12, <page>
               	add	x12, x12, #0x120
               	add	x12, x12, #0x8
               	ldr	x12, [x12]
               	mov	x0, #0x1                // =1
               	mov	x9, x12
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
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x120
               	add	x1, x1, #0x10
               	ldr	x1, [x1]
               	mov	x0, #0x5                // =5
               	mov	x12, #0x1               // =1
               	mov	x9, x1
               	str	x12, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x15, x0
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x12, #0xa               // =10
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	ldrsw	x15, [x15]
               	cmp	x15, #0xa
               	b.eq	<addr>
               	mov	x12, #0xb               // =11
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x12, #0xc               // =12
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x12, #0xd               // =13
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x12, #0xe               // =14
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
