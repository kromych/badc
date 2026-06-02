
anonymous_aggregates.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
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
               	add	x19, x19, #0xf8
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
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
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x90ab, lsl #16
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x1234, lsl #48
               	str	x0, [x15]
               	sub	x13, x29, #0x8
               	ldr	w13, [x13]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x90ab, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	ldrsw	x13, [x13]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldr	w13, [x13]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x90ab, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	ldrsw	x13, [x13]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	mov	x0, #0xbabe             // =47806
               	movk	x0, #0xcafe, lsl #16
               	str	w0, [x13]
               	sub	x15, x29, #0x8
               	add	x15, x15, #0x4
               	mov	x0, #0xf00d             // =61453
               	movk	x0, #0xbad, lsl #16
               	str	w0, [x15]
               	sub	x13, x29, #0x8
               	ldr	w13, [x13]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	ldrsw	x13, [x13]
               	mov	x17, #0xf00d            // =61453
               	movk	x17, #0xbad, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldr	x13, [x13]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	movk	x17, #0xf00d, lsl #32
               	movk	x17, #0xbad, lsl #48
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	mov	x0, #0x1                // =1
               	str	w0, [x13]
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x8
               	mov	x0, #0x2a               // =42
               	str	w0, [x15]
               	sub	x13, x29, #0x20
               	add	x13, x13, #0x10
               	mov	x0, #0x63               // =99
               	str	w0, [x13]
               	sub	x15, x29, #0x20
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x10
               	ldrsw	x15, [x15]
               	cmp	x15, #0x63
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x8
               	mov	x0, #0x851f             // =34079
               	movk	x0, #0x51eb, lsl #16
               	movk	x0, #0x1eb8, lsl #32
               	movk	x0, #0x4009, lsl #48
               	str	x0, [x15]
               	sub	x13, x29, #0x20
               	ldrsw	x13, [x13]
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	add	x13, x13, #0x10
               	ldrsw	x13, [x13]
               	cmp	x13, #0x63
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	mov	x0, #0xa                // =10
               	str	w0, [x13]
               	sub	x15, x29, #0x30
               	add	x15, x15, #0x4
               	mov	x0, #0x14               // =20
               	str	w0, [x15]
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x8
               	mov	x0, #0x1e               // =30
               	str	w0, [x13]
               	sub	x15, x29, #0x30
               	add	x15, x15, #0xc
               	mov	x0, #0x28               // =40
               	str	w0, [x15]
               	sub	x13, x29, #0x30
               	ldrsw	x13, [x13]
               	cmp	x13, #0xa
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x4
               	ldrsw	x13, [x13]
               	cmp	x13, #0x14
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x8
               	ldrsw	x13, [x13]
               	cmp	x13, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	add	x13, x13, #0xc
               	ldrsw	x13, [x13]
               	cmp	x13, #0x28
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x40
               	mov	x0, #0x7                // =7
               	str	w0, [x13]
               	sub	x15, x29, #0x40
               	add	x15, x15, #0x4
               	mov	x0, #0x1234             // =4660
               	strh	w0, [x15]
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x6
               	mov	x0, #0x5678             // =22136
               	strh	w0, [x13]
               	sub	x15, x29, #0x40
               	add	x15, x15, #0x8
               	mov	x0, #0x9                // =9
               	str	w0, [x15]
               	sub	x13, x29, #0x40
               	ldrsw	x13, [x13]
               	cmp	x13, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x4
               	ldrsh	x13, [x13]
               	mov	x17, #0x1234            // =4660
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x6
               	ldrsh	x13, [x13]
               	mov	x17, #0x5678            // =22136
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x8
               	ldrsw	x13, [x13]
               	cmp	x13, #0x9
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x1234            // =4660
               	movk	x13, #0x5678, lsl #16
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, x13
               	b.eq	<addr>
               	mov	x13, #0x22              // =34
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x13, #0x58              // =88
               	strb	w13, [x0]
               	sub	x15, x29, #0x58
               	add	x15, x15, #0x1
               	mov	x13, #0x61              // =97
               	strb	w13, [x15]
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x2
               	mov	x13, #0x62              // =98
               	strb	w13, [x0]
               	sub	x15, x29, #0x58
               	add	x15, x15, #0x3
               	mov	x13, #0x63              // =99
               	strb	w13, [x15]
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x4
               	mov	x13, #0x64              // =100
               	strb	w13, [x0]
               	sub	x15, x29, #0x58
               	add	x15, x15, #0x8
               	mov	x13, #0xdef0            // =57072
               	movk	x13, #0x9abc, lsl #16
               	movk	x13, #0x5678, lsl #32
               	movk	x13, #0x1234, lsl #48
               	str	x13, [x15]
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0]
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x13, #0x28              // =40
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x1
               	ldrb	w0, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x13, #0x29              // =41
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x2
               	ldrb	w0, [x0]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x13, #0x2a              // =42
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x3
               	ldrb	w0, [x0]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x13, #0x2b              // =43
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x4
               	ldrb	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x13, #0x2c              // =44
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0xdef0            // =57072
               	movk	x17, #0x9abc, lsl #16
               	movk	x17, #0x5678, lsl #32
               	movk	x17, #0x1234, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x13, #0x2d              // =45
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
