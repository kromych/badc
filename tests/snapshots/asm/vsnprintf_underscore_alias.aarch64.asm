
vsnprintf_underscore_alias.aarch64:	file format elf64-littleaarch64

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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x110
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x116
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x11d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	sub	sp, sp, #0x10
               	sxtw	x1, w1
               	sxtw	x3, w3
               	cmp	x1, #0x0
               	cset	x5, gt
               	cbz	x5, <addr>
               	ldrsw	x4, [x2]
               	add	x4, x4, #0x1
               	sxtw	x4, w4
               	cmp	x4, x1
               	cset	x5, lt
               	b	<addr>
               	cbz	x5, <addr>
               	ldrsw	x1, [x2]
               	add	x0, x0, x1
               	mov	x17, #0xff              // =255
               	and	x1, x3, x17
               	strb	w1, [x0]
               	b	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	str	w0, [x2]
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2a0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	mov	x20, x0
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	sxtw	x21, w21
               	mov	x24, #0x0               // =0
               	stur	w24, [x29, #-0x8]
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
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
               	cmp	x21, #0x0
               	b.le	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x3, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	mov	x25, #0x0               // =0
               	mov	x26, x25
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x27, eq
               	cbnz	x27, <addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x30              // =48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x27, eq
               	b	<addr>
               	cbnz	x27, <addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x2b              // =43
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x27, eq
               	b	<addr>
               	cbnz	x27, <addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x20              // =32
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x27, eq
               	b	<addr>
               	cbnz	x27, <addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x27, eq
               	b	<addr>
               	cbz	x27, <addr>
               	b	<addr>
               	mov	x26, #0x1               // =1
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x30              // =48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x25, #0x1               // =1
               	b	<addr>
               	b	<addr>
               	mov	x17, x23
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x27, [x0]
               	cmp	x27, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xc8]
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x2e              // =46
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x26, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x27, x27, x17
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x28, ge
               	cbz	x28, <addr>
               	b	<addr>
               	sxtw	x0, w27
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	sxtw	x1, w24
               	add	x2, x22, x1
               	ldrb	w2, [x2]
               	sub	x2, x2, #0x30
               	sxtw	x2, w2
               	add	x0, x0, x2
               	sxtw	x27, w0
               	add	x0, x1, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x39
               	cset	x28, le
               	b	<addr>
               	cbz	x28, <addr>
               	b	<addr>
               	mov	x28, #0x1               // =1
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, x23
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x17, [x0]
               	str	x17, [sp, #0xc0]
               	ldr	x16, [sp, #0xc0]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x17, [sp, #0xc8]
               	str	x17, [sp, #0xc0]
               	b	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xc8]
               	ldr	x17, [sp, #0xc8]
               	str	x17, [sp, #0xc0]
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x16, ge
               	str	x16, [sp, #0xb8]
               	ldr	x16, [sp, #0xb8]
               	cbz	x16, <addr>
               	b	<addr>
               	ldr	x16, [sp, #0xc0]
               	sxtw	x0, w16
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	sxtw	x1, w24
               	add	x2, x22, x1
               	ldrb	w2, [x2]
               	sub	x2, x2, #0x30
               	sxtw	x2, w2
               	add	x0, x0, x2
               	sxtw	x16, w0
               	str	x16, [sp, #0xc0]
               	add	x0, x1, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	str	x28, [sp, #0xc8]
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x39
               	cset	x16, le
               	str	x16, [sp, #0xb8]
               	b	<addr>
               	ldr	x16, [sp, #0xb8]
               	cbz	x16, <addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x28, eq
               	cbnz	x28, <addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w28, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x28, eq
               	b	<addr>
               	cbnz	x28, <addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x28, eq
               	b	<addr>
               	cbnz	x28, <addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x6a              // =106
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x28, eq
               	b	<addr>
               	cbnz	x28, <addr>
               	sxtw	x0, w24
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x74              // =116
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x28, eq
               	b	<addr>
               	cbz	x28, <addr>
               	b	<addr>
               	mov	x17, x23
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x17, [x0]
               	str	x17, [sp, #0xb0]
               	mov	x28, #0x0               // =0
               	ldr	x16, [sp, #0xb0]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x75              // =117
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x16, eq
               	str	x16, [sp, #0x88]
               	ldr	x16, [sp, #0x88]
               	cbnz	x16, <addr>
               	b	<addr>
               	mov	x28, #0x1               // =1
               	ldr	x16, [sp, #0xb0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x16, x16, x17
               	str	x16, [sp, #0xb0]
               	b	<addr>
               	sub	x0, x29, #0x90
               	mov	x16, #0x1f              // =31
               	str	x16, [sp, #0xa8]
               	ldr	x16, [sp, #0xb0]
               	sxtw	x2, w16
               	mov	x3, #0xa                // =10
               	ldr	x1, [sp, #0xa8]
               	bl	<addr>
               	str	x0, [sp, #0x90]
               	ldr	x16, [sp, #0x90]
               	sxtw	x0, w16
               	ldr	x16, [sp, #0xa8]
               	sub	x0, x16, x0
               	sxtw	x16, w0
               	str	x16, [sp, #0xa0]
               	sxtw	x0, w28
               	cbz	x0, <addr>
               	ldr	x16, [sp, #0xa0]
               	sxtw	x0, w16
               	add	x0, x0, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0xa0]
               	b	<addr>
               	ldr	x16, [sp, #0xc8]
               	sxtw	x0, w16
               	cbz	x0, <addr>
               	ldr	x16, [sp, #0xc0]
               	sxtw	x1, w16
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x98]
               	ldr	x16, [sp, #0xa0]
               	sxtw	x0, w16
               	sxtw	x2, w28
               	cbz	x2, <addr>
               	mov	x3, #0x1                // =1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sub	x0, x0, x3
               	sxtw	x0, w0
               	sxtw	x2, w1
               	cmp	x0, x2
               	b.ge	<addr>
               	sxtw	x0, w1
               	ldr	x16, [sp, #0xa0]
               	sxtw	x1, w16
               	sxtw	x2, w28
               	cbz	x2, <addr>
               	b	<addr>
               	sxtw	x0, w27
               	ldr	x16, [sp, #0xa0]
               	sxtw	x1, w16
               	cmp	x0, x1
               	b.le	<addr>
               	b	<addr>
               	mov	x3, #0x1                // =1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sub	x1, x1, x3
               	sxtw	x1, w1
               	sub	x0, x0, x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x98]
               	ldr	x16, [sp, #0xa0]
               	sxtw	x0, w16
               	ldr	x16, [sp, #0x98]
               	sxtw	x1, w16
               	add	x0, x0, x1
               	sxtw	x16, w0
               	str	x16, [sp, #0xa0]
               	b	<addr>
               	sxtw	x0, w27
               	ldr	x16, [sp, #0xa0]
               	sxtw	x1, w16
               	sub	x0, x0, x1
               	sxtw	x27, w0
               	b	<addr>
               	mov	x27, #0x0               // =0
               	b	<addr>
               	sxtw	x25, w25
               	cbz	x25, <addr>
               	ldr	x16, [sp, #0xc8]
               	sxtw	x0, w16
               	cmp	x0, #0x0
               	cset	x25, eq
               	b	<addr>
               	cbz	x25, <addr>
               	sxtw	x0, w26
               	cmp	x0, #0x0
               	cset	x25, eq
               	b	<addr>
               	cbz	x25, <addr>
               	mov	x25, #0x30              // =48
               	b	<addr>
               	mov	x25, #0x20              // =32
               	b	<addr>
               	sxtw	x0, w26
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w28
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x3, x25, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x2d               // =45
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x16, [sp, #0x98]
               	sxtw	x0, w16
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x30               // =48
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldr	x16, [sp, #0x98]
               	sxtw	x0, w16
               	sub	x0, x0, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x98]
               	b	<addr>
               	b	<addr>
               	ldr	x16, [sp, #0x90]
               	sxtw	x0, w16
               	cmp	x0, #0x1f
               	b.ge	<addr>
               	sub	x2, x29, #0x8
               	sub	x0, x29, #0x90
               	ldr	x16, [sp, #0x90]
               	sxtw	x1, w16
               	add	x0, x0, x1
               	ldrb	w3, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldr	x16, [sp, #0x90]
               	sxtw	x0, w16
               	add	x0, x0, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x90]
               	b	<addr>
               	sxtw	x0, w26
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x16, eq
               	str	x16, [sp, #0x88]
               	b	<addr>
               	ldr	x16, [sp, #0x88]
               	cbnz	x16, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x16, eq
               	str	x16, [sp, #0x88]
               	b	<addr>
               	ldr	x16, [sp, #0x88]
               	cbz	x16, <addr>
               	mov	x17, x23
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x90
               	mov	x1, #0x1f               // =31
               	mov	x17, #0xff              // =255
               	and	x3, x28, x17
               	mov	x17, #0x75              // =117
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x70              // =112
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x4, #0xa                // =10
               	b	<addr>
               	mov	x4, #0x10               // =16
               	b	<addr>
               	mov	x3, x4
               	bl	<addr>
               	str	x0, [sp, #0x78]
               	mov	x0, #0x1f               // =31
               	ldr	x16, [sp, #0x78]
               	sxtw	x1, w16
               	sub	x0, x0, x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x80]
               	ldr	x16, [sp, #0xc8]
               	sxtw	x0, w16
               	cbz	x0, <addr>
               	ldr	x16, [sp, #0xc0]
               	sxtw	x1, w16
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x28, #0x0               // =0
               	ldr	x16, [sp, #0x80]
               	sxtw	x0, w16
               	sxtw	x2, w1
               	cmp	x0, x2
               	b.ge	<addr>
               	sxtw	x0, w1
               	ldr	x16, [sp, #0x80]
               	sxtw	x1, w16
               	sub	x0, x0, x1
               	sxtw	x28, w0
               	sxtw	x0, w28
               	add	x0, x1, x0
               	sxtw	x16, w0
               	str	x16, [sp, #0x80]
               	b	<addr>
               	sxtw	x0, w27
               	ldr	x16, [sp, #0x80]
               	sxtw	x1, w16
               	cmp	x0, x1
               	b.le	<addr>
               	sxtw	x0, w27
               	ldr	x16, [sp, #0x80]
               	sxtw	x1, w16
               	sub	x0, x0, x1
               	sxtw	x27, w0
               	b	<addr>
               	mov	x27, #0x0               // =0
               	b	<addr>
               	sxtw	x25, w25
               	cbz	x25, <addr>
               	ldr	x16, [sp, #0xc8]
               	sxtw	x0, w16
               	cmp	x0, #0x0
               	cset	x25, eq
               	b	<addr>
               	cbz	x25, <addr>
               	sxtw	x0, w26
               	cmp	x0, #0x0
               	cset	x25, eq
               	b	<addr>
               	cbz	x25, <addr>
               	mov	x25, #0x30              // =48
               	b	<addr>
               	mov	x25, #0x20              // =32
               	b	<addr>
               	sxtw	x0, w26
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x3, x25, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w28
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x30               // =48
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w28
               	sub	x0, x0, #0x1
               	sxtw	x28, w0
               	b	<addr>
               	b	<addr>
               	ldr	x16, [sp, #0x78]
               	sxtw	x0, w16
               	cmp	x0, #0x1f
               	b.ge	<addr>
               	sub	x2, x29, #0x8
               	sub	x0, x29, #0x90
               	ldr	x16, [sp, #0x78]
               	sxtw	x1, w16
               	add	x0, x0, x1
               	ldrb	w3, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldr	x16, [sp, #0x78]
               	sxtw	x0, w16
               	add	x0, x0, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x78]
               	b	<addr>
               	sxtw	x0, w26
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, x23
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x25, [x0]
               	sub	x2, x29, #0x8
               	mov	x3, #0x30               // =48
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x78               // =120
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x26, #0xf               // =15
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w26
               	cmp	x0, #0x0
               	b.lt	<addr>
               	sxtw	x0, w26
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	asr	x0, x25, x0
               	mov	x17, #0xf               // =15
               	and	x27, x0, x17
               	sxtw	x0, w27
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sub	x2, x29, #0x8
               	sxtw	x0, w27
               	add	x0, x0, #0x30
               	sxtw	x3, w0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	sxtw	x0, w26
               	sub	x0, x0, #0x1
               	sxtw	x26, w0
               	b	<addr>
               	sub	x2, x29, #0x8
               	sxtw	x0, w27
               	add	x0, x0, #0x61
               	sxtw	x0, w0
               	sub	x0, x0, #0xa
               	sxtw	x3, w0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	mov	x17, x23
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x25, [x0]
               	sxtw	x0, w27
               	cmp	x0, #0x1
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x73              // =115
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	mov	x27, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w26
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x0, x20
               	mov	x3, x25
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w26
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, x23
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	x25, [x0]
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x25, <page>
               	add	x25, x25, #0x141
               	b	<addr>
               	mov	x28, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w28
               	add	x0, x25, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w28
               	add	x0, x0, #0x1
               	sxtw	x28, w0
               	b	<addr>
               	ldr	x16, [sp, #0xc8]
               	sxtw	x16, w16
               	str	x16, [sp, #0x70]
               	ldr	x16, [sp, #0x70]
               	cbz	x16, <addr>
               	ldr	x16, [sp, #0xc0]
               	sxtw	x0, w16
               	sxtw	x1, w28
               	cmp	x0, x1
               	cset	x16, lt
               	str	x16, [sp, #0x70]
               	b	<addr>
               	ldr	x16, [sp, #0x70]
               	cbz	x16, <addr>
               	ldr	x16, [sp, #0xc0]
               	sxtw	x28, w16
               	b	<addr>
               	sxtw	x0, w27
               	sxtw	x1, w28
               	cmp	x0, x1
               	b.le	<addr>
               	sxtw	x0, w27
               	sxtw	x1, w28
               	sub	x0, x0, x1
               	sxtw	x27, w0
               	b	<addr>
               	mov	x27, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w26
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x68]
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	ldr	x16, [sp, #0x68]
               	sxtw	x0, w16
               	sxtw	x1, w28
               	cmp	x0, x1
               	b.ge	<addr>
               	sub	x2, x29, #0x8
               	ldr	x16, [sp, #0x68]
               	sxtw	x0, w16
               	add	x0, x25, x0
               	ldrb	w3, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldr	x16, [sp, #0x68]
               	sxtw	x0, w16
               	add	x0, x0, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x68]
               	b	<addr>
               	sxtw	x0, w26
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w27
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w27
               	sub	x0, x0, #0x1
               	sxtw	x27, w0
               	b	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x25               // =37
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x28, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x25               // =37
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sub	x2, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x3, x28, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, x21
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	ldr	x19, [sp, #0x50]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x20, x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x21, #0x1
               	sxtw	x0, w0
               	add	x0, x20, x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x17, [sp, #0xc8]
               	str	x17, [sp, #0xc0]
               	b	<addr>
               	b	<addr>
               	str	x28, [sp, #0xc8]
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
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x20
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	ldur	x0, [x29, #0x10]
               	ldursw	x1, [x29, #0x18]
               	ldur	x2, [x29, #0x20]
               	sub	x3, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, #0x148
               	adrp	x3, <page>
               	add	x3, x3, #0x14e
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
