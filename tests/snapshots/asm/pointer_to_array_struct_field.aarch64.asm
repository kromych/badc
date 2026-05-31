
pointer_to_array_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400488 <.text+0x148>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x100]
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
               	add	x19, x19, #0x110
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x4003cc <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	add	x19, x19, #0x128
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x135
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400878 <dlsym>
               	cbz	x0, 0x400454 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400454 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x20, x29, #0x8
               	mov	x14, #0x40              // =64
               	sxtw	x21, w14
               	mov	x0, x21
               	bl	0x400884 <malloc>
               	str	x0, [x20]
               	sub	x21, x29, #0x8
               	ldr	x0, [x21]
               	cmp	x0, #0x0
               	b.ne	0x4004ec <.text+0x1ac>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x10]
               	b	0x4004f8 <.text+0x1b8>
               	ldursw	x21, [x29, #-0x10]
               	cmp	x21, #0x4
               	b.ge	0x400528 <.text+0x1e8>
               	b	0x40051c <.text+0x1dc>
               	sub	x21, x29, #0x10
               	ldrsw	x0, [x21]
               	add	x20, x0, #0x1
               	str	w20, [x21]
               	b	0x4004f8 <.text+0x1b8>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x18]
               	b	0x400534 <.text+0x1f4>
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x10]
               	b	0x40059c <.text+0x25c>
               	ldursw	x20, [x29, #-0x18]
               	cmp	x20, #0x8
               	b.ge	0x400598 <.text+0x258>
               	b	0x400558 <.text+0x218>
               	sub	x20, x29, #0x18
               	ldrsw	x0, [x20]
               	add	x21, x0, #0x1
               	str	w21, [x20]
               	b	0x400534 <.text+0x1f4>
               	sub	x21, x29, #0x8
               	ldr	x0, [x21]
               	ldursw	x21, [x29, #-0x10]
               	lsl	x20, x21, #4
               	add	x12, x0, x20
               	ldursw	x20, [x29, #-0x18]
               	lsl	x0, x20, #1
               	add	x11, x12, x0
               	mov	x17, #0x64              // =100
               	mul	x0, x21, x17
               	sxtw	x0, w0
               	add	x21, x0, x20
               	sxtw	x21, w21
               	sxth	x21, w21
               	strh	w21, [x11]
               	b	0x400544 <.text+0x204>
               	b	0x400508 <.text+0x1c8>
               	ldursw	x21, [x29, #-0x10]
               	cmp	x21, #0x4
               	b.ge	0x4005cc <.text+0x28c>
               	b	0x4005c0 <.text+0x280>
               	sub	x21, x29, #0x10
               	ldrsw	x0, [x21]
               	add	x11, x0, #0x1
               	str	w11, [x21]
               	b	0x40059c <.text+0x25c>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x18]
               	b	0x400610 <.text+0x2d0>
               	sub	x12, x29, #0x8
               	ldr	x0, [x12]
               	mov	x12, #0xffff            // =65535
               	movk	x12, #0xffff, lsl #16
               	movk	x12, #0xffff, lsl #32
               	movk	x12, #0xffff, lsl #48
               	strh	w12, [x0]
               	sub	x21, x29, #0x8
               	ldr	x12, [x21]
               	ldrsh	x21, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	b.eq	0x4006e4 <.text+0x3a4>
               	b	0x4006c0 <.text+0x380>
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0x8
               	b.ge	0x40067c <.text+0x33c>
               	b	0x400634 <.text+0x2f4>
               	sub	x11, x29, #0x18
               	ldrsw	x0, [x11]
               	add	x21, x0, #0x1
               	str	w21, [x11]
               	b	0x400610 <.text+0x2d0>
               	sub	x21, x29, #0x8
               	ldr	x0, [x21]
               	ldursw	x21, [x29, #-0x10]
               	lsl	x11, x21, #4
               	add	x20, x0, x11
               	ldursw	x11, [x29, #-0x18]
               	lsl	x0, x11, #1
               	add	x12, x20, x0
               	ldrsh	x0, [x12]
               	mov	x17, #0x64              // =100
               	mul	x12, x21, x17
               	sxtw	x12, w12
               	add	x21, x12, x11
               	sxtw	x21, w21
               	sxth	x21, w21
               	cmp	x0, x21
               	b.eq	0x4006bc <.text+0x37c>
               	b	0x400680 <.text+0x340>
               	b	0x4005ac <.text+0x26c>
               	ldursw	x21, [x29, #-0x10]
               	lsl	x12, x21, #3
               	sxtw	x12, w12
               	add	x21, x12, #0xa
               	sxtw	x21, w21
               	ldursw	x12, [x29, #-0x18]
               	add	x0, x21, x12
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400620 <.text+0x2e0>
               	mov	x21, #0x63              // =99
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	ldr	x22, [x12]
               	mov	x0, x22
               	bl	0x400890 <free>
               	sxtw	x0, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x40089c <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
