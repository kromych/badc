
inttypes_header.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x160
               	str	x19, [sp]
               	mov	x15, #0xfffc            // =65532
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	stur	x15, [x29, #-0x20]
               	mov	x14, #0x4               // =4
               	stur	x14, [x29, #-0x40]
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x12               // =18
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x14               // =20
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x6c              // =108
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	cbnz	x0, <addr>
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x6c              // =108
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	stur	x13, [x29, #-0xb8]
               	b	<addr>
               	ldur	x13, [x29, #-0xb8]
               	stur	x13, [x29, #-0xb0]
               	cbnz	x13, <addr>
               	add	x0, x15, #0x2
               	ldrb	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xb0]
               	b	<addr>
               	ldur	x0, [x29, #-0xb0]
               	stur	x0, [x29, #-0xa8]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x3
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0xa8]
               	b	<addr>
               	ldur	x15, [x29, #-0xa8]
               	cbz	x15, <addr>
               	mov	x0, #0x1e               // =30
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd4
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x6c              // =108
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xd0]
               	cbnz	x0, <addr>
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x6c              // =108
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	stur	x13, [x29, #-0xd0]
               	b	<addr>
               	ldur	x13, [x29, #-0xd0]
               	stur	x13, [x29, #-0xc8]
               	cbnz	x13, <addr>
               	add	x0, x15, #0x2
               	ldrb	w0, [x0]
               	mov	x17, #0x75              // =117
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0xc0]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x3
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0xc0]
               	b	<addr>
               	ldur	x15, [x29, #-0xc0]
               	cbz	x15, <addr>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd8
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x6c              // =108
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xe8]
               	cbnz	x0, <addr>
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x6c              // =108
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	stur	x13, [x29, #-0xe8]
               	b	<addr>
               	ldur	x13, [x29, #-0xe8]
               	stur	x13, [x29, #-0xe0]
               	cbnz	x13, <addr>
               	add	x0, x15, #0x2
               	ldrb	w0, [x0]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xe0]
               	b	<addr>
               	ldur	x0, [x29, #-0xe0]
               	stur	x0, [x29, #-0xd8]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x3
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0xd8]
               	b	<addr>
               	ldur	x15, [x29, #-0xd8]
               	cbz	x15, <addr>
               	mov	x0, #0x20               // =32
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xdc
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xf0]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x1
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0xf0]
               	b	<addr>
               	ldur	x15, [x29, #-0xf0]
               	cbz	x15, <addr>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xde
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x108
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x68              // =104
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	sub	x17, x29, #0x108
               	str	x13, [x17]
               	b	<addr>
               	sub	x16, x29, #0x108
               	ldr	x13, [x16]
               	stur	x13, [x29, #-0x100]
               	cbnz	x13, <addr>
               	add	x0, x15, #0x2
               	ldrb	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x100]
               	b	<addr>
               	ldur	x0, [x29, #-0x100]
               	stur	x0, [x29, #-0xf8]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x3
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0xf8]
               	b	<addr>
               	ldur	x15, [x29, #-0xf8]
               	cbz	x15, <addr>
               	mov	x0, #0x22               // =34
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe2
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x118
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x64              // =100
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	sub	x17, x29, #0x118
               	str	x13, [x17]
               	b	<addr>
               	sub	x16, x29, #0x118
               	ldr	x13, [x16]
               	sub	x17, x29, #0x110
               	str	x13, [x17]
               	cbnz	x13, <addr>
               	add	x15, x15, #0x2
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	sub	x17, x29, #0x110
               	str	x15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x110
               	ldr	x15, [x16]
               	cbz	x15, <addr>
               	mov	x0, #0x23               // =35
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe5
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x6c              // =108
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x130
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x6c              // =108
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	sub	x17, x29, #0x130
               	str	x13, [x17]
               	b	<addr>
               	sub	x16, x29, #0x130
               	ldr	x13, [x16]
               	sub	x17, x29, #0x128
               	str	x13, [x17]
               	cbnz	x13, <addr>
               	add	x0, x15, #0x2
               	ldrb	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x128
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x128
               	ldr	x0, [x16]
               	sub	x17, x29, #0x120
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x3
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	sub	x17, x29, #0x120
               	str	x15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x120
               	ldr	x15, [x16]
               	cbz	x15, <addr>
               	mov	x0, #0x24               // =36
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe9
               	mov	x15, x19
               	ldrb	w0, [x15]
               	mov	x17, #0x6c              // =108
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x148
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x6c              // =108
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	sub	x17, x29, #0x148
               	str	x13, [x17]
               	b	<addr>
               	sub	x16, x29, #0x148
               	ldr	x13, [x16]
               	sub	x17, x29, #0x140
               	str	x13, [x17]
               	cbnz	x13, <addr>
               	add	x0, x15, #0x2
               	ldrb	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x140
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x140
               	ldr	x0, [x16]
               	sub	x17, x29, #0x138
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	add	x15, x15, #0x3
               	ldrb	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	sub	x17, x29, #0x138
               	str	x15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x138
               	ldr	x15, [x16]
               	cbz	x15, <addr>
               	mov	x0, #0x25               // =37
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
