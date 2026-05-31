
size_t_is_unsigned.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0x0               // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x14, x15, x17
               	mov	x15, #0x9               // =9
               	udiv	x13, x14, x15
               	cmp	x13, #0x0
               	b.ne	0x40027c <.text+0x5c>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x9               // =9
               	udiv	x0, x14, x15
               	mov	x17, #0x1c71            // =7281
               	movk	x17, #0x71c7, lsl #16
               	movk	x17, #0xc71c, lsl #32
               	movk	x17, #0x1c71, lsl #48
               	cmp	x0, x17
               	b.eq	0x4002ac <.text+0x8c>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x14, #0x3e8
               	b.hs	0x4002c4 <.text+0xa4>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x80000000        // =2147483648
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	mov	x15, #0x5               // =5
               	sxtw	x15, w15
               	udiv	x12, x14, x15
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x15, x12
               	b.hs	0x400308 <.text+0xe8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	stur	x15, [x29, #-0x28]
               	b	0x40031c <.text+0xfc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x12, x17
               	stur	x15, [x29, #-0x28]
               	b	0x40031c <.text+0xfc>
               	ldur	x15, [x29, #-0x28]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x12, x15
               	b.eq	0x400354 <.text+0x134>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
