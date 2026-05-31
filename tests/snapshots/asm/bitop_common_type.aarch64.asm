
bitop_common_type.aarch64:	file format elf64-littleaarch64

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
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x13, x14, x17
               	and	x13, x15, x13
               	add	x13, x13, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x13, x15, x14
               	add	x13, x13, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0xf001            // =61441
               	movk	x13, #0x4006, lsl #16
               	movk	x13, #0x1, lsl #32
               	sub	x13, x13, #0x1
               	mov	x17, #0xf               // =15
               	orr	x13, x13, x17
               	add	x13, x13, #0x1
               	mov	x17, #0xf010            // =61456
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x13, x15, x14
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x13, x15, x14
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x15, x15, x14
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x15, x17
               	cset	x15, hi
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
