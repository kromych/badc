
anonymous_aggregates.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xe8
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x100
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x106
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10d
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0xcdef             // =52719
               	movk	x1, #0x90ab, lsl #16
               	movk	x1, #0x5678, lsl #32
               	movk	x1, #0x1234, lsl #48
               	str	x1, [x0]
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x90ab, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x90ab, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0xbabe             // =47806
               	movk	x1, #0xcafe, lsl #16
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0xf00d             // =61453
               	movk	x1, #0xbad, lsl #16
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0xf00d            // =61453
               	movk	x17, #0xbad, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	movk	x17, #0xf00d, lsl #32
               	movk	x17, #0xbad, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	mov	x1, #0x2a               // =42
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	mov	x1, #0x63               // =99
               	str	w1, [x0, #0x10]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	mov	x1, #0x851f             // =34079
               	movk	x1, #0x51eb, lsl #16
               	movk	x1, #0x1eb8, lsl #32
               	movk	x1, #0x4009, lsl #48
               	fmov	d16, x1
               	str	d16, [x0]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x63
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
               	sub	x0, x29, #0x30
               	mov	x1, #0xa                // =10
               	str	w1, [x0]
               	sub	x0, x29, #0x30
               	mov	x1, #0x14               // =20
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x30
               	mov	x1, #0x1e               // =30
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	mov	x1, #0x28               // =40
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0x4]
               	sub	x0, x29, #0x40
               	mov	x1, #0x5678             // =22136
               	strh	w1, [x0, #0x6]
               	sub	x0, x29, #0x40
               	mov	x1, #0x9                // =9
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldrsh	x0, [x0, #0x4]
               	mov	x17, #0x1234            // =4660
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldrsh	x0, [x0, #0x6]
               	mov	x17, #0x5678            // =22136
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	movk	x0, #0x5678, lsl #16
               	sub	x1, x29, #0x40
               	ldrsw	x1, [x1, #0x4]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x1, #0x58               // =88
               	strb	w1, [x0]
               	sub	x0, x29, #0x58
               	mov	x1, #0x61               // =97
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x58
               	mov	x1, #0x62               // =98
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x58
               	mov	x1, #0x63               // =99
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x58
               	mov	x1, #0x64               // =100
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x58
               	mov	x1, #0xdef0             // =57072
               	movk	x1, #0x9abc, lsl #16
               	movk	x1, #0x5678, lsl #32
               	movk	x1, #0x1234, lsl #48
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0]
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xdef0            // =57072
               	movk	x17, #0x9abc, lsl #16
               	movk	x17, #0x5678, lsl #32
               	movk	x17, #0x1234, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
