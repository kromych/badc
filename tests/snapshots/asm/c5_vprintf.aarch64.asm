
c5_vprintf.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	mov	x4, x1
               	mov	x1, x3
               	mov	x5, x2
               	sxtw	x4, w4
               	sxtw	x5, w5
               	sxtw	x1, w1
               	sxtw	x2, w4
               	add	x2, x0, x2
               	mov	x3, #0x0                // =0
               	strb	w3, [x2]
               	cmp	x5, #0x0
               	b.ne	<addr>
               	sxtw	x1, w4
               	sub	x1, x1, #0x1
               	sxtw	x1, w1
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x2, #0x30               // =48
               	strb	w2, [x0]
               	sxtw	x0, w1
               	ret
               	b	<addr>
               	sxtw	x2, w5
               	cmp	x2, #0x0
               	b.eq	<addr>
               	cmp	x1, #0xa
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w4
               	ret
               	sxtw	x2, w5
               	mov	x3, #0xa                // =10
               	sdiv	x17, x2, x3
               	msub	x6, x17, x3, x2
               	sdiv	x5, x2, x3
               	b	<addr>
               	sxtw	x2, w4
               	sub	x2, x2, #0x1
               	sxtw	x4, w2
               	sxtw	x2, w6
               	cmp	x2, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x2, w5
               	mov	x17, #0xf               // =15
               	and	x6, x2, x17
               	asr	x2, x2, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x5, x2, x17
               	b	<addr>
               	sxtw	x2, w4
               	add	x2, x0, x2
               	sxtw	x3, w6
               	add	x3, x3, #0x30
               	sxtw	x3, w3
               	strb	w3, [x2]
               	b	<addr>
               	b	<addr>
               	sxtw	x2, w4
               	add	x2, x0, x2
               	sxtw	x3, w6
               	add	x3, x3, #0x61
               	sxtw	x3, w3
               	sub	x3, x3, #0xa
               	sxtw	x3, w3
               	strb	w3, [x2]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	mov	x23, x1
               	sxtw	x20, w20
               	sxtw	x23, w23
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	mov	x21, x0
               	mov	x22, #0x0               // =0
               	cmp	x23, #0x0
               	b.ge	<addr>
               	mov	x22, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x23, x23, x17
               	b	<addr>
               	mov	x1, #0x1f               // =31
               	sxtw	x2, w23
               	mov	x3, #0xa                // =10
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	sxtw	x0, w22
               	cbz	x0, <addr>
               	sxtw	x0, w23
               	sub	x0, x0, #0x1
               	sxtw	x23, w0
               	sxtw	x0, w23
               	add	x0, x21, x0
               	mov	x1, #0x2d               // =45
               	strb	w1, [x0]
               	b	<addr>
               	mov	x0, #0x1f               // =31
               	sxtw	x1, w23
               	sub	x0, x0, x1
               	sxtw	x22, w0
               	add	x1, x21, x1
               	sxtw	x2, w22
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	mov	x21, x1
               	sxtw	x20, w20
               	sxtw	x21, w21
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	mov	x22, x0
               	mov	x23, #0x1f              // =31
               	mov	x3, #0x10               // =16
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x1, x23, x0
               	sxtw	x21, w1
               	add	x1, x22, x0
               	sxtw	x2, w21
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x20, x0
               	mov	x23, x1
               	sxtw	x20, w20
               	sxtw	x23, w23
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	mov	x21, x0
               	add	x0, x21, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	mov	x22, #0xf               // =15
               	b	<addr>
               	sxtw	x0, w22
               	cmp	x0, #0x0
               	b.lt	<addr>
               	sxtw	x0, w23
               	mov	x17, #0xf               // =15
               	and	x24, x0, x17
               	sxtw	x0, w24
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w22
               	add	x0, x21, x0
               	sxtw	x1, w24
               	add	x1, x1, #0x30
               	sxtw	x1, w1
               	strb	w1, [x0]
               	b	<addr>
               	sxtw	x0, w23
               	asr	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x23, x0, x17
               	sxtw	x0, w22
               	sub	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	sxtw	x0, w22
               	add	x0, x21, x0
               	sxtw	x1, w24
               	add	x1, x1, #0x61
               	sxtw	x1, w1
               	sub	x1, x1, #0xa
               	sxtw	x1, w1
               	strb	w1, [x0]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	mov	x21, x1
               	sxtw	x20, w20
               	cmp	x21, #0x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x103
               	mov	x21, #0x6               // =6
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w22
               	add	x0, x21, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	sxtw	x2, w22
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, x0
               	mov	x0, x2
               	mov	x21, x1
               	sxtw	x20, w20
               	stur	x0, [x29, #0x30]
               	mov	x22, #0x0               // =0
               	mov	x23, x22
               	b	<addr>
               	sxtw	x0, w22
               	add	x0, x21, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w22
               	add	x0, x21, x0
               	ldrb	w0, [x0]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	mov	x17, #0x25              // =37
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w23
               	add	x0, x0, #0x1
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	sxtw	x0, w22
               	add	x0, x21, x0
               	ldrb	w24, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x23, w23
               	add	x0, x29, #0x30
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldrsw	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x23, x0
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	mov	x17, #0x75              // =117
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x23, w23
               	add	x0, x29, #0x30
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldrsw	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x23, x0
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x23, w23
               	add	x0, x29, #0x30
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldrsw	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x23, x0
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	mov	x17, #0x70              // =112
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x23, w23
               	add	x0, x29, #0x30
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldrsw	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x23, x0
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	add	x0, x29, #0x30
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldrsw	x0, [x0]
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w23
               	add	x0, x0, #0x1
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	mov	x17, #0x73              // =115
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x23, w23
               	add	x0, x29, #0x30
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldr	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x23, x0
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x25               // =37
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w23
               	add	x0, x0, #0x1
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x25               // =37
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x25, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x24, x17
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x0, x20
               	mov	x2, x25
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w23
               	add	x0, x0, #0x2
               	sxtw	x23, w0
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x2, #0x1                // =1
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x10
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #-0x8]
               	bl	<addr>
               	sub	x1, x29, #0x8
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, #0x118
               	adrp	x1, <page>
               	add	x1, x1, #0x149
               	mov	x2, #0x2a               // =42
               	mov	x3, #0x41               // =65
               	mov	x4, #0xff               // =255
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x50
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x14f
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x152
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x156
               	mov	x1, #0x0                // =0
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x20
               	sxtw	x0, w0
               	cmp	x0, #0x13
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
