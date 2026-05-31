
fd_set_macros.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40040c <.text+0x14c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
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
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400c28 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	b	0x400424 <.text+0x164>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0x88]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x90]
               	b	0x40044c <.text+0x18c>
               	mov	x13, #0x0               // =0
               	cbnz	x13, 0x400424 <.text+0x164>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x98]
               	b	0x400484 <.text+0x1c4>
               	ldursw	x14, [x29, #-0x90]
               	cmp	x14, #0x80
               	b.ge	0x400480 <.text+0x1c0>
               	ldur	x15, [x29, #-0x88]
               	ldursw	x14, [x29, #-0x90]
               	add	x15, x15, x14
               	mov	x14, #0x0               // =0
               	strb	w14, [x15]
               	ldursw	x13, [x29, #-0x90]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x90]
               	b	0x40044c <.text+0x18c>
               	b	0x400438 <.text+0x178>
               	ldursw	x14, [x29, #-0x98]
               	cmp	x14, #0x80
               	b.ge	0x4004b8 <.text+0x1f8>
               	sub	x13, x29, #0x80
               	ldursw	x14, [x29, #-0x98]
               	add	x13, x13, x14
               	ldrb	w14, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	0x4004d8 <.text+0x218>
               	b	0x4004bc <.text+0x1fc>
               	b	0x4004ec <.text+0x22c>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x14, [x29, #-0x98]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x98]
               	b	0x400484 <.text+0x1c4>
               	sub	x14, x29, #0x80
               	stur	x14, [x29, #-0xa0]
               	ldur	x13, [x29, #-0xa0]
               	mov	x14, #0x0               // =0
               	mov	x15, #0x8               // =8
               	sdiv	x14, x14, x15
               	add	x13, x13, x14
               	ldrb	w14, [x13]
               	mov	x17, #0x1               // =1
               	orr	x14, x14, x17
               	strb	w14, [x13]
               	b	0x40051c <.text+0x25c>
               	mov	x14, #0x0               // =0
               	cbnz	x14, 0x4004ec <.text+0x22c>
               	b	0x400528 <.text+0x268>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0xa8]
               	ldur	x14, [x29, #-0xa8]
               	mov	x15, #0x7               // =7
               	mov	x13, #0x8               // =8
               	sdiv	x15, x15, x13
               	add	x14, x14, x15
               	ldrb	w15, [x14]
               	mov	x13, #0x1               // =1
               	lsl	x13, x13, #7
               	orr	x15, x15, x13
               	strb	w15, [x14]
               	b	0x40055c <.text+0x29c>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x400528 <.text+0x268>
               	b	0x400568 <.text+0x2a8>
               	sub	x13, x29, #0x80
               	stur	x13, [x29, #-0xb0]
               	ldur	x15, [x29, #-0xb0]
               	mov	x13, #0x8               // =8
               	sdiv	x13, x13, x13
               	add	x15, x15, x13
               	ldrb	w13, [x15]
               	mov	x17, #0x1               // =1
               	orr	x13, x13, x17
               	strb	w13, [x15]
               	b	0x400594 <.text+0x2d4>
               	mov	x13, #0x0               // =0
               	cbnz	x13, 0x400568 <.text+0x2a8>
               	b	0x4005a0 <.text+0x2e0>
               	sub	x14, x29, #0x80
               	stur	x14, [x29, #-0xb8]
               	ldur	x13, [x29, #-0xb8]
               	mov	x14, #0x64              // =100
               	mov	x15, #0x8               // =8
               	sdiv	x14, x14, x15
               	add	x13, x13, x14
               	ldrb	w14, [x13]
               	mov	x15, #0x1               // =1
               	lsl	x15, x15, #4
               	orr	x14, x14, x15
               	strb	w14, [x13]
               	b	0x4005d4 <.text+0x314>
               	mov	x14, #0x0               // =0
               	cbnz	x14, 0x4005a0 <.text+0x2e0>
               	sub	x15, x29, #0x80
               	mov	x14, #0x0               // =0
               	mov	x13, #0x8               // =8
               	sdiv	x14, x14, x13
               	add	x15, x15, x14
               	ldrb	w14, [x15]
               	mov	x17, #0x1               // =1
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.ne	0x400620 <.text+0x360>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	mov	x15, #0x7               // =7
               	mov	x13, #0x8               // =8
               	sdiv	x15, x15, x13
               	add	x14, x14, x15
               	ldrb	w15, [x14]
               	mov	x14, #0x1               // =1
               	lsl	x14, x14, #7
               	and	x15, x15, x14
               	cmp	x15, #0x0
               	b.ne	0x400668 <.text+0x3a8>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x14, #0x8               // =8
               	sdiv	x14, x14, x14
               	add	x15, x15, x14
               	ldrb	w14, [x15]
               	mov	x17, #0x1               // =1
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.ne	0x4006a8 <.text+0x3e8>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	mov	x15, #0x64              // =100
               	mov	x13, #0x8               // =8
               	sdiv	x15, x15, x13
               	add	x14, x14, x15
               	ldrb	w15, [x14]
               	mov	x14, #0x1               // =1
               	lsl	x14, x14, #4
               	and	x15, x15, x14
               	cmp	x15, #0x0
               	b.ne	0x4006f0 <.text+0x430>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x14, #0x1               // =1
               	mov	x13, #0x8               // =8
               	sdiv	x12, x14, x13
               	add	x15, x15, x12
               	ldrb	w12, [x15]
               	lsl	x14, x14, #1
               	and	x12, x12, x14
               	cbz	x12, 0x400730 <.text+0x470>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x80
               	mov	x14, #0x32              // =50
               	mov	x15, #0x8               // =8
               	sdiv	x14, x14, x15
               	add	x12, x12, x14
               	ldrb	w14, [x12]
               	mov	x12, #0x1               // =1
               	lsl	x12, x12, #2
               	and	x14, x14, x12
               	cbz	x14, 0x400774 <.text+0x4b4>
               	mov	x12, #0x7               // =7
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	ldrb	w12, [x14]
               	mov	x17, #0x81              // =129
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	0x4007b4 <.text+0x4f4>
               	mov	x15, #0xb               // =11
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x12, x14, #0x1
               	ldrb	w15, [x12]
               	mov	x17, #0x1               // =1
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	0x4007f4 <.text+0x534>
               	mov	x12, #0xc               // =12
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x14, #0xc
               	ldrb	w15, [x14]
               	mov	x17, #0x10              // =16
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	0x400834 <.text+0x574>
               	mov	x14, #0xd               // =13
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400838 <.text+0x578>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0xc8]
               	ldur	x14, [x29, #-0xc8]
               	mov	x15, #0x7               // =7
               	mov	x12, #0x8               // =8
               	sdiv	x15, x15, x12
               	add	x14, x14, x15
               	ldrb	w15, [x14]
               	mov	x12, #0x1               // =1
               	lsl	x12, x12, #7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x12, x12, x17
               	and	x15, x15, x12
               	strb	w15, [x14]
               	b	0x400880 <.text+0x5c0>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x400838 <.text+0x578>
               	sub	x12, x29, #0x80
               	mov	x15, #0x7               // =7
               	mov	x14, #0x8               // =8
               	sdiv	x15, x15, x14
               	add	x12, x12, x15
               	ldrb	w15, [x12]
               	mov	x12, #0x1               // =1
               	lsl	x12, x12, #7
               	and	x15, x15, x12
               	cbz	x15, 0x4008cc <.text+0x60c>
               	mov	x12, #0x15              // =21
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x12, #0x0               // =0
               	mov	x14, #0x8               // =8
               	sdiv	x12, x12, x14
               	add	x15, x15, x12
               	ldrb	w12, [x15]
               	mov	x17, #0x1               // =1
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.ne	0x400910 <.text+0x650>
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x80
               	mov	x15, #0x8               // =8
               	sdiv	x15, x15, x15
               	add	x12, x12, x15
               	ldrb	w15, [x12]
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.ne	0x400950 <.text+0x690>
               	mov	x12, #0x17              // =23
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400954 <.text+0x694>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0xd0]
               	ldur	x12, [x29, #-0xd0]
               	mov	x15, #0x0               // =0
               	mov	x14, #0x8               // =8
               	sdiv	x15, x15, x14
               	add	x12, x12, x15
               	ldrb	w15, [x12]
               	mov	x17, #0x1               // =1
               	orr	x15, x15, x17
               	strb	w15, [x12]
               	b	0x400984 <.text+0x6c4>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x400954 <.text+0x694>
               	sub	x14, x29, #0x80
               	mov	x15, #0x0               // =0
               	mov	x12, #0x8               // =8
               	sdiv	x15, x15, x12
               	add	x14, x14, x15
               	ldrb	w15, [x14]
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.ne	0x4009d0 <.text+0x710>
               	mov	x14, #0x18              // =24
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4009d4 <.text+0x714>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0xd8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0xe0]
               	b	0x400a18 <.text+0x758>
               	mov	x12, #0x0               // =0
               	cbnz	x12, 0x4009d4 <.text+0x714>
               	sub	x14, x29, #0x80
               	mov	x12, #0x0               // =0
               	mov	x15, #0x8               // =8
               	sdiv	x12, x12, x15
               	add	x14, x14, x12
               	ldrb	w12, [x14]
               	mov	x17, #0x1               // =1
               	and	x12, x12, x17
               	cbz	x12, 0x400a6c <.text+0x7ac>
               	b	0x400a50 <.text+0x790>
               	ldursw	x14, [x29, #-0xe0]
               	cmp	x14, #0x80
               	b.ge	0x400a4c <.text+0x78c>
               	ldur	x15, [x29, #-0xd8]
               	ldursw	x14, [x29, #-0xe0]
               	add	x15, x15, x14
               	mov	x14, #0x0               // =0
               	strb	w14, [x15]
               	ldursw	x12, [x29, #-0xe0]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0xe0]
               	b	0x400a18 <.text+0x758>
               	b	0x4009e8 <.text+0x728>
               	mov	x14, #0x19              // =25
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x80
               	mov	x14, #0x64              // =100
               	mov	x15, #0x8               // =8
               	sdiv	x14, x14, x15
               	add	x12, x12, x14
               	ldrb	w14, [x12]
               	mov	x12, #0x1               // =1
               	lsl	x12, x12, #4
               	and	x14, x14, x12
               	cbz	x14, 0x400ab0 <.text+0x7f0>
               	mov	x12, #0x1a              // =26
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400c34 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
