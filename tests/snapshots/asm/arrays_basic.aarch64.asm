
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
               	add	x11, x15, x11
               	ldrsw	x11, [x11]
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
               	sub	sp, sp, #0x90
               	str	x19, [sp]
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
               	sub	x0, x29, #0x18
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0xf
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	cbz	x14, <addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x20]
               	b	<addr>
               	ldursw	x14, [x29, #-0x20]
               	cmp	x14, #0x5
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x1, x19
               	ldursw	x14, [x29, #-0x20]
               	lsl	x0, x14, #2
               	add	x1, x1, x0
               	mov	x17, #0xa               // =10
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	str	w14, [x1]
               	ldursw	x0, [x29, #-0x20]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	ldrsw	x14, [x0]
               	add	x1, x0, #0x4
               	ldrsw	x1, [x1]
               	add	x14, x14, x1
               	sxtw	x14, w14
               	add	x1, x0, #0x8
               	ldrsw	x1, [x1]
               	add	x14, x14, x1
               	sxtw	x14, w14
               	add	x1, x0, #0xc
               	ldrsw	x1, [x1]
               	add	x14, x14, x1
               	sxtw	x14, w14
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	add	x14, x14, x0
               	sxtw	x14, w14
               	cmp	x14, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	cbz	x14, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	cbz	x14, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x14, x19
               	mov	x0, #0x0                // =0
               	mov	x1, #0x68               // =104
               	strb	w1, [x14]
               	add	x12, x14, #0x1
               	mov	x1, #0x69               // =105
               	strb	w1, [x12]
               	add	x11, x14, #0x2
               	strb	w0, [x11]
               	ldrb	w14, [x14]
               	mov	x17, #0x68              // =104
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x14, x19
               	add	x14, x14, #0x1
               	ldrb	w14, [x14]
               	mov	x17, #0x69              // =105
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x1, #0x7                // =7
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x14, x19
               	add	x14, x14, #0x2
               	ldrb	w14, [x14]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x1, #0x8                // =8
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x20]
               	b	<addr>
               	ldursw	x14, [x29, #-0x20]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	sub	x1, x29, #0x40
               	ldursw	x14, [x29, #-0x20]
               	lsl	x11, x14, #3
               	add	x1, x1, x11
               	str	w14, [x1]
               	sub	x11, x29, #0x40
               	ldursw	x1, [x29, #-0x20]
               	lsl	x14, x1, #3
               	add	x11, x11, x14
               	add	x11, x11, #0x4
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	str	w1, [x11]
               	ldursw	x14, [x29, #-0x20]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x20]
               	b	<addr>
               	sub	x14, x29, #0x40
               	ldrsw	x14, [x14]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x1, #0x9                // =9
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x40
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	cmp	x14, #0x1
               	b.eq	<addr>
               	mov	x1, #0xa                // =10
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x40
               	add	x14, x14, #0x14
               	ldrsw	x14, [x14]
               	cmp	x14, #0xc8
               	b.eq	<addr>
               	mov	x1, #0xb                // =11
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	cbz	x14, <addr>
               	mov	x1, #0xc                // =12
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x68
               	add	x14, x14, #0x20
               	mov	x1, #0x0                // =0
               	str	w1, [x14]
               	stur	w1, [x29, #-0x20]
               	b	<addr>
               	ldursw	x1, [x29, #-0x20]
               	cmp	x1, #0x8
               	b.ge	<addr>
               	sub	x11, x29, #0x68
               	ldursw	x1, [x29, #-0x20]
               	lsl	x14, x1, #2
               	add	x11, x11, x14
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	str	w1, [x11]
               	sub	x14, x29, #0x68
               	add	x14, x14, #0x20
               	sub	x1, x29, #0x68
               	add	x1, x1, #0x20
               	ldrsw	x1, [x1]
               	sub	x11, x29, #0x68
               	ldursw	x0, [x29, #-0x20]
               	lsl	x0, x0, #2
               	add	x11, x11, x0
               	ldrsw	x11, [x11]
               	add	x1, x1, x11
               	sxtw	x1, w1
               	str	w1, [x14]
               	ldursw	x11, [x29, #-0x20]
               	add	x11, x11, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x20]
               	b	<addr>
               	sub	x11, x29, #0x68
               	add	x11, x11, #0x20
               	ldrsw	x11, [x11]
               	cmp	x11, #0x24
               	b.eq	<addr>
               	mov	x1, #0xd                // =13
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x20]
               	b	<addr>
               	ldursw	x11, [x29, #-0x20]
               	cmp	x11, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x70
               	ldursw	x11, [x29, #-0x20]
               	add	x1, x1, x11
               	add	x11, x11, #0x41
               	sxtw	x11, w11
               	strb	w11, [x1]
               	ldursw	x14, [x29, #-0x20]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x20]
               	b	<addr>
               	sub	x14, x29, #0x70
               	ldrb	w14, [x14]
               	mov	x17, #0x41              // =65
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x11, #0xe               // =14
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x7
               	ldrb	w14, [x14]
               	mov	x17, #0x48              // =72
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x11, #0xf               // =15
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x8
               	ldrsw	x11, [x14]
               	add	x1, x14, #0x4
               	ldrsw	x1, [x1]
               	add	x11, x11, x1
               	sxtw	x11, w11
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	add	x11, x11, x14
               	sxtw	x11, w11
               	sxtw	x11, w11
               	cmp	x11, #0xc
               	b.eq	<addr>
               	mov	x14, #0x10              // =16
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
