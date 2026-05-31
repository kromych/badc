
unsigned_char_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400408 <.text+0x148>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400888 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x15, x19
               	ldrb	w14, [x15]
               	mov	x17, #0x1               // =1
               	eor	x15, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	cmp	x14, #0x0
               	b.eq	0x4004a4 <.text+0x1e4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x15, x19
               	ldrb	w21, [x15]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400894 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x21, x19
               	add	x0, x21, #0x5
               	ldrb	w21, [x0]
               	mov	x17, #0x6               // =6
               	eor	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	cmp	x21, #0x0
               	b.eq	0x400528 <.text+0x268>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x19b
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	add	x20, x0, #0x5
               	ldrb	w21, [x20]
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400894 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x21, x19
               	add	x0, x21, #0x9
               	ldrb	w21, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	cmp	x21, #0x0
               	b.eq	0x4005ac <.text+0x2ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ae
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	add	x22, x0, #0x9
               	ldrb	w21, [x22]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400894 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	ldr	x0, [x21]
               	cmp	x0, #0x64
               	b.eq	0x400614 <.text+0x354>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c1
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	ldr	x23, [x21]
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400894 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x23, x19
               	add	x0, x23, #0x20
               	ldr	x23, [x0]
               	cmp	x23, #0x1f4
               	b.eq	0x400684 <.text+0x3c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d4
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	add	x22, x0, #0x20
               	ldr	x23, [x22]
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x400894 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x5               // =5
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	mov	x17, #0xff              // =255
               	and	x21, x23, x17
               	add	x12, x0, x21
               	ldrb	w21, [x12]
               	mov	x17, #0x6               // =6
               	eor	x12, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x12, x17
               	cmp	x21, #0x0
               	b.eq	0x40071c <.text+0x45c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e7
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x12, x19
               	mov	x17, #0xff              // =255
               	and	x0, x23, x17
               	add	x23, x12, x0
               	ldrb	w21, [x23]
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400894 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
