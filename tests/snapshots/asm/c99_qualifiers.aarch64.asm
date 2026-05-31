
c99_qualifiers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	mov	x14, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	add	x15, x15, x14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	mov	x14, x1
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	x13, [x29, #-0x10]
               	b	<addr>
               	ldur	x13, [x29, #-0x10]
               	cmp	x13, x14
               	b.hs	<addr>
               	ldursw	x12, [x29, #-0x8]
               	ldrsw	x13, [x15]
               	add	x12, x12, x13
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x8]
               	ldur	x13, [x29, #-0x10]
               	add	x13, x13, #0x1
               	stur	x13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x19, [sp]
               	mov	x15, #0x7               // =7
               	stur	w15, [x29, #-0x28]
               	sub	x14, x29, #0x28
               	mov	x15, #0x1               // =1
               	mov	x13, #0x2               // =2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	add	x15, x15, x13
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x1               // =1
               	b	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x12, x19
               	ldrb	w0, [x12]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0x5               // =5
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd8
               	mov	x0, x19
               	mov	x12, #0x1               // =1
               	str	w12, [x0]
               	ldr	w11, [x0]
               	mov	x17, #0x1               // =1
               	eor	x11, x11, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x11, x17
               	cmp	x11, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x58]
               	stur	x0, [x29, #-0x50]
               	b	<addr>
               	ldur	x11, [x29, #-0x50]
               	cmp	x11, x15
               	b.hs	<addr>
               	ldursw	x0, [x29, #-0x58]
               	ldrsw	x11, [x14]
               	add	x0, x0, x11
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x58]
               	ldur	x11, [x29, #-0x50]
               	add	x11, x11, #0x1
               	stur	x11, [x29, #-0x50]
               	b	<addr>
               	ldursw	x0, [x29, #-0x58]
               	b	<addr>
