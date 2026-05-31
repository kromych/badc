
array_initializers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x15e
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x15]
               	ldrb	w10, [x14, #0x1]
               	strb	w10, [x15, #0x1]
               	ldrb	w10, [x14, #0x2]
               	strb	w10, [x15, #0x2]
               	ldrb	w10, [x14, #0x3]
               	strb	w10, [x15, #0x3]
               	ldrb	w10, [x14, #0x4]
               	strb	w10, [x15, #0x4]
               	ldrb	w10, [x14, #0x5]
               	strb	w10, [x15, #0x5]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x18
               	adrp	x19, <page>
               	add	x19, x19, #0x164
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x13]
               	ldrb	w10, [x14, #0x8]
               	strb	w10, [x13, #0x8]
               	ldrb	w10, [x14, #0x9]
               	strb	w10, [x13, #0x9]
               	ldrb	w10, [x14, #0xa]
               	strb	w10, [x13, #0xa]
               	ldrb	w10, [x14, #0xb]
               	strb	w10, [x13, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	sub	x15, x29, #0x20
               	adrp	x19, <page>
               	add	x19, x19, #0x173
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x38
               	adrp	x19, <page>
               	add	x19, x19, #0x17b
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x13]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x13, #0x8]
               	ldrb	w10, [x14, #0x10]
               	strb	w10, [x13, #0x10]
               	ldrb	w10, [x14, #0x11]
               	strb	w10, [x13, #0x11]
               	ldrb	w10, [x14, #0x12]
               	strb	w10, [x13, #0x12]
               	ldrb	w10, [x14, #0x13]
               	strb	w10, [x13, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	adrp	x19, <page>
               	add	x19, x19, #0xd6
               	mov	x15, x19
               	ldrb	w14, [x15]
               	mov	x17, #0x68              // =104
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd6
               	mov	x14, x19
               	add	x14, x14, #0x4
               	ldrb	w0, [x14]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd6
               	mov	x0, x19
               	add	x0, x0, #0x5
               	ldrb	w14, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	cbz	x14, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x14, x19
               	ldrsw	x0, [x14]
               	add	x13, x14, #0x4
               	ldrsw	x12, [x13]
               	add	x0, x0, x12
               	sxtw	x0, w0
               	add	x12, x14, #0x8
               	ldrsw	x13, [x12]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	add	x13, x14, #0xc
               	ldrsw	x12, [x13]
               	add	x0, x0, x12
               	sxtw	x0, w0
               	add	x14, x14, #0x10
               	ldrsw	x12, [x14]
               	add	x0, x0, x12
               	sxtw	x0, w0
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x12, #0x5               // =5
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	ldrb	w12, [x0]
               	mov	x17, #0x68              // =104
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	add	x12, x12, #0x1
               	ldrb	w0, [x12]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x8               // =8
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	add	x0, x0, #0x2
               	ldrb	w12, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	add	x12, x12, #0xf
               	ldrb	w0, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0xa               // =10
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0xb               // =11
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x0, x19
               	ldrsw	x12, [x0]
               	cmp	x12, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	add	x12, x12, #0x8
               	ldrsw	x0, [x12]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x12, #0xd               // =13
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x0, x19
               	add	x0, x0, #0xc
               	ldrsw	x12, [x0]
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	add	x12, x12, #0x10
               	ldrsw	x0, [x12]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0xf               // =15
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x140
               	mov	x0, x19
               	ldr	x12, [x0]
               	ldrb	w0, [x12]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x10              // =16
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x140
               	mov	x0, x19
               	add	x0, x0, #0x8
               	ldr	x12, [x0]
               	ldrb	w0, [x12]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x11              // =17
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x140
               	mov	x0, x19
               	add	x0, x0, #0x10
               	ldr	x12, [x0]
               	add	x12, x12, #0x4
               	ldrb	w0, [x12]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x12              // =18
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrb	w12, [x0]
               	mov	x17, #0x77              // =119
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	add	x12, x12, #0x4
               	ldrb	w0, [x12]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x14              // =20
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x5
               	ldrb	w12, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	cbz	x12, <addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x18
               	ldrsw	x0, [x12]
               	sub	x12, x29, #0x18
               	add	x12, x12, #0x4
               	ldrsw	x14, [x12]
               	add	x0, x0, x14
               	sxtw	x0, w0
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x8
               	ldrsw	x12, [x14]
               	add	x0, x0, x12
               	sxtw	x0, w0
               	cmp	x0, #0x258
               	b.eq	<addr>
               	mov	x12, #0x17              // =23
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0x18              // =24
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w12, [x0]
               	mov	x17, #0x6f              // =111
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x20
               	add	x12, x12, #0x1
               	ldrb	w0, [x12]
               	mov	x17, #0x6b              // =107
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x1a              // =26
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x2
               	ldrb	w12, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x38
               	ldrsw	x0, [x12]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x12, #0x1c              // =28
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	add	x0, x0, #0x8
               	ldrsw	x12, [x0]
               	cmp	x12, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x38
               	add	x12, x12, #0xc
               	ldrsw	x0, [x12]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x1e              // =30
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	add	x0, x0, #0x10
               	ldrsw	x12, [x0]
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x20
               	add	x12, x12, #0x3
               	ldrb	w0, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x20              // =32
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x7
               	ldrb	w12, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
