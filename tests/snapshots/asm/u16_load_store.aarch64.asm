
u16_load_store.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	sub	x15, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x156
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldrb	w10, [x14, #0x8]
               	strb	w10, [x15, #0x8]
               	ldrb	w10, [x14, #0x9]
               	strb	w10, [x15, #0x9]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	mov	x12, x0
               	sub	x12, x29, #0x20
               	add	x12, x12, #0x2
               	mov	x2, #0x4241             // =16961
               	strh	w2, [x12]
               	sub	x1, x29, #0x20
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	stur	x1, [x29, #-0x40]
               	cbnz	x1, <addr>
               	sub	x2, x29, #0x20
               	add	x2, x2, #0x1
               	ldrb	w2, [x2]
               	cmp	x2, #0x0
               	cset	x2, ne
               	stur	x2, [x29, #-0x40]
               	b	<addr>
               	ldur	x2, [x29, #-0x40]
               	cbz	x2, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x20
               	add	x2, x2, #0x2
               	ldrb	w2, [x2]
               	mov	x17, #0x41              // =65
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, ne
               	stur	x2, [x29, #-0x48]
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, #0x3
               	ldrb	w1, [x1]
               	mov	x17, #0x42              // =66
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	ldur	x1, [x29, #-0x48]
               	cbz	x1, <addr>
               	mov	x2, #0x2                // =2
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	add	x1, x1, #0x4
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x2, #0x3                // =3
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x1
               	ldrh	w1, [x1]
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	mov	x17, #0x4342            // =17218
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x2, #0x4                // =4
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
