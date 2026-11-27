
in6_address_predicates.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	stp	x20, x21, [sp, #-0x140]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x130]
               	add	x29, sp, #0x130
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	mov	x25, x1
               	lsr	x16, x21, #32
               	str	x16, [sp, #0x120]
               	lsr	x16, x25, #32
               	str	x16, [sp, #0x128]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	mov	x23, x0
               	mov	x24, x1
               	lsr	x16, x23, #32
               	str	x16, [sp, #0x118]
               	lsr	x26, x24, #32
               	mov	x0, #0xfe               // =254
               	mov	x1, #0x80               // =128
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	mov	x22, x0
               	mov	x27, x1
               	lsr	x16, x22, #32
               	str	x16, [sp, #0x100]
               	lsr	x16, x27, #32
               	str	x16, [sp, #0xf8]
               	mov	x0, #0xfe               // =254
               	mov	x1, #0xc0               // =192
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	mov	x28, x1
               	lsr	x16, x20, #32
               	str	x16, [sp, #0xf0]
               	lsr	x16, x28, #32
               	str	x16, [sp, #0xe8]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0xff               // =255
               	mov	x3, #0xff               // =255
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	lsr	x16, x0, #32
               	str	x16, [sp, #0xe0]
               	and	x16, x1, #0xff
               	str	x16, [sp, #0xd8]
               	ubfx	x16, x1, #8, #8
               	str	x16, [sp, #0xd0]
               	ubfx	x16, x1, #16, #8
               	str	x16, [sp, #0xc8]
               	ubfx	x16, x1, #24, #8
               	str	x16, [sp, #0xc0]
               	str	x0, [sp, #0xb8]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x2                // =2
               	bl	<addr>
               	lsr	x16, x0, #32
               	str	x16, [sp, #0xb0]
               	lsr	x16, x1, #32
               	str	x16, [sp, #0xa8]
               	str	x0, [sp, #0xa0]
               	str	x1, [sp, #0x98]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	and	x16, x0, #0xff
               	str	x16, [sp, #0x90]
               	ubfx	x16, x0, #8, #8
               	str	x16, [sp, #0x88]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	and	x16, x0, #0xff
               	str	x16, [sp, #0x80]
               	ubfx	x16, x0, #8, #8
               	str	x16, [sp, #0x78]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x5                // =5
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	and	x16, x0, #0xff
               	str	x16, [sp, #0x70]
               	ubfx	x16, x0, #8, #8
               	str	x16, [sp, #0x110]
               	mov	x0, #0xff               // =255
               	mov	x1, #0x8                // =8
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	and	x16, x0, #0xff
               	str	x16, [sp, #0x68]
               	ubfx	x16, x0, #8, #8
               	str	x16, [sp, #0x108]
               	mov	x0, #0xff               // =255
               	mov	x1, #0xe                // =14
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1                // =1
               	bl	<addr>
               	and	x3, x0, #0xff
               	ubfx	x1, x0, #8, #8
               	cbnz	w21, <addr>
               	ldr	x16, [sp, #0x120]
               	cbnz	w16, <addr>
               	cbnz	w25, <addr>
               	ldr	x16, [sp, #0x128]
               	cbnz	w16, <addr>
               	cbnz	w23, <addr>
               	ldr	x16, [sp, #0x118]
               	cbnz	w16, <addr>
               	cbnz	w24, <addr>
               	cbnz	w26, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	cbnz	w23, <addr>
               	ldr	x16, [sp, #0x118]
               	cbnz	w16, <addr>
               	cbnz	w24, <addr>
               	and	x0, x26, #0xff
               	cbnz	w0, <addr>
               	ubfx	x0, x26, #8, #8
               	cbnz	w0, <addr>
               	ubfx	x0, x26, #16, #8
               	cbnz	w0, <addr>
               	lsr	x0, x26, #24
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldr	x16, [sp, #0x128]
               	and	x0, x16, #0xff
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x128]
               	ubfx	x2, x0, #8, #8
               	cbnz	w2, <addr>
               	ubfx	x2, x0, #16, #8
               	cbnz	w2, <addr>
               	lsr	x0, x0, #24
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	and	x0, x22, #0xff
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	mov	w0, w22
               	ubfx	x0, x0, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0x80
               	b.ne	<addr>
               	and	x0, x20, #0xff
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	mov	w0, w20
               	ubfx	x0, x0, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0x80
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	and	x0, x20, #0xff
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	mov	w0, w20
               	ubfx	x0, x0, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0xc0
               	b.ne	<addr>
               	mov	w0, w22
               	ubfx	x0, x0, #8, #8
               	and	x0, x0, #0xc0
               	cmp	w0, #0xc0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	ldr	x16, [sp, #0xb8]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xe0]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xd8]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xd0]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xc8]
               	cmp	w16, #0xff
               	b.ne	<addr>
               	ldr	x16, [sp, #0xc0]
               	cmp	w16, #0xff
               	b.ne	<addr>
               	ldr	x16, [sp, #0xa0]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0xb0]
               	cbnz	w16, <addr>
               	ldr	x16, [sp, #0x98]
               	cbnz	w16, <addr>
               	str	x3, [sp, #0x60]
               	str	x1, [sp, #0x58]
               	ldr	x0, [sp, #0xa8]
               	bl	<addr>
               	mov	w0, w0
               	ldr	x3, [sp, #0x60]
               	ldr	x1, [sp, #0x58]
               	cmp	x0, #0x1
               	b.ls	<addr>
               	str	x3, [sp, #0x60]
               	str	x1, [sp, #0x58]
               	mov	x0, x26
               	bl	<addr>
               	mov	w0, w0
               	ldr	x3, [sp, #0x60]
               	ldr	x1, [sp, #0x58]
               	cmp	x0, #0x1
               	b.ls	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	ldr	x16, [sp, #0x80]
               	cmp	w16, #0xff
               	b.ne	<addr>
               	ldr	x16, [sp, #0x90]
               	cmp	w16, #0xff
               	b.ne	<addr>
               	ldr	x16, [sp, #0x88]
               	and	x0, x16, #0xf
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldr	x16, [sp, #0x78]
               	and	x2, x16, #0xf
               	cmp	w2, #0x1
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ldr	x16, [sp, #0x70]
               	eor	x2, x16, #0xff
               	cbnz	w2, <addr>
               	ldr	x16, [sp, #0x110]
               	and	x4, x16, #0xf
               	cmp	w4, #0x2
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	cbnz	w2, <addr>
               	ldr	x16, [sp, #0x110]
               	and	x2, x16, #0xf
               	cmp	w2, #0x5
               	b.ne	<addr>
               	ldr	x16, [sp, #0x68]
               	eor	x2, x16, #0xff
               	cbnz	w2, <addr>
               	ldr	x16, [sp, #0x108]
               	and	x4, x16, #0xf
               	cmp	w4, #0x5
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	cbnz	w2, <addr>
               	ldr	x16, [sp, #0x108]
               	and	x2, x16, #0xf
               	cmp	w2, #0x8
               	b.ne	<addr>
               	eor	x2, x3, #0xff
               	cbnz	w2, <addr>
               	and	x3, x1, #0xf
               	cmp	w3, #0x8
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	cbnz	w2, <addr>
               	and	x1, x1, #0xf
               	cmp	w1, #0xe
               	b.ne	<addr>
               	cmp	w0, #0xe
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	cmp	w22, w20
               	b.ne	<addr>
               	ldr	x16, [sp, #0x100]
               	ldr	x17, [sp, #0xf0]
               	cmp	w16, w17
               	b.ne	<addr>
               	cmp	w27, w28
               	b.ne	<addr>
               	ldr	x16, [sp, #0xf8]
               	ldr	x17, [sp, #0xe8]
               	cmp	w16, w17
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
