
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400478 <.text+0x1f8>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4008b8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x14, x14, #2
               	add	x15, x15, x14
               	ldrh	w14, [x15]
               	add	x15, x15, #0x2
               	ldrh	w13, [x15]
               	add	x14, x14, x13
               	sxtw	x0, w14
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x17, #0xc               // =12
               	mul	x14, x14, x17
               	add	x15, x15, x14
               	ldrsw	x14, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x12, [x13]
               	add	x14, x14, x12
               	sxtw	x14, w14
               	add	x15, x15, #0x8
               	ldrsw	x12, [x15]
               	add	x14, x14, x12
               	sxtw	x0, w14
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x14, x14, #2
               	add	x15, x15, x14
               	ldrb	w14, [x15]
               	add	x13, x15, #0x1
               	ldrb	w12, [x13]
               	add	x14, x14, x12
               	sxtw	x14, w14
               	add	x12, x15, #0x2
               	ldrb	w13, [x12]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x3
               	ldrb	w13, [x15]
               	add	x14, x14, x13
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4e0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w15, [x17]
               	b	0x4004a0 <.text+0x220>
               	sub	x16, x29, #0x408
               	ldrsw	x15, [x16]
               	cmp	x15, #0x100
               	b.ge	0x400504 <.text+0x284>
               	b	0x4004c8 <.text+0x248>
               	sub	x14, x29, #0x408
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x4004a0 <.text+0x220>
               	sub	x15, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x13, [x16]
               	lsl	x13, x13, #2
               	add	x15, x15, x13
               	mov	x13, #0x0               // =0
               	strh	w13, [x15]
               	sub	x14, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x15, [x16]
               	lsl	x15, x15, #2
               	add	x14, x14, x15
               	add	x14, x14, #0x2
               	strh	w13, [x14]
               	b	0x4004b4 <.text+0x234>
               	sub	x14, x29, #0x400
               	add	x14, x14, #0x14
               	mov	x15, #0x1234            // =4660
               	strh	w15, [x14]
               	sub	x13, x29, #0x400
               	add	x13, x13, #0x16
               	mov	x15, #0x10              // =16
               	strh	w15, [x13]
               	sub	x20, x29, #0x400
               	mov	x21, #0x5               // =5
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4003cc <.text+0x14c>
               	mov	x21, #0x1244            // =4676
               	sxtw	x21, w21
               	cmp	x0, x21
               	b.eq	0x400568 <.text+0x2e8>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x408
               	str	w0, [x17]
               	b	0x400578 <.text+0x2f8>
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	cmp	x0, #0xa
               	b.ge	0x4005b0 <.text+0x330>
               	b	0x4005a0 <.text+0x320>
               	sub	x21, x29, #0x408
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x1
               	str	w0, [x21]
               	b	0x400578 <.text+0x2f8>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x488
               	str	w0, [x17]
               	b	0x4005d0 <.text+0x350>
               	sub	x22, x29, #0x480
               	mov	x21, #0x7               // =7
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x4003f4 <.text+0x174>
               	cmp	x0, #0x837
               	b.eq	0x400660 <.text+0x3e0>
               	b	0x400640 <.text+0x3c0>
               	sub	x16, x29, #0x488
               	ldrsw	x0, [x16]
               	cmp	x0, #0x3
               	b.ge	0x40063c <.text+0x3bc>
               	b	0x4005f8 <.text+0x378>
               	sub	x20, x29, #0x488
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	b	0x4005d0 <.text+0x350>
               	sub	x0, x29, #0x480
               	sub	x16, x29, #0x408
               	ldrsw	x21, [x16]
               	mov	x17, #0xc               // =12
               	mul	x20, x21, x17
               	add	x0, x0, x20
               	sub	x16, x29, #0x488
               	ldrsw	x20, [x16]
               	lsl	x12, x20, #2
               	add	x0, x0, x12
               	mov	x17, #0x64              // =100
               	mul	x21, x21, x17
               	sxtw	x21, w21
               	add	x21, x21, x20
               	sxtw	x21, w21
               	str	w21, [x0]
               	b	0x4005e4 <.text+0x364>
               	b	0x40058c <.text+0x30c>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x408
               	str	w0, [x17]
               	b	0x400670 <.text+0x3f0>
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	cmp	x0, #0x8
               	b.ge	0x4006a8 <.text+0x428>
               	b	0x400698 <.text+0x418>
               	sub	x21, x29, #0x408
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x1
               	str	w0, [x21]
               	b	0x400670 <.text+0x3f0>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x488
               	str	w0, [x17]
               	b	0x4006c8 <.text+0x448>
               	sub	x20, x29, #0x4a8
               	mov	x21, #0x3               // =3
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400430 <.text+0x1b0>
               	cmp	x0, #0x116
               	b.eq	0x400754 <.text+0x4d4>
               	b	0x400734 <.text+0x4b4>
               	sub	x16, x29, #0x488
               	ldrsw	x0, [x16]
               	cmp	x0, #0x4
               	b.ge	0x400730 <.text+0x4b0>
               	b	0x4006f0 <.text+0x470>
               	sub	x22, x29, #0x488
               	ldrsw	x0, [x22]
               	add	x0, x0, #0x1
               	str	w0, [x22]
               	b	0x4006c8 <.text+0x448>
               	sub	x0, x29, #0x4a8
               	sub	x16, x29, #0x408
               	ldrsw	x21, [x16]
               	lsl	x22, x21, #2
               	add	x0, x0, x22
               	sub	x16, x29, #0x488
               	ldrsw	x22, [x16]
               	add	x0, x0, x22
               	add	x21, x21, #0x41
               	sxtw	x21, w21
               	add	x21, x21, x22
               	sxtw	x21, w21
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	strb	w21, [x0]
               	b	0x4006dc <.text+0x45c>
               	b	0x400684 <.text+0x404>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
