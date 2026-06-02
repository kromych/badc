
local_array_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0xf8
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sxtw	x15, w0
               	sub	x14, x29, #0x8
               	adrp	x13, <page>
               	add	x13, x13, #0x548
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x13]
               	strb	w10, [x14]
               	ldrb	w10, [x13, #0x1]
               	strb	w10, [x14, #0x1]
               	ldrb	w10, [x13, #0x2]
               	strb	w10, [x14, #0x2]
               	ldrb	w10, [x13, #0x3]
               	strb	w10, [x14, #0x3]
               	ldr	x10, [sp], #0x10
               	adrp	x14, <page>
               	add	x14, x14, #0x148
               	lsl	x13, x15, #1
               	add	x14, x14, x13
               	ldrh	w14, [x14]
               	sub	x13, x29, #0x8
               	strh	w14, [x13]
               	adrp	x12, <page>
               	add	x12, x12, #0x348
               	lsl	x15, x15, #1
               	add	x12, x12, x15
               	ldrh	w12, [x12]
               	sub	x15, x29, #0x8
               	add	x15, x15, #0x2
               	strh	w12, [x15]
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	mov	x17, #0x3e8             // =1000
               	mul	x13, x13, x17
               	sxtw	x13, w13
               	sub	x15, x29, #0x8
               	add	x15, x15, #0x2
               	ldrh	w15, [x15]
               	add	x13, x13, x15
               	sxtw	x0, w13
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sub	x13, x29, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x54c
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldrb	w10, [x12, #0x8]
               	strb	w10, [x13, #0x8]
               	ldrb	w10, [x12, #0x9]
               	strb	w10, [x13, #0x9]
               	ldrb	w10, [x12, #0xa]
               	strb	w10, [x13, #0xa]
               	ldrb	w10, [x12, #0xb]
               	strb	w10, [x13, #0xb]
               	ldr	x10, [sp], #0x10
               	add	x13, x15, x14
               	sxtw	x13, w13
               	sub	x12, x29, #0x10
               	str	w13, [x12]
               	sub	x11, x15, x14
               	sxtw	x11, w11
               	sub	x12, x29, #0x10
               	add	x12, x12, #0x4
               	str	w11, [x12]
               	mul	x15, x15, x14
               	sxtw	x15, w15
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	str	w15, [x14]
               	sub	x13, x29, #0x10
               	ldrsw	x13, [x13]
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	add	x13, x13, x14
               	sxtw	x13, w13
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	add	x13, x13, x14
               	sxtw	x0, w13
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	mov	x15, x0
               	mov	x14, x1
               	sub	x13, x29, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x558
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldr	x10, [x12, #0x8]
               	str	x10, [x13, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x13, x15, x14
               	sub	x12, x29, #0x10
               	str	x13, [x12]
               	sub	x15, x15, x14
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	str	x15, [x14]
               	sub	x11, x29, #0x10
               	ldr	x11, [x11]
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	ldr	x14, [x14]
               	add	x11, x11, x14
               	sxtw	x0, w11
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sxtw	x15, w0
               	sub	x14, x29, #0x8
               	adrp	x13, <page>
               	add	x13, x13, #0x568
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x13]
               	strb	w10, [x14]
               	ldrb	w10, [x13, #0x1]
               	strb	w10, [x14, #0x1]
               	ldrb	w10, [x13, #0x2]
               	strb	w10, [x14, #0x2]
               	ldrb	w10, [x13, #0x3]
               	strb	w10, [x14, #0x3]
               	ldr	x10, [sp], #0x10
               	add	x14, x15, #0x61
               	sxtw	x14, w14
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	sub	x13, x29, #0x8
               	strb	w14, [x13]
               	mov	x12, #0x62              // =98
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x1
               	strb	w12, [x13]
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x2
               	strb	w15, [x14]
               	mov	x13, #0x64              // =100
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x3
               	strb	w13, [x14]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x10]
               	stur	w15, [x29, #-0x18]
               	b	<addr>
               	ldursw	x15, [x29, #-0x18]
               	cmp	x15, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x18
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x13, [x15]
               	sub	x14, x29, #0x8
               	ldursw	x12, [x29, #-0x18]
               	add	x14, x14, x12
               	ldrb	w14, [x14]
               	add	x13, x13, x14
               	str	w13, [x15]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	add	x15, x15, #0xa
               	mov	x14, #0x1234            // =4660
               	strh	w14, [x15]
               	adrp	x13, <page>
               	add	x13, x13, #0x348
               	add	x13, x13, #0xa
               	mov	x14, #0x5678            // =22136
               	strh	w14, [x13]
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x14, x0
               	mov	x17, #0x7198            // =29080
               	movk	x17, #0x47, lsl #16
               	cmp	x14, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x3               // =3
               	mov	x1, #0x4                // =4
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x14
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0x56c
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	add	x1, x1, x0
               	sxtw	x1, w1
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	add	x1, x1, x0
               	sxtw	x1, w1
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, #0x57e
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x18
               	ldrb	w1, [x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	stur	x1, [x29, #-0x28]
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x4
               	ldrb	w0, [x0]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x28]
               	b	<addr>
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x20]
               	cbnz	x0, <addr>
               	sub	x1, x29, #0x18
               	add	x1, x1, #0x5
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	stur	x1, [x29, #-0x20]
               	b	<addr>
               	ldur	x1, [x29, #-0x20]
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
