
setjmp_spill_slots_unshared.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	str	w3, [x0, x2, lsl #2]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x20, w2
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	sxtw	x21, w1
               	ldrsw	x1, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x2
               	sxtw	x22, w1
               	ldrsw	x1, [x0, #0xc]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x3
               	sxtw	x23, w1
               	ldrsw	x1, [x0, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x4
               	sxtw	x24, w1
               	ldrsw	x1, [x0, #0x14]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x5
               	sxtw	x25, w1
               	ldrsw	x1, [x0, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x6
               	sxtw	x26, w1
               	ldrsw	x0, [x0, #0x1c]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x7
               	sxtw	x27, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x2, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x20, x0
               	b.eq	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x40]
               	mov	x17, #0x5               // =5
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	ldrsw	x2, [x0, #0x44]
               	mov	x17, #0x5               // =5
               	mul	x2, x2, x17
               	add	x2, x2, #0x2
               	ldrsw	x3, [x0, #0x48]
               	mov	x17, #0x5               // =5
               	mul	x3, x3, x17
               	add	x3, x3, #0x3
               	ldrsw	x4, [x0, #0x4c]
               	mov	x17, #0x5               // =5
               	mul	x4, x4, x17
               	add	x4, x4, #0x4
               	ldrsw	x5, [x0, #0x50]
               	mov	x17, #0x5               // =5
               	mul	x5, x5, x17
               	add	x5, x5, #0x5
               	ldrsw	x6, [x0, #0x54]
               	mov	x17, #0x5               // =5
               	mul	x6, x6, x17
               	add	x6, x6, #0x6
               	ldrsw	x7, [x0, #0x58]
               	mov	x17, #0x5               // =5
               	mul	x7, x7, x17
               	add	x7, x7, #0x7
               	ldrsw	x8, [x0, #0x5c]
               	mov	x17, #0x5               // =5
               	mul	x8, x8, x17
               	add	x8, x8, #0x8
               	ldrsw	x9, [x0, #0x60]
               	mov	x17, #0x5               // =5
               	mul	x9, x9, x17
               	add	x9, x9, #0x9
               	ldrsw	x10, [x0, #0x64]
               	mov	x17, #0x5               // =5
               	mul	x10, x10, x17
               	add	x10, x10, #0xa
               	ldrsw	x11, [x0, #0x68]
               	mov	x17, #0x5               // =5
               	mul	x11, x11, x17
               	add	x11, x11, #0xb
               	ldrsw	x12, [x0, #0x6c]
               	mov	x17, #0x5               // =5
               	mul	x12, x12, x17
               	add	x12, x12, #0xc
               	ldrsw	x13, [x0, #0x70]
               	mov	x17, #0x5               // =5
               	mul	x13, x13, x17
               	add	x13, x13, #0xd
               	ldrsw	x14, [x0, #0x74]
               	mov	x17, #0x5               // =5
               	mul	x14, x14, x17
               	add	x14, x14, #0xe
               	ldrsw	x15, [x0, #0x78]
               	mov	x17, #0x5               // =5
               	mul	x15, x15, x17
               	add	x15, x15, #0xf
               	ldrsw	x20, [x0, #0x7c]
               	mov	x17, #0x5               // =5
               	mul	x20, x20, x17
               	add	x20, x20, #0x10
               	ldrsw	x21, [x0, #0x80]
               	mov	x17, #0x5               // =5
               	mul	x21, x21, x17
               	add	x21, x21, #0x11
               	ldrsw	x22, [x0, #0x84]
               	mov	x17, #0x5               // =5
               	mul	x22, x22, x17
               	add	x22, x22, #0x12
               	ldrsw	x23, [x0, #0x88]
               	mov	x17, #0x5               // =5
               	mul	x23, x23, x17
               	add	x23, x23, #0x13
               	ldrsw	x0, [x0, #0x8c]
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, #0x14
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, x4
               	add	x1, x1, x5
               	add	x1, x1, x6
               	add	x1, x1, x7
               	add	x1, x1, x8
               	add	x1, x1, x9
               	add	x1, x1, x10
               	add	x1, x1, x11
               	add	x1, x1, x12
               	add	x1, x1, x13
               	add	x1, x1, x14
               	add	x1, x1, x15
               	add	x1, x1, x20
               	add	x1, x1, x21
               	add	x1, x1, x22
               	add	x1, x1, x23
               	add	x0, x1, x0
               	str	w0, [x24]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x2, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x21, x0
               	b.eq	<addr>
               	mov	x17, #0x2               // =2
               	orr	x2, x2, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	cmp	x22, x0
               	b.eq	<addr>
               	mov	x17, #0x4               // =4
               	orr	x2, x2, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.eq	<addr>
               	mov	x17, #0x8               // =8
               	orr	x2, x2, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	cmp	x24, x0
               	b.eq	<addr>
               	mov	x17, #0x10              // =16
               	orr	x2, x2, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x14]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x5
               	sxtw	x0, w0
               	cmp	x25, x0
               	b.eq	<addr>
               	mov	x17, #0x20              // =32
               	orr	x2, x2, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x6
               	sxtw	x0, w0
               	cmp	x26, x0
               	b.eq	<addr>
               	mov	x17, #0x40              // =64
               	orr	x2, x2, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x7
               	sxtw	x0, w0
               	cmp	x27, x0
               	b.eq	<addr>
               	mov	x17, #0x80              // =128
               	orr	x2, x2, x17
               	sxtw	x0, w2
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
