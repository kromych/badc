
macro_operators.aarch64:	file format elf64-littleaarch64

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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	add	x15, x15, x14
               	sxtw	x15, w15
               	add	x15, x15, x13
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	ldrb	w14, [x15]
               	mov	x17, #0x68              // =104
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x15, #0x1
               	ldrb	w14, [x14]
               	mov	x17, #0x65              // =101
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x15, #0x2
               	ldrb	w14, [x14]
               	mov	x17, #0x6c              // =108
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x15, #0x3
               	ldrb	w14, [x14]
               	mov	x17, #0x6c              // =108
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x15, #0x4
               	ldrb	w14, [x14]
               	mov	x17, #0x6f              // =111
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x15, x15, #0x5
               	ldrb	w15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x2a              // =42
               	cmp	x15, #0x2a
               	b.eq	<addr>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x1               // =1
               	mov	x14, #0x2               // =2
               	mov	x13, #0x3               // =3
               	add	x15, x15, x14
               	sxtw	x15, w15
               	add	x15, x15, x13
               	sxtw	x15, w15
               	sxtw	x15, w15
               	cmp	x15, #0x6
               	b.eq	<addr>
               	mov	x13, #0x8               // =8
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x156
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	mov	x3, #0x9                // =9
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
