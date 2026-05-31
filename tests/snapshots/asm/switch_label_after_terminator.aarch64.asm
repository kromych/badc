
switch_label_after_terminator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002dc <.text+0xbc>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	b	0x4002a8 <.text+0x88>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x1               // =1
               	stur	w14, [x29, #-0x8]
               	b	0x4002c4 <.text+0xa4>
               	mov	x14, #0x2               // =2
               	stur	w14, [x29, #-0x8]
               	b	0x4002c4 <.text+0xa4>
               	mov	x14, #0x3               // =3
               	stur	w14, [x29, #-0x8]
               	b	0x4002c4 <.text+0xa4>
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	mov	x0, x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x15, #0x1
               	b.eq	0x400264 <.text+0x44>
               	cmp	x15, #0x2
               	b.eq	0x400270 <.text+0x50>
               	cmp	x15, #0x3
               	b.eq	0x40027c <.text+0x5c>
               	b	0x400288 <.text+0x68>
               	ldursw	x14, [x29, #-0x8]
               	add	x13, x14, #0x64
               	sxtw	x0, w13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x65
               	b.eq	0x40031c <.text+0xfc>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x66
               	b.eq	0x400348 <.text+0x128>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x67
               	b.eq	0x400374 <.text+0x154>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x63              // =99
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x0, #0x4                // =4
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
