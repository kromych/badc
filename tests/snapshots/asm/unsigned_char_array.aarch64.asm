
unsigned_char_array.aarch64:	file format elf64-littleaarch64

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
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
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
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0x100
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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	ldrb	w15, [x15]
               	mov	x17, #0x1               // =1
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	ldrb	w1, [x15]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x150
               	add	x1, x1, #0x5
               	ldrb	w1, [x1]
               	mov	x17, #0x6               // =6
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x19b
               	adrp	x1, <page>
               	add	x1, x1, #0x150
               	add	x1, x1, #0x5
               	ldrb	w15, [x1]
               	mov	x1, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, #0x9
               	ldrb	w15, [x15]
               	mov	x17, #0xa               // =10
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1ae
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, #0x9
               	ldrb	w1, [x15]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	ldr	x1, [x1]
               	cmp	x1, #0x64
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1c1
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	ldr	x15, [x1]
               	mov	x1, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x160
               	add	x15, x15, #0x20
               	ldr	x15, [x15]
               	cmp	x15, #0x1f4
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1d4
               	adrp	x15, <page>
               	add	x15, x15, #0x160
               	add	x15, x15, #0x20
               	ldr	x1, [x15]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, x1
               	ldrb	w15, [x15]
               	mov	x17, #0x6               // =6
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1e7
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, x1
               	ldrb	w1, [x15]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
