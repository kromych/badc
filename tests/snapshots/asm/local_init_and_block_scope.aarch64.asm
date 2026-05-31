
local_init_and_block_scope.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x13, w2
               	add	x15, x15, x14
               	sxtw	x15, w15
               	add	x15, x15, x13
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x19, [sp]
               	mov	x15, #0x0               // =0
               	mov	x14, #0x41              // =65
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x13, x19
               	mov	x12, #0x1               // =1
               	stur	w12, [x29, #-0x20]
               	mov	x11, #0x3               // =3
               	mov	x12, #0x2               // =2
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	mov	x17, #0x41              // =65
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w14, [x13]
               	mov	x17, #0x68              // =104
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x13, x13, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x69              // =105
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x13, [x29, #-0x20]
               	sxtw	x0, w12
               	add	x13, x13, x0
               	sxtw	x13, w13
               	sxtw	x0, w11
               	add	x13, x13, x0
               	sxtw	x13, w13
               	cmp	x13, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x13, [x29, #-0x20]
               	sxtw	x12, w12
               	sxtw	x11, w11
               	add	x13, x13, x12
               	sxtw	x13, w13
               	add	x13, x13, x11
               	sxtw	x13, w13
               	sxtw	x11, w13
               	cmp	x11, #0x6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x11, w13
               	lsl	x11, x11, #1
               	sxtw	x11, w11
               	sxtw	x11, w11
               	cmp	x11, #0xc
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0xa               // =10
               	mov	x0, #0x14               // =20
               	mov	x12, #0x1e              // =30
               	add	x11, x11, x0
               	sxtw	x11, w11
               	add	x11, x11, x12
               	sxtw	x11, w11
               	sxtw	x11, w11
               	cmp	x11, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x63              // =99
               	sxtw	x11, w11
               	cmp	x11, #0x63
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x7               // =7
               	sxtw	x11, w11
               	cmp	x11, #0x7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x13, w13
               	cmp	x13, #0x6
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	ldrsw	x13, [x13]
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x60
               	mov	x0, #0x0                // =0
               	str	w0, [x13]
               	sub	x11, x29, #0x60
               	add	x11, x11, #0x4
               	str	w0, [x11]
               	sub	x13, x29, #0x60
               	sub	x11, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x13]
               	str	x10, [x11]
               	ldr	x10, [sp], #0x10
               	mov	x0, x11
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x11, #0xd               // =13
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x11, #0xe               // =14
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
