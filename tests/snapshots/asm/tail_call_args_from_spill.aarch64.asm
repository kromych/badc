
tail_call_args_from_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	sxtw	x12, w3
               	sxtw	x15, w15
               	lsl	x14, x14, #1
               	sxtw	x14, w14
               	add	x15, x15, x14
               	sxtw	x15, w15
               	mov	x17, #0x3               // =3
               	mul	x13, x13, x17
               	sxtw	x13, w13
               	add	x15, x15, x13
               	sxtw	x15, w15
               	lsl	x12, x12, #2
               	sxtw	x12, w12
               	add	x15, x15, x12
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x28, [sp]
               	sxtw	x15, w0
               	sxtw	x14, w15
               	add	x13, x15, #0x1
               	sxtw	x13, w13
               	add	x12, x15, #0x2
               	sxtw	x12, w12
               	add	x11, x15, #0x3
               	sxtw	x11, w11
               	add	x10, x15, #0x4
               	sxtw	x10, w10
               	add	x9, x15, #0x5
               	sxtw	x9, w9
               	add	x8, x15, #0x6
               	sxtw	x8, w8
               	add	x7, x15, #0x7
               	sxtw	x7, w7
               	add	x6, x15, #0x8
               	sxtw	x6, w6
               	add	x5, x15, #0x9
               	sxtw	x5, w5
               	add	x4, x15, #0xa
               	sxtw	x4, w4
               	add	x3, x15, #0xb
               	sxtw	x3, w3
               	add	x2, x15, #0xc
               	sxtw	x2, w2
               	add	x1, x15, #0xd
               	sxtw	x1, w1
               	add	x0, x15, #0xe
               	sxtw	x0, w0
               	add	x15, x15, #0xf
               	sxtw	x15, w15
               	sxtw	x14, w14
               	sxtw	x13, w13
               	add	x14, x14, x13
               	sxtw	x14, w14
               	sxtw	x11, w11
               	add	x14, x14, x11
               	sxtw	x14, w14
               	sxtw	x10, w10
               	add	x14, x14, x10
               	sxtw	x14, w14
               	sxtw	x8, w8
               	add	x14, x14, x8
               	sxtw	x14, w14
               	sxtw	x7, w7
               	add	x14, x14, x7
               	sxtw	x14, w14
               	sxtw	x6, w6
               	add	x14, x14, x6
               	sxtw	x14, w14
               	sxtw	x6, w5
               	add	x14, x14, x6
               	sxtw	x14, w14
               	sxtw	x4, w4
               	add	x14, x14, x4
               	sxtw	x14, w14
               	sxtw	x3, w3
               	add	x14, x14, x3
               	sxtw	x14, w14
               	sxtw	x2, w2
               	add	x14, x14, x2
               	sxtw	x14, w14
               	sxtw	x0, w0
               	add	x14, x14, x0
               	sxtw	x14, w14
               	sxtw	x15, w15
               	add	x14, x14, x15
               	sxtw	x14, w14
               	sxtw	x14, w14
               	cmp	x14, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x28, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x12, w12
               	sxtw	x9, w9
               	sxtw	x5, w5
               	sxtw	x1, w1
               	sxtw	x12, w12
               	lsl	x9, x9, #1
               	sxtw	x9, w9
               	add	x12, x12, x9
               	sxtw	x12, w12
               	mov	x17, #0x3               // =3
               	mul	x5, x5, x17
               	sxtw	x5, w5
               	add	x12, x12, x5
               	sxtw	x12, w12
               	lsl	x1, x1, #2
               	sxtw	x1, w1
               	add	x12, x12, x1
               	sxtw	x0, w12
               	ldr	x28, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x0, x19
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	sxtw	x20, w20
               	cmp	x20, #0xbf
               	b.ne	<addr>
               	mov	x12, #0x0               // =0
               	stur	x12, [x29, #-0x20]
               	b	<addr>
               	mov	x12, #0x1               // =1
               	stur	x12, [x29, #-0x20]
               	b	<addr>
               	ldur	x12, [x29, #-0x20]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
