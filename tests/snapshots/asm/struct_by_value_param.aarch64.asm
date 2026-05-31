
struct_by_value_param.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400340 <.text+0x120>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x15, x29, #0x8
               	ldur	x14, [x29, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	sub	x13, x29, #0x8
               	add	x15, x13, #0x4
               	ldrsw	x13, [x15]
               	add	x15, x14, x13
               	sxtw	x15, w15
               	sub	x13, x29, #0x8
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	w14, [x13]
               	sub	x12, x29, #0x8
               	add	x13, x12, #0x4
               	str	w14, [x13]
               	sub	x12, x29, #0x8
               	ldrsw	x13, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x13, x17
               	b.eq	0x4002e4 <.text+0xc4>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	sub	x12, x29, #0x8
               	add	x0, x12, #0x4
               	ldrsw	x12, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x12, x17
               	b.eq	0x40032c <.text+0x10c>
               	mov	x12, #0xfffe            // =65534
               	movk	x12, #0xffff, lsl #16
               	movk	x12, #0xffff, lsl #32
               	movk	x12, #0xffff, lsl #48
               	mov	x0, x12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	sxtw	x0, w15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	sub	x15, x29, #0x8
               	mov	x14, #0x3               // =3
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x14, x13, #0x4
               	mov	x13, #0x7               // =7
               	str	w13, [x14]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	sxtw	x20, w0
               	cmp	x20, #0xa
               	b.eq	0x40039c <.text+0x17c>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x20, [x0]
               	cmp	x20, #0x3
               	b.eq	0x4003c4 <.text+0x1a4>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x20, x0, #0x4
               	ldrsw	x0, [x20]
               	cmp	x0, #0x7
               	b.eq	0x4003ec <.text+0x1cc>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
