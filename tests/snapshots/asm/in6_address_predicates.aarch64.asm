
in6_address_predicates.aarch64:	file format elf64-littleaarch64

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

<in6>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	wzr, [x29, #-0x10]
               	stur	wzr, [x29, #-0xc]
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x4]
               	sub	x5, x29, #0x10
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x10]
               	and	x0, x1, #0xff
               	sturb	w0, [x29, #-0xf]
               	and	x0, x2, #0xff
               	sturb	w0, [x29, #-0x6]
               	and	x0, x3, #0xff
               	sturb	w0, [x29, #-0x5]
               	and	x0, x4, #0xff
               	sturb	w0, [x29, #-0x1]
               	mov	x16, x5
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x110]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x100]
               	add	x29, sp, #0x100
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	stur	x1, [x29, #-0x48]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x1, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	mov	x0, #0xfe               // =254
               	mov	x1, #0x80               // =128
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	mov	x0, #0xfe               // =254
               	mov	x1, #0xc0               // =192
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xff               // =255
               	mov	x4, #0x1                // =1
               	mov	x1, x0
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w23, [x29, #-0x10]
               	ldur	w24, [x29, #-0xc]
               	ldurb	w25, [x29, #-0x8]
               	ldurb	w26, [x29, #-0x7]
               	ldurb	w27, [x29, #-0x6]
               	ldurb	w28, [x29, #-0x5]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x2                // =2
               	mov	x1, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w17, [x29, #-0x10]
               	str	x17, [sp, #0xa8]
               	ldur	w17, [x29, #-0xc]
               	str	x17, [sp, #0xa0]
               	ldur	w17, [x29, #-0x8]
               	str	x17, [sp, #0x98]
               	ldur	w17, [x29, #-0x4]
               	str	x17, [sp, #0x90]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	mov	x4, x1
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldurb	w17, [x29, #-0x10]
               	str	x17, [sp, #0x88]
               	ldurb	w17, [x29, #-0xf]
               	str	x17, [sp, #0x80]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldurb	w17, [x29, #-0x10]
               	str	x17, [sp, #0x78]
               	ldurb	w17, [x29, #-0xf]
               	str	x17, [sp, #0x70]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x5                // =5
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldurb	w17, [x29, #-0x10]
               	str	x17, [sp, #0x68]
               	ldurb	w20, [x29, #-0xf]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x8                // =8
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldurb	w17, [x29, #-0x10]
               	str	x17, [sp, #0x60]
               	ldurb	w21, [x29, #-0xf]
               	mov	x0, #0xff               // =255
               	mov	x1, #0xe                // =14
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldurb	w17, [x29, #-0x10]
               	str	x17, [sp, #0x58]
               	ldurb	w22, [x29, #-0xf]
               	ldur	w0, [x29, #-0x50]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x4c]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x48]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x44]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x40]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x3c]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x38]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x34]
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldur	w0, [x29, #-0x40]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x3c]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x38]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x34]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x33]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x32]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x31]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x50]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x4c]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x48]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x44]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x43]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x42]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x41]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldurb	w0, [x29, #-0x30]
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2f]
               	and	x0, x0, #0xc0
               	cmp	w0, #0x80
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x20]
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x1f]
               	and	x0, x0, #0xc0
               	cmp	w0, #0x80
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldurb	w0, [x29, #-0x20]
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x1f]
               	and	x0, x0, #0xc0
               	cmp	w0, #0xc0
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2f]
               	and	x0, x0, #0xc0
               	cmp	w0, #0xc0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	cbnz	w23, <addr>
               	cbnz	w24, <addr>
               	cbnz	w25, <addr>
               	cbnz	w26, <addr>
               	cmp	w27, #0xff
               	b.ne	<addr>
               	cmp	w28, #0xff
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x40]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x3c]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x38]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x37]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x36]
               	cmp	w0, #0xff
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x35]
               	cmp	w0, #0xff
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldr	x16, [sp, #0xa8]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xa0]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0x98]
               	cbnz	w16, <addr>
               	ldr	x0, [sp, #0x90]
               	bl	<addr>
               	mov	w0, w0
               	cmp	x0, #0x1
               	b.ls	<addr>
               	ldur	w0, [x29, #-0x40]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x3c]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x38]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x34]
               	bl	<addr>
               	mov	w0, w0
               	cmp	x0, #0x1
               	b.ls	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldr	x16, [sp, #0x78]
               	cmp	w16, #0xff
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cmp	w0, #0xff
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldr	x16, [sp, #0x88]
               	cmp	w16, #0xff
               	b.ne	<addr>
               	ldr	x16, [sp, #0x80]
               	and	x0, x16, #0xf
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldr	x16, [sp, #0x70]
               	and	x1, x16, #0xf
               	cmp	w1, #0x1
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	x16, [sp, #0x68]
               	eor	x1, x16, #0xff
               	cbnz	w1, <addr>
               	and	x2, x20, #0xf
               	cmp	w2, #0x2
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	cbnz	w1, <addr>
               	and	x1, x20, #0xf
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x16, [sp, #0x60]
               	eor	x1, x16, #0xff
               	cbnz	w1, <addr>
               	and	x2, x21, #0xf
               	cmp	w2, #0x5
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	cbnz	w1, <addr>
               	and	x1, x21, #0xf
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldr	x16, [sp, #0x58]
               	eor	x1, x16, #0xff
               	cbnz	w1, <addr>
               	and	x2, x22, #0xf
               	cmp	w2, #0x8
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	cbnz	w1, <addr>
               	and	x1, x22, #0xf
               	cmp	w1, #0xe
               	b.ne	<addr>
               	cmp	w0, #0xe
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldur	w0, [x29, #-0x30]
               	ldur	w1, [x29, #-0x2c]
               	ldur	w2, [x29, #-0x28]
               	ldur	w3, [x29, #-0x24]
               	ldur	w4, [x29, #-0x20]
               	cmp	w0, w4
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x1c]
               	cmp	w1, w0
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x18]
               	cmp	w2, w0
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x14]
               	cmp	w3, w0
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
