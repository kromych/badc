
extern_in_function.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x68>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x40026c <.text+0x4c>
               	mov	x14, x0
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x15, x17
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0xfffb            // =65531
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x5
               	b.eq	0x4002dc <.text+0xbc>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x7               // =7
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x400320 <.text+0x100>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	0x40026c <.text+0x4c>
               	mov	x14, x0
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x400364 <.text+0x144>
               	mov	x14, #0xd               // =13
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x20, x0
               	mov	x0, x21
               	bl	0x40026c <.text+0x4c>
               	mov	x13, x0
               	cmp	x20, x13
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x13, #0xe               // =14
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
