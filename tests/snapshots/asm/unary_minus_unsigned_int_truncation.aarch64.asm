
unary_minus_unsigned_int_truncation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x13, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x14, x17
               	b.eq	0x400280 <.text+0x60>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	orr	x0, x13, x12
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	b.eq	0x4002c8 <.text+0xa8>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	orr	x0, x12, x13
               	lsr	x13, x0, #31
               	cmp	x13, #0x1
               	b.eq	0x400310 <.text+0xf0>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ret
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	orr	x0, x13, x12
               	lsr	x12, x0, #31
               	cmp	x12, #0x0
               	b.eq	0x40035c <.text+0x13c>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x12, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x13, x17
               	orr	x11, x0, x12
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x11, x17
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	orr	x13, x12, x0
               	lsr	x0, x13, #31
               	cmp	x0, #0x1
               	b.eq	0x4003e0 <.text+0x1c0>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x13, #0x1               // =1
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	eor	x0, x12, x13
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	orr	x0, x13, x12
               	lsr	x12, x0, #31
               	mov	x17, #0x1               // =1
               	eor	x0, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	cmp	x12, #0x0
               	b.eq	0x400460 <.text+0x240>
               	mov	x12, #0x7               // =7
               	mov	x0, x12
               	ret
               	mov	x0, #0x5                // =5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	eor	x0, x12, x13
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	orr	x0, x13, x12
               	lsr	x12, x0, #31
               	mov	x17, #0x1               // =1
               	eor	x0, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	cmp	x12, #0x1
               	b.eq	0x4004dc <.text+0x2bc>
               	mov	x12, #0x8               // =8
               	mov	x0, x12
               	ret
               	mov	x0, #0x0                // =0
               	ret
