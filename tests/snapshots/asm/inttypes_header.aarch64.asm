
inttypes_header.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x150
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x40]
               	b	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrb	w1, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd4
               	ldrb	w1, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x75              // =117
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd8
               	ldrb	w1, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x78              // =120
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xdc
               	ldrb	w1, [x0]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x1]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xde
               	ldrb	w1, [x0]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe2
               	ldrb	w1, [x0]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldrb	w0, [x0, #0x2]
               	cmp	x0, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe5
               	ldrb	w1, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe9
               	ldrb	w1, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
