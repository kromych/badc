
mem2reg_unsigned_narrow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x15, #0x12c             // =300
               	mov	x14, #0x2345            // =9029
               	movk	x14, #0x1, lsl #16
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x18]
               	stur	w13, [x29, #-0x20]
               	stur	w13, [x29, #-0x28]
               	b	0x400264 <.text+0x44>
               	ldursw	x13, [x29, #-0x18]
               	cmp	x13, #0x3
               	b.ge	0x4002b4 <.text+0x94>
               	ldursw	x12, [x29, #-0x20]
               	mov	x17, #0xff              // =255
               	and	x13, x15, x17
               	add	x12, x12, x13
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x20]
               	ldursw	x13, [x29, #-0x28]
               	mov	x17, #0xffff            // =65535
               	and	x12, x14, x17
               	add	x13, x13, x12
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x28]
               	ldursw	x12, [x29, #-0x18]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x18]
               	b	0x400264 <.text+0x44>
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x30]
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	mov	x17, #0x2c              // =44
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	0x4002f4 <.text+0xd4>
               	ldursw	x13, [x29, #-0x30]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x30]
               	b	0x4002f4 <.text+0xd4>
               	mov	x17, #0xffff            // =65535
               	and	x14, x14, x17
               	mov	x17, #0x2345            // =9029
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	0x40032c <.text+0x10c>
               	ldursw	x15, [x29, #-0x30]
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x30]
               	b	0x40032c <.text+0x10c>
               	ldursw	x15, [x29, #-0x20]
               	mov	x14, #0x84              // =132
               	sxtw	x14, w14
               	cmp	x15, x14
               	b.eq	0x400354 <.text+0x134>
               	ldursw	x14, [x29, #-0x30]
               	add	x14, x14, #0x4
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x30]
               	b	0x400354 <.text+0x134>
               	ldursw	x14, [x29, #-0x28]
               	mov	x15, #0x69cf            // =27087
               	sxtw	x15, w15
               	cmp	x14, x15
               	b.eq	0x40037c <.text+0x15c>
               	ldursw	x15, [x29, #-0x30]
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x30]
               	b	0x40037c <.text+0x15c>
               	ldursw	x0, [x29, #-0x30]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
