
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
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
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
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
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sxtw	x15, w0
               	sub	x14, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x548
               	mov	x13, x19
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
               	mov	x12, x14
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x12, x19
               	lsl	x13, x15, #1
               	add	x12, x12, x13
               	ldrh	w13, [x12]
               	sub	x12, x29, #0x8
               	strh	w13, [x12]
               	adrp	x19, <page>
               	add	x19, x19, #0x348
               	mov	x14, x19
               	lsl	x15, x15, #1
               	add	x14, x14, x15
               	ldrh	w15, [x14]
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x2
               	strh	w15, [x14]
               	sub	x12, x29, #0x8
               	ldrh	w14, [x12]
               	mov	x17, #0x3e8             // =1000
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	sub	x12, x29, #0x8
               	add	x12, x12, #0x2
               	ldrh	w15, [x12]
               	add	x14, x14, x15
               	sxtw	x0, w14
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
               	adrp	x19, <page>
               	add	x19, x19, #0x54c
               	mov	x12, x19
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
               	mov	x11, x13
               	add	x11, x15, x14
               	sxtw	x11, w11
               	sub	x12, x29, #0x10
               	str	w11, [x12]
               	sub	x13, x15, x14
               	sxtw	x13, w13
               	sub	x12, x29, #0x10
               	add	x12, x12, #0x4
               	str	w13, [x12]
               	mul	x15, x15, x14
               	sxtw	x15, w15
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	str	w15, [x14]
               	sub	x11, x29, #0x10
               	ldrsw	x14, [x11]
               	sub	x11, x29, #0x10
               	add	x11, x11, #0x4
               	ldrsw	x15, [x11]
               	add	x14, x14, x15
               	sxtw	x14, w14
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x8
               	ldrsw	x11, [x15]
               	add	x14, x14, x11
               	sxtw	x0, w14
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
               	adrp	x19, <page>
               	add	x19, x19, #0x558
               	mov	x12, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldr	x10, [x12, #0x8]
               	str	x10, [x13, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x11, x13
               	add	x11, x15, x14
               	sub	x12, x29, #0x10
               	str	x11, [x12]
               	sub	x15, x15, x14
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	str	x15, [x14]
               	sub	x13, x29, #0x10
               	ldr	x14, [x13]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x8
               	ldr	x15, [x13]
               	add	x14, x14, x15
               	sxtw	x0, w14
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
               	adrp	x19, <page>
               	add	x19, x19, #0x568
               	mov	x13, x19
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
               	mov	x12, x14
               	add	x12, x15, #0x61
               	sxtw	x12, w12
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	sub	x13, x29, #0x8
               	strb	w12, [x13]
               	mov	x14, #0x62              // =98
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x1
               	strb	w14, [x13]
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	sub	x12, x29, #0x8
               	add	x12, x12, #0x2
               	strb	w15, [x12]
               	mov	x13, #0x64              // =100
               	sub	x12, x29, #0x8
               	add	x12, x12, #0x3
               	strb	w13, [x12]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x10]
               	stur	w15, [x29, #-0x18]
               	b	<addr>
               	ldursw	x15, [x29, #-0x18]
               	cmp	x15, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x18
               	ldrsw	x15, [x12]
               	add	x15, x15, #0x1
               	str	w15, [x12]
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x13, [x15]
               	sub	x12, x29, #0x8
               	ldursw	x14, [x29, #-0x18]
               	add	x12, x12, x14
               	ldrb	w14, [x12]
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x15, x19
               	add	x15, x15, #0xa
               	mov	x14, #0x1234            // =4660
               	strh	w14, [x15]
               	adrp	x19, <page>
               	add	x19, x19, #0x348
               	mov	x13, x19
               	add	x13, x13, #0xa
               	mov	x14, #0x5678            // =22136
               	strh	w14, [x13]
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	bl	<addr>
               	mov	x20, #0x1b20            // =6944
               	movk	x20, #0x47, lsl #16
               	sxtw	x20, w20
               	mov	x17, #0x5678            // =22136
               	add	x20, x20, x17
               	sxtw	x20, w20
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3               // =3
               	mov	x22, #0x4               // =4
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0xa               // =10
               	mov	x23, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x23, #0x3               // =3
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x56c
               	mov	x21, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x0]
               	ldrb	w10, [x21, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x21, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x21, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x21, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x20, x0
               	sub	x20, x29, #0x10
               	ldrsw	x21, [x20]
               	sub	x20, x29, #0x10
               	add	x20, x20, #0x4
               	ldrsw	x0, [x20]
               	add	x21, x21, x0
               	sxtw	x21, w21
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldrsw	x20, [x0]
               	add	x21, x21, x20
               	sxtw	x21, w21
               	cmp	x21, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x18
               	adrp	x19, <page>
               	add	x19, x19, #0x57e
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [sp], #0x10
               	mov	x20, x21
               	sub	x20, x29, #0x18
               	ldrb	w0, [x20]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x28]
               	cbnz	x0, <addr>
               	sub	x20, x29, #0x18
               	add	x20, x20, #0x4
               	ldrb	w0, [x20]
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
               	sub	x20, x29, #0x18
               	add	x20, x20, #0x5
               	ldrb	w0, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	cbz	x0, <addr>
               	mov	x20, #0x6               // =6
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
