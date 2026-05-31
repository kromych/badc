
arrays_basic.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, x14
               	b.ge	<addr>
               	ldursw	x12, [x29, #-0x8]
               	ldursw	x13, [x29, #-0x10]
               	lsl	x11, x13, #2
               	add	x10, x15, x11
               	ldrsw	x11, [x10]
               	add	x12, x12, x11
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x8]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x20]
               	b	<addr>
               	ldursw	x15, [x29, #-0x20]
               	cmp	x15, #0x5
               	b.ge	<addr>
               	sub	x14, x29, #0x18
               	ldursw	x15, [x29, #-0x20]
               	lsl	x13, x15, #2
               	add	x14, x14, x13
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	str	w15, [x14]
               	ldursw	x13, [x29, #-0x20]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x20]
               	b	<addr>
               	sub	x20, x29, #0x18
               	mov	x21, #0x5               // =5
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	x0, #0x5
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x21, x19
               	ldursw	x0, [x29, #-0x20]
               	lsl	x20, x0, #2
               	add	x21, x21, x20
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	str	w0, [x21]
               	ldursw	x20, [x29, #-0x20]
               	add	x20, x20, #0x1
               	sxtw	x20, w20
               	stur	w20, [x29, #-0x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x20, x19
               	ldrsw	x0, [x20]
               	add	x21, x20, #0x4
               	ldrsw	x12, [x21]
               	add	x0, x0, x12
               	sxtw	x0, w0
               	add	x12, x20, #0x8
               	ldrsw	x21, [x12]
               	add	x0, x0, x21
               	sxtw	x0, w0
               	add	x21, x20, #0xc
               	ldrsw	x12, [x21]
               	add	x0, x0, x12
               	sxtw	x0, w0
               	add	x20, x20, #0x10
               	ldrsw	x12, [x20]
               	add	x0, x0, x12
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0x5               // =5
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x0, x19
               	mov	x12, #0x0               // =0
               	mov	x20, #0x68              // =104
               	strb	w20, [x0]
               	add	x21, x0, #0x1
               	mov	x20, #0x69              // =105
               	strb	w20, [x21]
               	add	x11, x0, #0x2
               	strb	w12, [x11]
               	ldrb	w20, [x0]
               	mov	x17, #0x68              // =104
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x20, x19
               	add	x20, x20, #0x1
               	ldrb	w0, [x20]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x0, x19
               	add	x0, x0, #0x2
               	ldrb	w20, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x20]
               	b	<addr>
               	ldursw	x20, [x29, #-0x20]
               	cmp	x20, #0x3
               	b.ge	<addr>
               	sub	x0, x29, #0x40
               	ldursw	x20, [x29, #-0x20]
               	lsl	x11, x20, #3
               	add	x0, x0, x11
               	str	w20, [x0]
               	sub	x11, x29, #0x40
               	ldursw	x0, [x29, #-0x20]
               	lsl	x20, x0, #3
               	add	x11, x11, x20
               	add	x11, x11, #0x4
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	str	w0, [x11]
               	ldursw	x20, [x29, #-0x20]
               	add	x20, x20, #0x1
               	sxtw	x20, w20
               	stur	w20, [x29, #-0x20]
               	b	<addr>
               	sub	x20, x29, #0x40
               	ldrsw	x0, [x20]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x20, #0x9               // =9
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x8
               	ldrsw	x20, [x0]
               	cmp	x20, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x40
               	add	x20, x20, #0x14
               	ldrsw	x0, [x20]
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x20, #0xb               // =11
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x20, #0xc               // =12
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	add	x0, x0, #0x20
               	mov	x20, #0x0               // =0
               	str	w20, [x0]
               	stur	w20, [x29, #-0x20]
               	b	<addr>
               	ldursw	x20, [x29, #-0x20]
               	cmp	x20, #0x8
               	b.ge	<addr>
               	sub	x11, x29, #0x68
               	ldursw	x20, [x29, #-0x20]
               	lsl	x0, x20, #2
               	add	x11, x11, x0
               	add	x20, x20, #0x1
               	sxtw	x20, w20
               	str	w20, [x11]
               	sub	x0, x29, #0x68
               	add	x0, x0, #0x20
               	sub	x20, x29, #0x68
               	add	x20, x20, #0x20
               	ldrsw	x11, [x20]
               	sub	x20, x29, #0x68
               	ldursw	x12, [x29, #-0x20]
               	lsl	x12, x12, #2
               	add	x20, x20, x12
               	ldrsw	x12, [x20]
               	add	x11, x11, x12
               	sxtw	x11, w11
               	str	w11, [x0]
               	ldursw	x12, [x29, #-0x20]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x20]
               	b	<addr>
               	sub	x12, x29, #0x68
               	add	x12, x12, #0x20
               	ldrsw	x11, [x12]
               	cmp	x11, #0x24
               	b.eq	<addr>
               	mov	x12, #0xd               // =13
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x20]
               	b	<addr>
               	ldursw	x11, [x29, #-0x20]
               	cmp	x11, #0x8
               	b.ge	<addr>
               	sub	x12, x29, #0x70
               	ldursw	x11, [x29, #-0x20]
               	add	x12, x12, x11
               	add	x11, x11, #0x41
               	sxtw	x11, w11
               	strb	w11, [x12]
               	ldursw	x0, [x29, #-0x20]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldrb	w11, [x0]
               	mov	x17, #0x41              // =65
               	eor	x11, x11, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x11, x17
               	cmp	x11, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x70
               	add	x11, x11, #0x7
               	ldrb	w0, [x11]
               	mov	x17, #0x48              // =72
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x11, #0xf               // =15
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	ldrsw	x11, [x0]
               	add	x12, x0, #0x4
               	ldrsw	x20, [x12]
               	add	x11, x11, x20
               	sxtw	x11, w11
               	add	x0, x0, #0x8
               	ldrsw	x20, [x0]
               	add	x11, x11, x20
               	sxtw	x11, w11
               	sxtw	x11, w11
               	cmp	x11, #0xc
               	b.eq	<addr>
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
