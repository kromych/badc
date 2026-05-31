
local_init_and_block_scope.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400258 <.text+0x38>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	add	x12, x15, x14
               	sxtw	x12, w12
               	add	x14, x12, x13
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x0               // =0
               	mov	x14, #0x41              // =65
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x13, x19
               	mov	x12, #0x1               // =1
               	stur	w12, [x29, #-0x20]
               	mov	x11, #0x3               // =3
               	mov	x12, #0x2               // =2
               	sxtw	x10, w15
               	cmp	x10, #0x0
               	b.eq	0x4002d8 <.text+0xb8>
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x15, x14, x17
               	mov	x17, #0x41              // =65
               	eor	x10, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x10, x17
               	cmp	x15, #0x0
               	b.eq	0x400328 <.text+0x108>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w10, [x13]
               	mov	x17, #0x68              // =104
               	eor	x15, x10, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x15, x17
               	cmp	x10, #0x0
               	b.eq	0x400374 <.text+0x154>
               	mov	x10, #0x3               // =3
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x15, x13, #0x1
               	ldrb	w13, [x15]
               	mov	x17, #0x69              // =105
               	eor	x15, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	b.eq	0x4003c4 <.text+0x1a4>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x15, [x29, #-0x20]
               	sxtw	x13, w12
               	add	x10, x15, x13
               	sxtw	x10, w10
               	sxtw	x13, w11
               	add	x15, x10, x13
               	sxtw	x15, w15
               	cmp	x15, #0x6
               	b.eq	0x400414 <.text+0x1f4>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x20, [x29, #-0x20]
               	sxtw	x21, w12
               	sxtw	x22, w11
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x23, x0
               	sxtw	x22, w23
               	cmp	x22, #0x6
               	b.eq	0x40046c <.text+0x24c>
               	mov	x22, #0x6               // =6
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x21, w23
               	lsl	x22, x21, #1
               	sxtw	x22, w22
               	sxtw	x21, w22
               	cmp	x21, #0xc
               	b.eq	0x4004b0 <.text+0x290>
               	mov	x21, #0x7               // =7
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0xa               // =10
               	mov	x22, #0x14              // =20
               	mov	x21, #0x1e              // =30
               	mov	x0, x24
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x400238 <.text+0x18>
               	sxtw	x21, w0
               	cmp	x21, #0x3c
               	b.eq	0x400504 <.text+0x2e4>
               	mov	x21, #0x8               // =8
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x63               // =99
               	sxtw	x21, w0
               	cmp	x21, #0x63
               	b.eq	0x400540 <.text+0x320>
               	mov	x21, #0x9               // =9
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	sxtw	x21, w0
               	cmp	x21, #0x7
               	b.eq	0x40057c <.text+0x35c>
               	mov	x21, #0xa               // =10
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w23
               	cmp	x0, #0x6
               	b.eq	0x4005b0 <.text+0x390>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x20
               	ldrsw	x0, [x21]
               	cmp	x0, #0x1
               	b.eq	0x4005e8 <.text+0x3c8>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x60
               	mov	x0, #0x0                // =0
               	str	w0, [x21]
               	sub	x23, x29, #0x60
               	add	x21, x23, #0x4
               	str	w0, [x21]
               	sub	x23, x29, #0x60
               	sub	x21, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x23]
               	str	x10, [x21]
               	ldr	x10, [sp], #0x10
               	mov	x0, x21
               	sub	x0, x29, #0x68
               	ldrsw	x21, [x0]
               	cmp	x21, #0x0
               	b.eq	0x400658 <.text+0x438>
               	mov	x21, #0xd               // =13
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	add	x21, x0, #0x4
               	ldrsw	x0, [x21]
               	cmp	x0, #0x0
               	b.eq	0x400694 <.text+0x474>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
