
c99_qualifiers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x0, x17
               	mov	x0, x1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	x13, [x29, #-0x10]
               	b	<addr>
               	ldur	x13, [x29, #-0x10]
               	cmp	x13, x1
               	b.hs	<addr>
               	ldursw	x12, [x29, #-0x8]
               	ldrsw	x13, [x0]
               	add	x12, x12, x13
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x8]
               	ldur	x13, [x29, #-0x10]
               	add	x13, x13, #0x1
               	stur	x13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	mov	x0, x13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	mov	x15, #0x7               // =7
               	stur	w15, [x29, #-0x28]
               	sub	x0, x29, #0x28
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
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x13, x0
               	cmp	x13, #0x7
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x13, x19
               	ldrb	w13, [x13]
               	mov	x17, #0x62              // =98
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	cbz	x13, <addr>
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	cbz	x13, <addr>
               	mov	x1, #0x5                // =5
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	cbz	x13, <addr>
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd8
               	mov	x13, x19
               	mov	x1, #0x1                // =1
               	str	w1, [x13]
               	ldr	w13, [x13]
               	mov	x17, #0x1               // =1
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
