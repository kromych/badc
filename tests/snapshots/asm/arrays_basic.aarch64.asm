
arrays_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x1, w1
               	mov	x3, #0x0                // =0
               	mov	x2, x3
               	b	<addr>
               	sxtw	x4, w3
               	cmp	x4, x1
               	b.ge	<addr>
               	sxtw	x2, w2
               	sxtw	x3, w3
               	ldrsw	x4, [x0, x3, lsl #2]
               	add	x2, x2, x4
               	sxtw	x2, w2
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	b	<addr>
               	sxtw	x0, w2
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.ge	<addr>
               	sub	x0, x29, #0x18
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	sxtw	x3, w3
               	str	w3, [x0, x2, lsl #2]
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	sxtw	x2, w1
               	mov	x17, #0xa               // =10
               	mul	x3, x2, x17
               	sxtw	x3, w3
               	str	w3, [x0, x2, lsl #2]
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x1, [x0]
               	add	x2, x0, #0x4
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x0, #0x8
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x0, #0xc
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x68               // =104
               	strb	w2, [x0]
               	add	x2, x0, #0x1
               	mov	x3, #0x69               // =105
               	strb	w3, [x2]
               	add	x2, x0, #0x2
               	strb	w1, [x2]
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	add	x0, x0, #0x1
               	ldrb	w0, [x0]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	add	x0, x0, #0x2
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ge	<addr>
               	sub	x0, x29, #0x40
               	sxtw	x2, w1
               	lsl	x3, x2, #3
               	add	x0, x0, x3
               	str	w2, [x0]
               	sub	x0, x29, #0x40
               	sxtw	x2, w1
               	lsl	x3, x2, #3
               	add	x0, x0, x3
               	add	x0, x0, #0x4
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	str	w2, [x0]
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x14
               	ldrsw	x0, [x0]
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	add	x0, x0, #0x20
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	sub	x0, x29, #0x68
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	sxtw	x3, w3
               	str	w3, [x0, x2, lsl #2]
               	sub	x0, x29, #0x68
               	add	x0, x0, #0x20
               	sub	x2, x29, #0x68
               	add	x2, x2, #0x20
               	ldrsw	x2, [x2]
               	sub	x3, x29, #0x68
               	sxtw	x4, w1
               	ldrsw	x3, [x3, x4, lsl #2]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	str	w2, [x0]
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	sub	x0, x29, #0x68
               	add	x0, x0, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x24
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	sub	x0, x29, #0x70
               	sxtw	x2, w1
               	add	x0, x0, x2
               	add	x2, x2, #0x41
               	sxtw	x2, w2
               	strb	w2, [x0]
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldrb	w0, [x0]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x7
               	ldrb	w0, [x0]
               	mov	x17, #0x48              // =72
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	ldrsw	x1, [x0]
               	add	x2, x0, #0x4
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
