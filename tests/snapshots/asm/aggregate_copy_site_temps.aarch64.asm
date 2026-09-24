
aggregate_copy_site_temps.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xd0
               	sub	x1, x29, #0xd0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x48]
               	sub	x2, x29, #0x48
               	ldr	x3, [x2]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	add	x1, x3, #0x10
               	str	x1, [x2]
               	ldur	x1, [x29, #-0x48]
               	add	x2, x0, #0x10
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x1, [x0]
               	cmp	x1, #0x7
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x88
               	mov	x1, #0x1                // =1
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x1, x29, #0x48
               	sub	x2, x29, #0x88
               	ldr	x16, [x2]
               	str	x16, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x90
               	mov	x1, #0x2                // =2
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0xc
               	b.lo	<addr>
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x90
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	w16, [x2, #0x8]
               	str	w16, [x1, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0xc
               	b.lo	<addr>
               	sub	x2, x29, #0x90
               	mov	x1, #0x3                // =3
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0xd
               	b.lo	<addr>
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x90
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	w16, [x2, #0x8]
               	str	w16, [x1, #0x8]
               	ldrb	w16, [x2, #0xc]
               	strb	w16, [x1, #0xc]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0xd
               	b.lo	<addr>
               	sub	x2, x29, #0x98
               	mov	x1, #0x4                // =4
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0x58
               	sub	x1, x29, #0x98
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	ldr	x0, [x1]
               	ldr	x3, [x1, #0x10]
               	add	x4, x0, x3
               	add	x0, x0, x3
               	cmp	x4, x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0xa8
               	mov	x1, #0x5                // =5
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lo	<addr>
               	sub	x1, x29, #0x68
               	sub	x2, x29, #0xa8
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	x16, [x2, #0x20]
               	str	x16, [x1, #0x20]
               	ldr	x0, [x1, #0x20]
               	add	x0, x0, #0xe
               	ldr	x3, [x2, #0x20]
               	add	x3, x3, #0xe
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lo	<addr>
               	sub	x2, x29, #0xa8
               	mov	x1, #0x6                // =6
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lo	<addr>
               	sub	x1, x29, #0x68
               	sub	x2, x29, #0xa8
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	x16, [x2, #0x20]
               	str	x16, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lo	<addr>
               	sub	x2, x29, #0xd0
               	mov	x1, #0x7                // =7
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x0, x29, #0x40
               	add	x2, x0, #0x20
               	sub	x1, x29, #0xd0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xc0
               	mov	x1, #0x8                // =8
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3e
               	b.lo	<addr>
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0xc0
               	add	x1, x1, #0x1f
               	add	x2, x0, #0x1f
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x1, #0x10]
               	ldr	w16, [x2, #0x18]
               	str	w16, [x1, #0x18]
               	ldrh	w16, [x2, #0x1c]
               	strh	w16, [x1, #0x1c]
               	ldrb	w16, [x2, #0x1e]
               	strb	w16, [x1, #0x1e]
               	ldrb	w3, [x1, #0x1e]
               	add	x3, x3, #0xaf
               	ldrb	w0, [x0, #0x3d]
               	add	x0, x0, #0xaf
               	cmp	w3, w0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x1f
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x9                // =9
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x208
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x16, x2
               	mov	x17, x1
               	add	x9, x16, #0x200
               	ldp	x10, x11, [x16], #0x10
               	stp	x10, x11, [x17], #0x10
               	cmp	x16, x9
               	b.ne	<addr>
               	ldr	x10, [x16]
               	str	x10, [x17]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x208
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0xa                // =10
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20c
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x16, x2
               	mov	x17, x1
               	add	x9, x16, #0x200
               	ldp	x10, x11, [x16], #0x10
               	stp	x10, x11, [x17], #0x10
               	cmp	x16, x9
               	b.ne	<addr>
               	ldr	x10, [x16]
               	str	x10, [x17]
               	ldr	w10, [x16, #0x8]
               	str	w10, [x17, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20c
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0xb                // =11
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x4
               	add	x1, x1, x3
               	mov	w5, w1
               	lsr	x5, x5, #16
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3e8
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x16, x2
               	mov	x17, x1
               	add	x9, x16, #0x3e0
               	ldp	x10, x11, [x16], #0x10
               	stp	x10, x11, [x17], #0x10
               	cmp	x16, x9
               	b.ne	<addr>
               	ldr	x10, [x16]
               	str	x10, [x17]
               	ldrb	w0, [x1, #0x3e7]
               	ldrb	w3, [x2, #0x3e7]
               	cmp	w0, w3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3e8
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0xc                // =12
               	mov	x3, #0x1008             // =4104
               	mov	x4, #0x3039             // =12345
               	mov	x5, #0x4e6d             // =20077
               	movk	x5, #0x41c6, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x1, x1, x5
               	add	x1, x1, x4
               	mov	w6, w1
               	lsr	x6, x6, #16
               	and	x6, x6, #0xff
               	strb	w6, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x16, x2
               	mov	x17, x1
               	mov	x9, #0x1000             // =4096
               	add	x9, x16, x9
               	ldp	x10, x11, [x16], #0x10
               	stp	x10, x11, [x17], #0x10
               	cmp	x16, x9
               	b.ne	<addr>
               	ldr	x10, [x16]
               	str	x10, [x17]
               	mov	x3, #0x1008             // =4104
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x1, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
