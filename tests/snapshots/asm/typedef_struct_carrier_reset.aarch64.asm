
typedef_struct_carrier_reset.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400300 <.text+0xe0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	stur	w14, [x29, #-0x8]
               	b	0x400258 <.text+0x38>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0xa
               	b.ge	0x4002e0 <.text+0xc0>
               	b	0x40027c <.text+0x5c>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	0x400258 <.text+0x38>
               	ldursw	x14, [x29, #-0x8]
               	lsl	x12, x14, #2
               	add	x13, x15, x12
               	str	w14, [x13]
               	add	x12, x15, #0x28
               	ldursw	x13, [x29, #-0x8]
               	lsl	x14, x13, #2
               	add	x12, x12, x14
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	str	w13, [x12]
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	ldursw	x12, [x29, #-0x8]
               	lsl	x12, x12, #2
               	add	x11, x15, x12
               	ldrsw	x10, [x11]
               	add	x11, x15, #0x28
               	add	x11, x11, x12
               	ldrsw	x12, [x11]
               	add	x10, x10, x12
               	sxtw	x10, w10
               	add	x13, x13, x10
               	str	w13, [x14]
               	b	0x400268 <.text+0x48>
               	add	x13, x15, #0xa0
               	ldursw	x10, [x29, #-0x10]
               	str	w10, [x13]
               	add	x15, x15, #0xa0
               	ldrsw	x0, [x15]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	str	x20, [sp]
               	sub	x20, x29, #0xa8
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	0x400340 <.text+0x120>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0x14
               	ldrsw	x20, [x0]
               	cmp	x20, #0x5
               	b.eq	0x400368 <.text+0x148>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0xa8
               	add	x20, x20, #0x3c
               	ldrsw	x0, [x20]
               	cmp	x0, #0x6
               	b.eq	0x400394 <.text+0x174>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0xa0
               	ldrsw	x20, [x0]
               	cmp	x20, #0x64
               	b.eq	0x4003bc <.text+0x19c>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
