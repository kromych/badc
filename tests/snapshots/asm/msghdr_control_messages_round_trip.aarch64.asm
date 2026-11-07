
msghdr_control_messages_round_trip.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x130]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x120]
               	add	x29, sp, #0x120
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x28]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0xd8]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x1, x0
               	bl	<addr>
               	mov	x22, x0
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	stur	w0, [x29, #-0xc]
               	cmp	w22, #0x0
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0x10               // =16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x1c               // =28
               	stur	w0, [x29, #-0x28]
               	mov	x0, #0x36               // =54
               	sturb	w0, [x29, #-0x30]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0xc8]
               	mov	x2, #0x0                // =0
               	mov	x0, #0xa                // =10
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x22, x0
               	cmp	w22, #0x0
               	b.ge	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x61
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x72               // =114
               	sturb	w0, [x29, #-0x20]
               	mov	x2, #0x0                // =0
               	sturb	w2, [x29, #-0x28]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	sub	x3, x29, #0x8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x78
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x40
               	stur	x1, [x29, #-0x58]
               	mov	x2, #0x30               // =48
               	stur	x2, [x29, #-0x50]
               	mov	x2, #0x14               // =20
               	str	x2, [x1]
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x18
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x13               // =19
               	str	x0, [x1]
               	sub	x0, x29, #0x78
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	b	<addr>
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x40
               	add	x1, x1, #0x10
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	b	<addr>
               	sub	x1, x29, #0x40
               	str	xzr, [x1]
               	sub	x0, x29, #0x78
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	sub	x0, x29, #0x78
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2e               // =46
               	b	<addr>
               	mov	x0, #0xf                // =15
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x20
               	stur	x0, [x29, #-0x38]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x0, x29, #0xb0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x38
               	stur	x0, [x29, #-0x60]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x58]
               	sub	x0, x29, #0xb0
               	stur	x0, [x29, #-0x50]
               	mov	x2, #0x18               // =24
               	stur	x2, [x29, #-0x48]
               	str	w1, [x0, #0x8]
               	str	w1, [x0, #0xc]
               	mov	x1, #0x14               // =20
               	str	x1, [x0]
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x10
               	mov	x2, #0x4                // =4
               	add	x1, x1, #0x4
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	ldursw	x0, [x29, #-0x8]
               	sub	x1, x29, #0x70
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	b	<addr>
               	sub	x0, x29, #0xb0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x1, x29, #0x70
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x48]
               	mov	x2, #0x0                // =0
               	sturb	w2, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x4]
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x20]
               	cmp	w0, #0x72
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x1, [x29, #-0x50]
               	cbz	x1, <addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldr	x0, [x1]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	b	<addr>
               	sub	x0, x29, #0x18
               	add	x1, x1, #0x10
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x1, [x29, #-0xc]
               	cmp	w0, w1
               	b.eq	<addr>
               	ldursw	x0, [x29, #-0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	sub	x1, x29, #0x28
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x28]
               	cmp	w0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	bl	<addr>
               	ldursw	x0, [x29, #-0xc]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x4]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1c               // =28
               	bl	<addr>
               	sub	x1, x29, #0x20
               	mov	x0, #0xa                // =10
               	sturh	w0, [x29, #-0x20]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x9]
               	mov	x2, #0x1c               // =28
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x15               // =21
               	b	<addr>
               	sub	x1, x29, #0x20
               	sub	x2, x29, #0x28
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	mov	x1, #0x29               // =41
               	mov	x2, #0x31               // =49
               	sub	x3, x29, #0xc8
               	mov	x4, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	sub	x1, x29, #0x30
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	sub	x4, x29, #0x20
               	mov	x5, #0x1c               // =28
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	sub	x0, x29, #0x30
               	stur	x0, [x29, #-0x40]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x38]
               	sub	x0, x29, #0x78
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0xb8
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x50]
               	mov	x2, #0x0                // =0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cmp	w0, #0x36
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	ldur	x0, [x29, #-0x50]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x21, [x29, #-0x58]
               	mov	x20, #0x0               // =0
               	cbz	x21, <addr>
               	ldrsw	x0, [x21, #0x8]
               	cmp	w0, #0x29
               	b.ne	<addr>
               	ldrsw	x0, [x21, #0xc]
               	cmp	w0, #0x32
               	b.ne	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x24
               	b.ne	<addr>
               	sub	x0, x29, #0xe8
               	add	x1, x21, #0x10
               	mov	x2, #0x14               // =20
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	ldur	w0, [x29, #-0xe8]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0xe4]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0xe0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xdc]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xdb]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xda]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xd9]
               	cmp	w0, #0x1
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0xd8]
               	cmp	w0, #0x0
               	cset	x20, hi
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	sub	x0, x29, #0x78
               	mov	x1, x21
               	bl	<addr>
               	mov	x21, x0
               	cbnz	x21, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	b	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x28
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sub	x3, x29, #0xd8
               	mov	x4, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x50]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x40]
               	sub	x0, x29, #0x90
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x1, x29, #0x90
               	sub	x0, x29, #0x10
               	stur	x0, [x29, #-0x90]
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x88]
               	sub	x0, x29, #0x58
               	stur	x0, [x29, #-0x80]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x78]
               	mov	x2, #0x0                // =0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x30
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x38
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x40]
               	sub	x0, x29, #0x90
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x1, x29, #0x90
               	sub	x0, x29, #0x20
               	stur	x0, [x29, #-0x90]
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x88]
               	sub	x0, x29, #0x58
               	stur	x0, [x29, #-0x80]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x78]
               	sub	x0, x29, #0xd0
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x68]
               	mov	x2, #0x0                // =0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	b	<addr>
               	ldur	w0, [x29, #-0x88]
               	cmp	w0, #0x10
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x1e]
               	ldurh	w1, [x29, #-0xe]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w20, [x29, #-0x1c]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	b	<addr>
               	ldursw	x0, [x29, #-0x60]
               	mov	x17, #0x28              // =40
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	b	<addr>
               	ldur	x0, [x29, #-0x68]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x20, [x29, #-0x70]
               	mov	x21, #0x0               // =0
               	cbz	x20, <addr>
               	ldrsw	x0, [x20, #0x8]
               	cbnz	w0, <addr>
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x1c
               	b.ne	<addr>
               	sub	x0, x29, #0xf8
               	add	x1, x20, #0x10
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	ldur	w21, [x29, #-0xf0]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	cmp	x21, x0
               	mov	x21, #0x0               // =0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xf8]
               	cmp	w0, #0x0
               	cset	x21, gt
               	sub	x0, x29, #0x90
               	mov	x1, x20
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbz	x21, <addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x13               // =19
               	b	<addr>
               	mov	x0, #0x12               // =18
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
