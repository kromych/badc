
packed_member_declaration.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x30
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x30
               	mov	x1, #0x7                // =7
               	strb	w1, [x0]
               	strb	w1, [x0, #0x5]
               	add	x1, x0, #0x5
               	mov	x2, #0x3344             // =13124
               	movk	x2, #0x1122, lsl #16
               	stur	w2, [x1, #0x1]
               	ldrb	w1, [x1]
               	eor	x1, x1, #0x7
               	cbz	w1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x5]
               	eor	x1, x1, #0x7
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x44              // =68
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x9]
               	mov	x17, #0x11              // =17
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #-0x5               // =-5
               	stur	w1, [x0, #0x1]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x7
               	cbnz	w1, <addr>
               	ldursw	x0, [x0, #0x6]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	mov	x1, #0x304              // =772
               	movk	x1, #0x102, lsl #16
               	stur	w1, [x0, #0x1]
               	mov	x1, #-0x7               // =-7
               	stur	w1, [x0, #0x5]
               	mov	x1, #0x9                // =9
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldursw	x1, [x0, #0x1]
               	mov	x17, #0x304             // =772
               	movk	x17, #0x102, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldursw	x1, [x0, #0x5]
               	mov	x17, #-0x7              // =-7
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	sub	x0, x29, #0x38
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x5]
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	mov	x17, #0x32eb            // =13035
               	movk	x17, #0x38a4, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x0, #0x1]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x1
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
               	eor	x1, x1, #0x2
               	cbz	w1, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x1fffffff
               	stur	w1, [x0, #0x1]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0x3fffffff
               	lsl	x1, x1, #34
               	asr	x1, x1, #34
               	mov	x17, #0x1fffffff        // =536870911
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x5]
               	eor	x0, x0, #0x2
               	cbz	w0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	ldr	w1, [x0]
               	and	x1, x1, #0xfffffffff00000ff
               	mov	x17, #0x100             // =256
               	movk	x17, #0x800, lsl #16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldur	w1, [x0, #0x3]
               	and	x1, x1, #0xffffffffff00000f
               	orr	x1, x1, #0x7ffff0
               	stur	w1, [x0, #0x3]
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x3
               	cbnz	w1, <addr>
               	ldr	w1, [x0]
               	asr	x1, x1, #8
               	and	x1, x1, #0xfffff
               	lsl	x1, x1, #44
               	asr	x1, x1, #44
               	mov	x17, #-0x7ffff          // =-524287
               	cmp	w1, w17
               	b.ne	<addr>
               	ldur	w1, [x0, #0x3]
               	asr	x1, x1, #4
               	and	x1, x1, #0xfffff
               	lsl	x1, x1, #44
               	asr	x1, x1, #44
               	mov	x17, #0x7ffff           // =524287
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	eor	x1, x1, #0x4
               	cbz	w1, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x0, #0x3]
               	and	x1, x1, #0xffffffffff00000f
               	orr	x1, x1, #0xfffff0
               	stur	w1, [x0, #0x3]
               	ldr	w1, [x0]
               	asr	x1, x1, #8
               	and	x1, x1, #0xfffff
               	lsl	x1, x1, #44
               	asr	x1, x1, #44
               	mov	x17, #-0x7ffff          // =-524287
               	cmp	w1, w17
               	b.ne	<addr>
               	ldur	w1, [x0, #0x3]
               	asr	x1, x1, #4
               	and	x1, x1, #0xfffff
               	lsl	x1, x1, #44
               	asr	x1, x1, #44
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x6]
               	eor	x0, x0, #0x4
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x5                // =5
               	strb	w1, [x0]
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x6]
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xffffff0000000000
               	orr	x1, x1, #0x7fffffffff
               	stur	x1, [x0, #0x1]
               	ldrb	w1, [x0]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xffffffffff
               	lsl	x1, x1, #24
               	asr	x1, x1, #24
               	mov	x17, #0x7fffffffff      // =549755813887
               	cmp	x1, x17
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	eor	x1, x1, #0x6
               	cbz	w1, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xffffff0000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfe, lsl #32
               	orr	x1, x1, x17
               	stur	x1, [x0, #0x1]
               	ldrb	w1, [x0]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xffffffffff
               	lsl	x1, x1, #24
               	asr	x1, x1, #24
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x6]
               	eor	x0, x0, #0x6
               	cbz	w0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
