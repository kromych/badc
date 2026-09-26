
bitfield_attribute_after_width.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x38
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x9]
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xfffffffffffffff0
               	mov	x17, #0xd               // =13
               	orr	x1, x1, x17
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xffffffffffffff0f
               	mov	x17, #0x50              // =80
               	orr	x1, x1, x17
               	str	w1, [x0, #0x8]
               	ldrb	w1, [x0, #0x8]
               	mov	x17, #0x5d              // =93
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xf
               	lsl	x1, x1, #60
               	asr	x1, x1, #60
               	mov	x17, #-0x3              // =-3
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w1, [x0, #0x8]
               	asr	x1, x1, #4
               	and	x1, x1, #0xf
               	lsl	x1, x1, #60
               	asr	x1, x1, #60
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x9]
               	eor	x0, x0, #0x2
               	cbz	w0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x2, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x11]
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xfffffffffffffff0
               	orr	x1, x1, #0x7
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x10]
               	and	x1, x1, #0xfffffffffffffff0
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x10]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x3
               	cbnz	w1, <addr>
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xf
               	lsl	x1, x1, #60
               	asr	x1, x1, #60
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldr	w1, [x0, #0x10]
               	and	x1, x1, #0xf
               	lsl	x1, x1, #60
               	asr	x1, x1, #60
               	mov	x17, #-0x8              // =-8
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x11]
               	eor	x0, x0, #0x4
               	cbz	w0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	mov	x1, #0x0                // =0
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	sub	x0, x29, #0x48
               	mov	x1, #0x5                // =5
               	strb	w1, [x0]
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x5]
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	mov	x17, #0x32eb            // =13035
               	movk	x17, #0x38a4, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x0, #0x1]
               	ldrb	w1, [x0]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0x3fffffff
               	lsl	x1, x1, #34
               	asr	x1, x1, #34
               	mov	x17, #-0xcd15           // =-52501
               	movk	x17, #0xf8a4, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x5]
               	eor	x1, x1, #0x6
               	cbz	w1, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x1fffffff
               	stur	w1, [x0, #0x1]
               	ldrb	w1, [x0]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0x3fffffff
               	lsl	x1, x1, #34
               	asr	x1, x1, #34
               	mov	x17, #0x1fffffff        // =536870911
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x5]
               	eor	x0, x0, #0x6
               	cbz	w0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x70
               	mov	x1, #0x7                // =7
               	strb	w1, [x0]
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x15]
               	ldr	x1, [x0, #0x10]
               	and	x1, x1, #0xffffff0000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfe, lsl #32
               	orr	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x7
               	cbnz	w1, <addr>
               	ldr	x1, [x0, #0x10]
               	and	x1, x1, #0xffffffffff
               	lsl	x1, x1, #24
               	asr	x1, x1, #24
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x15]
               	eor	x1, x1, #0x8
               	cbz	w1, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0, #0x10]
               	mov	x17, #0x77              // =119
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x28
               	mov	x1, #0x9                // =9
               	strb	w1, [x0]
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x0]
               	mov	x17, #0x9               // =9
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0x2]
               	ldrh	w1, [x0]
               	and	x1, x1, #0xfffffffffffff000
               	orr	x1, x1, #0x7ff
               	strh	w1, [x0]
               	ldrh	w1, [x0]
               	and	x1, x1, #0xfff
               	lsl	x1, x1, #52
               	asr	x1, x1, #52
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0xb               // =11
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x12               // =18
               	strb	w1, [x0]
               	ldrh	w1, [x0]
               	and	x1, x1, #0xfff
               	lsl	x1, x1, #52
               	asr	x1, x1, #52
               	cmp	w1, #0x712
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0xb               // =11
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrh	w1, [x0]
               	and	x1, x1, #0xfffffffffffff000
               	orr	x1, x1, #0x800
               	strh	w1, [x0]
               	ldrh	w1, [x0]
               	and	x1, x1, #0xfff
               	lsl	x1, x1, #52
               	asr	x1, x1, #52
               	mov	x17, #-0x800            // =-2048
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w1, [x0]
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
