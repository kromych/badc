
deferred_outer_2d_array_stride.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003c8 <.text+0x148>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400828 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	mov	x15, #0x30              // =48
               	cmp	x15, #0x30
               	b.eq	0x4003f8 <.text+0x178>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x10              // =16
               	cmp	x14, #0x10
               	b.eq	0x40041c <.text+0x19c>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	cmp	x0, #0x10
               	b.eq	0x40043c <.text+0x1bc>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	add	x0, x14, #0x10
               	sub	x13, x0, x14
               	cmp	x13, #0x10
               	b.eq	0x400470 <.text+0x1f0>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	add	x13, x0, #0x20
               	add	x14, x0, #0x10
               	sub	x0, x13, x14
               	cmp	x0, #0x10
               	b.eq	0x4004a4 <.text+0x224>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	ldr	x0, [x14]
               	ldrb	w14, [x0]
               	mov	x17, #0x41              // =65
               	eor	x0, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x0, x17
               	cmp	x14, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x8]
               	cbnz	x0, 0x400518 <.text+0x298>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	add	x0, x14, #0x8
               	ldr	x14, [x0]
               	ldrb	w0, [x14]
               	mov	x17, #0x42              // =66
               	eor	x14, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x8]
               	b	0x400518 <.text+0x298>
               	ldur	x14, [x29, #-0x8]
               	cbz	x14, 0x400534 <.text+0x2b4>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	add	x0, x14, #0x10
               	ldr	x14, [x0]
               	ldrb	w0, [x14]
               	mov	x17, #0x43              // =67
               	eor	x14, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x10]
               	cbnz	x14, 0x400594 <.text+0x314>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	add	x14, x0, #0x18
               	ldr	x0, [x14]
               	cmp	x0, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x10]
               	b	0x400594 <.text+0x314>
               	ldur	x14, [x29, #-0x10]
               	cbz	x14, 0x4005b0 <.text+0x330>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	add	x0, x14, #0x20
               	ldr	x14, [x0]
               	cmp	x14, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x18]
               	cbnz	x0, 0x400610 <.text+0x390>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	add	x0, x14, #0x28
               	ldr	x14, [x0]
               	ldrb	w0, [x14]
               	mov	x17, #0x44              // =68
               	eor	x14, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x18]
               	b	0x400610 <.text+0x390>
               	ldur	x14, [x29, #-0x18]
               	cbz	x14, 0x40062c <.text+0x3ac>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x30              // =48
               	cmp	x14, #0x30
               	b.eq	0x400650 <.text+0x3d0>
               	mov	x14, #0x9               // =9
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	cmp	x0, #0xc
               	b.eq	0x400670 <.text+0x3f0>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x14, x19
               	add	x0, x14, #0x2c
               	ldrsw	x14, [x0]
               	cmp	x14, #0xc
               	b.eq	0x4006a4 <.text+0x424>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	add	x14, x0, #0x10
               	ldrsw	x0, [x14]
               	cmp	x0, #0x5
               	b.eq	0x4006d4 <.text+0x454>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
