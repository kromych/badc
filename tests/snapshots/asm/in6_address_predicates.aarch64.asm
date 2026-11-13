
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
               	and	x0, x0, #0xff
               	and	x1, x1, #0xff
               	orr	x0, x0, x1, lsl #8
               	and	x1, x2, #0xff
               	lsl	x1, x1, #16
               	and	x2, x3, #0xff
               	orr	x1, x1, x2, lsl #24
               	orr	x1, x1, x4, lsl #56
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x150]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x140]
               	add	x29, sp, #0x140
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w17, [x29, #-0x10]
               	str	x17, [sp, #0x120]
               	ldur	w17, [x29, #-0xc]
               	str	x17, [sp, #0x118]
               	ldur	w17, [x29, #-0x8]
               	str	x17, [sp, #0x110]
               	ldur	w21, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x1, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w24, [x29, #-0x10]
               	ldur	w25, [x29, #-0xc]
               	ldur	w26, [x29, #-0x8]
               	ldur	w20, [x29, #-0x4]
               	mov	x0, #0xfe               // =254
               	mov	x1, #0x80               // =128
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w23, [x29, #-0x10]
               	ldur	w17, [x29, #-0xc]
               	str	x17, [sp, #0x108]
               	ldur	w17, [x29, #-0x8]
               	str	x17, [sp, #0x100]
               	ldur	w17, [x29, #-0x4]
               	str	x17, [sp, #0xf8]
               	mov	x0, #0xfe               // =254
               	mov	x1, #0xc0               // =192
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w22, [x29, #-0x10]
               	ldur	w17, [x29, #-0xc]
               	str	x17, [sp, #0xf0]
               	ldur	w17, [x29, #-0x8]
               	str	x17, [sp, #0xe8]
               	ldur	w17, [x29, #-0x4]
               	str	x17, [sp, #0xe0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xff               // =255
               	mov	x4, #0x1                // =1
               	mov	x1, x0
               	mov	x3, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w17, [x29, #-0x10]
               	str	x17, [sp, #0xd8]
               	ldur	w17, [x29, #-0xc]
               	str	x17, [sp, #0xd0]
               	ldurb	w17, [x29, #-0x8]
               	str	x17, [sp, #0xc8]
               	ldurb	w17, [x29, #-0x7]
               	str	x17, [sp, #0xc0]
               	ldurb	w17, [x29, #-0x6]
               	str	x17, [sp, #0xb8]
               	ldurb	w17, [x29, #-0x5]
               	str	x17, [sp, #0xb0]
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
               	ldurb	w27, [x29, #-0xf]
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
               	ldurb	w28, [x29, #-0xf]
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
               	ldurb	w17, [x29, #-0xf]
               	str	x17, [sp, #0x128]
               	ldr	x16, [sp, #0x120]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0x118]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0x110]
               	cbnz	w16, <addr>
               	cbnz	w21, <addr>
               	cbnz	w24, <addr>
               	cbnz	w25, <addr>
               	cbnz	w26, <addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cbnz	w24, <addr>
               	cbnz	w25, <addr>
               	cbnz	w26, <addr>
               	and	x0, x20, #0xff
               	cbnz	w0, <addr>
               	ubfx	x0, x20, #8, #8
               	cbnz	w0, <addr>
               	ubfx	x0, x20, #16, #8
               	cbnz	w0, <addr>
               	lsr	x0, x20, #24
               	cmp	w0, #0x1
               	b.ne	<addr>
               	and	x0, x21, #0xff
               	cbnz	w0, <addr>
               	ubfx	x0, x21, #8, #8
               	cbnz	w0, <addr>
               	ubfx	x0, x21, #16, #8
               	cbnz	w0, <addr>
               	lsr	x0, x21, #24
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	and	x0, x23, #0xff
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ubfx	x0, x23, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0x80
               	b.ne	<addr>
               	and	x0, x22, #0xff
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ubfx	x0, x22, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0x80
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	and	x0, x22, #0xff
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ubfx	x0, x22, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0xc0
               	b.ne	<addr>
               	ubfx	x0, x23, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0xc0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	ldr	x16, [sp, #0xd8]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xd0]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xc8]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xc0]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xb8]
               	cmp	w16, #0xff
               	b.ne	<addr>
               	ldr	x16, [sp, #0xb0]
               	cmp	w16, #0xff
               	b.ne	<addr>
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
               	mov	x0, x20
               	bl	<addr>
               	mov	w0, w0
               	cmp	x0, #0x1
               	b.ls	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	ldr	x16, [sp, #0x78]
               	cmp	w16, #0xff
               	b.ne	<addr>
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
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	x16, [sp, #0x68]
               	eor	x1, x16, #0xff
               	cbnz	w1, <addr>
               	and	x2, x27, #0xf
               	cmp	w2, #0x2
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cbnz	w1, <addr>
               	and	x1, x27, #0xf
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x16, [sp, #0x60]
               	eor	x1, x16, #0xff
               	cbnz	w1, <addr>
               	and	x2, x28, #0xf
               	cmp	w2, #0x5
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cbnz	w1, <addr>
               	and	x1, x28, #0xf
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldr	x16, [sp, #0x58]
               	eor	x1, x16, #0xff
               	cbnz	w1, <addr>
               	ldr	x16, [sp, #0x128]
               	and	x2, x16, #0xf
               	cmp	w2, #0x8
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cbnz	w1, <addr>
               	ldr	x16, [sp, #0x128]
               	and	x1, x16, #0xf
               	cmp	w1, #0xe
               	b.ne	<addr>
               	cmp	w0, #0xe
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cmp	w23, w22
               	b.ne	<addr>
               	ldr	x16, [sp, #0x108]
               	ldr	x17, [sp, #0xf0]
               	cmp	w16, w17
               	b.ne	<addr>
               	ldr	x16, [sp, #0x100]
               	ldr	x17, [sp, #0xe8]
               	cmp	w16, w17
               	b.ne	<addr>
               	ldr	x16, [sp, #0xf8]
               	ldr	x17, [sp, #0xe0]
               	cmp	w16, w17
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x140]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
