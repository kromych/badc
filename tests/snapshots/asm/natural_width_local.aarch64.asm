
natural_width_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x15, #0x12c             // =300
               	mov	x14, #0xc8              // =200
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x20]
               	stur	w13, [x29, #-0x28]
               	b	<addr>
               	ldursw	x13, [x29, #-0x20]
               	cmp	x13, #0x4
               	b.ge	<addr>
               	ldursw	x12, [x29, #-0x28]
               	sxtb	x13, w15
               	add	x12, x12, x13
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x28]
               	ldursw	x13, [x29, #-0x20]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x20]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x30]
               	sxtb	x12, w15
               	cmp	x12, #0x2c
               	b.eq	<addr>
               	ldursw	x13, [x29, #-0x30]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x30]
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	mov	x17, #0x2c              // =44
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	ldursw	x12, [x29, #-0x30]
               	add	x12, x12, #0x2
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x30]
               	b	<addr>
               	sxtb	x14, w14
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	<addr>
               	ldursw	x15, [x29, #-0x30]
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x30]
               	b	<addr>
               	ldursw	x15, [x29, #-0x28]
               	cmp	x15, #0xb0
               	b.eq	<addr>
               	ldursw	x14, [x29, #-0x30]
               	add	x14, x14, #0x8
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x30]
               	b	<addr>
               	ldursw	x0, [x29, #-0x30]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
