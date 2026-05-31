
bitop_common_type.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x15, #0xf000            // =61440
               	movk	x15, #0x4006, lsl #16
               	movk	x15, #0x1, lsl #32
               	mov	x14, #0x0               // =0
               	orr	x13, x15, x14
               	add	x13, x13, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	0x400280 <.text+0x60>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x13, x14, x17
               	and	x0, x15, x13
               	add	x0, x0, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x4002c4 <.text+0xa4>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x15, x14
               	add	x0, x0, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x4002f4 <.text+0xd4>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf001             // =61441
               	movk	x0, #0x4006, lsl #16
               	movk	x0, #0x1, lsl #32
               	sub	x0, x0, #0x1
               	mov	x13, #0xf               // =15
               	sxtw	x13, w13
               	orr	x0, x0, x13
               	add	x0, x0, #0x1
               	mov	x17, #0xf010            // =61456
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x40033c <.text+0x11c>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x0, x15, x14
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x400368 <.text+0x148>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x0, x15, x14
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x400394 <.text+0x174>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x15, x15, x14
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x15, x17
               	cset	x15, hi
               	cmp	x15, #0x0
               	b.ne	0x4003bc <.text+0x19c>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
