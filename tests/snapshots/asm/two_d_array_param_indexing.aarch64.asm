
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400474 <.text+0x1f4>
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
               	bl	0x4008b8 <dlsym>
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
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x13, x14, #2
               	add	x14, x15, x13
               	ldrh	w13, [x14]
               	add	x15, x14, #0x2
               	ldrh	w14, [x15]
               	add	x15, x13, x14
               	sxtw	x0, w15
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x17, #0xc               // =12
               	mul	x13, x14, x17
               	add	x14, x15, x13
               	ldrsw	x13, [x14]
               	add	x15, x14, #0x4
               	ldrsw	x12, [x15]
               	add	x15, x13, x12
               	sxtw	x15, w15
               	add	x12, x14, #0x8
               	ldrsw	x14, [x12]
               	add	x12, x15, x14
               	sxtw	x0, w12
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x13, x14, #2
               	add	x14, x15, x13
               	ldrb	w13, [x14]
               	add	x15, x14, #0x1
               	ldrb	w12, [x15]
               	add	x15, x13, x12
               	sxtw	x15, w15
               	add	x12, x14, #0x2
               	ldrb	w13, [x12]
               	add	x12, x15, x13
               	sxtw	x12, w12
               	add	x13, x14, #0x3
               	ldrb	w14, [x13]
               	add	x13, x12, x14
               	sxtw	x0, w13
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4e0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w15, [x17]
               	b	0x4004a0 <.text+0x220>
               	sub	x16, x29, #0x408
               	ldrsw	x15, [x16]
               	cmp	x15, #0x100
               	b.ge	0x400504 <.text+0x284>
               	b	0x4004c8 <.text+0x248>
               	sub	x15, x29, #0x408
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x4004a0 <.text+0x220>
               	sub	x13, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x14, [x16]
               	lsl	x15, x14, #2
               	add	x14, x13, x15
               	mov	x15, #0x0               // =0
               	strh	w15, [x14]
               	sub	x13, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x14, [x16]
               	lsl	x12, x14, #2
               	add	x14, x13, x12
               	add	x12, x14, #0x2
               	strh	w15, [x12]
               	b	0x4004b4 <.text+0x234>
               	sub	x12, x29, #0x400
               	add	x14, x12, #0x14
               	mov	x12, #0x1234            // =4660
               	strh	w12, [x14]
               	sub	x15, x29, #0x400
               	add	x12, x15, #0x16
               	mov	x15, #0x10              // =16
               	strh	w15, [x12]
               	sub	x20, x29, #0x400
               	mov	x21, #0x5               // =5
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4003c8 <.text+0x148>
               	mov	x21, #0x1244            // =4676
               	sxtw	x21, w21
               	cmp	x0, x21
               	b.eq	0x40056c <.text+0x2ec>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w20, [x17]
               	b	0x40057c <.text+0x2fc>
               	sub	x16, x29, #0x408
               	ldrsw	x20, [x16]
               	cmp	x20, #0xa
               	b.ge	0x4005b4 <.text+0x334>
               	b	0x4005a4 <.text+0x324>
               	sub	x20, x29, #0x408
               	ldrsw	x21, [x20]
               	add	x0, x21, #0x1
               	str	w0, [x20]
               	b	0x40057c <.text+0x2fc>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x488
               	str	w0, [x17]
               	b	0x4005d4 <.text+0x354>
               	sub	x22, x29, #0x480
               	mov	x21, #0x7               // =7
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x4003f0 <.text+0x170>
               	cmp	x0, #0x837
               	b.eq	0x400664 <.text+0x3e4>
               	b	0x400644 <.text+0x3c4>
               	sub	x16, x29, #0x488
               	ldrsw	x0, [x16]
               	cmp	x0, #0x3
               	b.ge	0x400640 <.text+0x3c0>
               	b	0x4005fc <.text+0x37c>
               	sub	x0, x29, #0x488
               	ldrsw	x21, [x0]
               	add	x20, x21, #0x1
               	str	w20, [x0]
               	b	0x4005d4 <.text+0x354>
               	sub	x20, x29, #0x480
               	sub	x16, x29, #0x408
               	ldrsw	x21, [x16]
               	mov	x17, #0xc               // =12
               	mul	x0, x21, x17
               	add	x13, x20, x0
               	sub	x16, x29, #0x488
               	ldrsw	x0, [x16]
               	lsl	x20, x0, #2
               	add	x11, x13, x20
               	mov	x17, #0x64              // =100
               	mul	x20, x21, x17
               	sxtw	x20, w20
               	add	x21, x20, x0
               	sxtw	x21, w21
               	str	w21, [x11]
               	b	0x4005e8 <.text+0x368>
               	b	0x400590 <.text+0x310>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w21, [x17]
               	b	0x400674 <.text+0x3f4>
               	sub	x16, x29, #0x408
               	ldrsw	x21, [x16]
               	cmp	x21, #0x8
               	b.ge	0x4006ac <.text+0x42c>
               	b	0x40069c <.text+0x41c>
               	sub	x21, x29, #0x408
               	ldrsw	x0, [x21]
               	add	x22, x0, #0x1
               	str	w22, [x21]
               	b	0x400674 <.text+0x3f4>
               	mov	x22, #0x0               // =0
               	sub	x17, x29, #0x488
               	str	w22, [x17]
               	b	0x4006cc <.text+0x44c>
               	sub	x20, x29, #0x4a8
               	mov	x23, #0x3               // =3
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x40042c <.text+0x1ac>
               	cmp	x0, #0x116
               	b.eq	0x400758 <.text+0x4d8>
               	b	0x400738 <.text+0x4b8>
               	sub	x16, x29, #0x488
               	ldrsw	x22, [x16]
               	cmp	x22, #0x4
               	b.ge	0x400734 <.text+0x4b4>
               	b	0x4006f4 <.text+0x474>
               	sub	x22, x29, #0x488
               	ldrsw	x0, [x22]
               	add	x21, x0, #0x1
               	str	w21, [x22]
               	b	0x4006cc <.text+0x44c>
               	sub	x21, x29, #0x4a8
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	lsl	x22, x0, #2
               	add	x11, x21, x22
               	sub	x16, x29, #0x488
               	ldrsw	x22, [x16]
               	add	x21, x11, x22
               	add	x11, x0, #0x41
               	sxtw	x11, w11
               	add	x0, x11, x22
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x11, x0, x17
               	strb	w11, [x21]
               	b	0x4006e0 <.text+0x460>
               	b	0x400688 <.text+0x408>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
