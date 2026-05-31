
symbol_inner_array_size_no_leak.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002c0 <.text+0xa0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	b	0x400258 <.text+0x38>
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, x14
               	b.ge	0x4002a0 <.text+0x80>
               	b	0x40027c <.text+0x5c>
               	sub	x13, x29, #0x8
               	ldrsw	x12, [x13]
               	add	x11, x12, #0x1
               	str	w11, [x13]
               	b	0x400258 <.text+0x38>
               	ldursw	x11, [x29, #-0x8]
               	lsl	x12, x11, #1
               	add	x13, x15, x12
               	mov	x17, #0x3               // =3
               	mul	x12, x11, x17
               	sxtw	x12, w12
               	sxth	x12, w12
               	strh	w12, [x13]
               	b	0x400268 <.text+0x48>
               	sub	x12, x14, #0x1
               	sxtw	x12, w12
               	lsl	x14, x12, #1
               	add	x12, x15, x14
               	ldrsh	x0, [x12]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x20, x29, #0x10
               	mov	x21, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	sxtw	x21, w0
               	cmp	x21, #0x15
               	b.eq	0x400310 <.text+0xf0>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsh	x21, [x0]
               	cmp	x21, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	cbnz	x0, 0x400344 <.text+0x124>
               	sub	x21, x29, #0x10
               	add	x0, x21, #0xe
               	ldrsh	x21, [x0]
               	cmp	x21, #0x15
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	b	0x400344 <.text+0x124>
               	ldur	x0, [x29, #-0x30]
               	cbz	x0, 0x400368 <.text+0x148>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	add	x21, x0, #0xe
               	mov	x0, #0x63               // =99
               	strh	w0, [x21]
               	sub	x20, x29, #0x28
               	add	x0, x20, #0xe
               	ldrsh	x20, [x0]
               	cmp	x20, #0x63
               	b.eq	0x4003a8 <.text+0x188>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
