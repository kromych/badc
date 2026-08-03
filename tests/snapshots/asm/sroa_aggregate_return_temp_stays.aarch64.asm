
sroa_aggregate_return_temp_stays.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<times5>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x38
               	ldr	w0, [x0]
               	lsl	x0, x0, #2
               	mov	w1, w0
               	sub	x0, x29, #0x38
               	ldr	w0, [x0, #0x4]
               	lsr	x0, x0, #30
               	orr	x1, x1, x0
               	sub	x0, x29, #0x38
               	ldr	w0, [x0, #0x4]
               	lsl	x0, x0, #2
               	mov	w0, w0
               	mov	w2, w1
               	mov	w0, w0
               	sub	x1, x29, #0x28
               	mov	w2, w2
               	mov	w0, w0
               	str	w2, [x1]
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x28
               	sub	x3, x29, #0x50
               	sub	x4, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [sp], #0x10
               	mov	x1, x4
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	w1, w2
               	sub	x2, x29, #0x40
               	ldr	w2, [x2]
               	add	x1, x1, x2
               	mov	w2, w1
               	mov	w3, w0
               	sub	x1, x29, #0x40
               	ldr	w1, [x1, #0x4]
               	add	x1, x3, x1
               	mov	w3, w1
               	sub	x1, x29, #0x18
               	mov	w2, w2
               	str	w2, [x1]
               	sub	x1, x29, #0x18
               	mov	w2, w3
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x18
               	sub	x2, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x48
               	ldr	w1, [x1, #0x4]
               	mov	w0, w0
               	cmp	x1, x0
               	b.hs	<addr>
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sub	x1, x29, #0x48
               	sub	x0, x29, #0x30
               	ldr	w2, [x1]
               	ldr	w1, [x1, #0x4]
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x30
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<times9>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x38
               	ldr	w0, [x0]
               	lsl	x0, x0, #3
               	mov	w1, w0
               	sub	x0, x29, #0x38
               	ldr	w0, [x0, #0x4]
               	lsr	x0, x0, #29
               	orr	x1, x1, x0
               	sub	x0, x29, #0x38
               	ldr	w0, [x0, #0x4]
               	lsl	x0, x0, #3
               	mov	w0, w0
               	mov	w2, w1
               	mov	w0, w0
               	sub	x1, x29, #0x28
               	mov	w2, w2
               	mov	w0, w0
               	str	w2, [x1]
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x28
               	sub	x3, x29, #0x50
               	sub	x4, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [sp], #0x10
               	mov	x1, x4
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	w1, w2
               	sub	x2, x29, #0x40
               	ldr	w2, [x2]
               	add	x1, x1, x2
               	mov	w2, w1
               	mov	w3, w0
               	sub	x1, x29, #0x40
               	ldr	w1, [x1, #0x4]
               	add	x1, x3, x1
               	mov	w3, w1
               	sub	x1, x29, #0x18
               	mov	w2, w2
               	str	w2, [x1]
               	sub	x1, x29, #0x18
               	mov	w2, w3
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x18
               	sub	x2, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x48
               	ldr	w1, [x1, #0x4]
               	mov	w0, w0
               	cmp	x1, x0
               	b.hs	<addr>
               	sub	x0, x29, #0x48
               	ldr	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sub	x1, x29, #0x48
               	sub	x0, x29, #0x30
               	ldr	w2, [x1]
               	ldr	w1, [x1, #0x4]
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x30
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<step>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, x0
               	add	x0, x20, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	ldr	w0, [x0]
               	lsl	x0, x0, #7
               	mov	w1, w0
               	sub	x0, x29, #0x30
               	ldr	w0, [x0, #0x4]
               	lsr	x0, x0, #25
               	orr	x1, x1, x0
               	sub	x0, x29, #0x30
               	ldr	w0, [x0]
               	lsr	x2, x0, #25
               	sub	x0, x29, #0x30
               	ldr	w0, [x0, #0x4]
               	lsl	x0, x0, #7
               	mov	w0, w0
               	orr	x0, x2, x0
               	mov	w1, w1
               	mov	w2, w0
               	sub	x0, x29, #0x10
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x18
               	str	x0, [x16]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x20, #0x8
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	ldr	w0, [x0]
               	lsl	x0, x0, #17
               	mov	w1, w0
               	sub	x0, x29, #0x30
               	ldr	w0, [x0, #0x4]
               	lsr	x0, x0, #15
               	orr	x1, x1, x0
               	sub	x0, x29, #0x30
               	ldr	w0, [x0, #0x4]
               	lsl	x0, x0, #17
               	mov	w0, w0
               	mov	w1, w1
               	mov	w2, w0
               	sub	x0, x29, #0x20
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x20
               	sub	x3, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	add	x0, x20, #0x10
               	sub	x3, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	ldr	w3, [x0]
               	sub	x4, x29, #0x30
               	ldr	w4, [x4]
               	eor	x3, x3, x4
               	str	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	sub	x3, x29, #0x30
               	ldr	w3, [x3, #0x4]
               	eor	x3, x4, x3
               	str	w3, [x0, #0x4]
               	add	x0, x20, #0x18
               	add	x3, x20, #0x8
               	sub	x4, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	ldr	w3, [x0]
               	sub	x4, x29, #0x30
               	ldr	w4, [x4]
               	eor	x3, x3, x4
               	str	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	sub	x3, x29, #0x30
               	ldr	w3, [x3, #0x4]
               	eor	x3, x4, x3
               	str	w3, [x0, #0x4]
               	add	x0, x20, #0x8
               	add	x3, x20, #0x10
               	sub	x4, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	ldr	w3, [x0]
               	sub	x4, x29, #0x30
               	ldr	w4, [x4]
               	eor	x3, x3, x4
               	str	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	sub	x3, x29, #0x30
               	ldr	w3, [x3, #0x4]
               	eor	x3, x4, x3
               	str	w3, [x0, #0x4]
               	add	x0, x20, #0x18
               	sub	x3, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	ldr	w0, [x20]
               	sub	x3, x29, #0x30
               	ldr	w3, [x3]
               	eor	x0, x0, x3
               	str	w0, [x20]
               	ldr	w3, [x20, #0x4]
               	sub	x0, x29, #0x30
               	ldr	w0, [x0, #0x4]
               	eor	x0, x3, x0
               	str	w0, [x20, #0x4]
               	add	x0, x20, #0x10
               	sub	x3, x29, #0x38
               	sub	x4, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x0, x20, #0x18
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x30
               	ldr	w1, [x1]
               	lsr	x2, x1, #19
               	sub	x1, x29, #0x30
               	ldr	w1, [x1, #0x4]
               	lsl	x1, x1, #13
               	mov	w1, w1
               	orr	x2, x2, x1
               	sub	x1, x29, #0x30
               	ldr	w1, [x1]
               	lsl	x1, x1, #13
               	mov	w3, w1
               	sub	x1, x29, #0x30
               	ldr	w1, [x1, #0x4]
               	lsr	x1, x1, #19
               	orr	x1, x3, x1
               	mov	w2, w2
               	mov	w3, w1
               	sub	x1, x29, #0x28
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x1]
               	str	w3, [x1, #0x4]
               	sub	x1, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	ldr	x0, [x16]
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x1, x29, #0x58
               	sub	x0, x29, #0x10
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	sub	x0, x29, #0x10
               	mov	x2, #0x3ef              // =1007
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x58
               	add	x1, x0, #0x8
               	sub	x0, x29, #0x18
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	sub	x0, x29, #0x18
               	mov	x2, #0xff               // =255
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x18
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x58
               	add	x1, x0, #0x10
               	sub	x0, x29, #0x20
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	sub	x0, x29, #0x20
               	mov	x2, #0x0                // =0
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x58
               	add	x1, x0, #0x18
               	sub	x0, x29, #0x28
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	sub	x0, x29, #0x28
               	mov	x2, #0x0                // =0
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	x0, [x16]
               	sub	x0, x29, #0x38
               	ldr	w1, [x0]
               	lsl	x1, x1, #31
               	lsl	x1, x1, #1
               	ldr	w0, [x0, #0x4]
               	orr	x0, x1, x0
               	mov	x17, #0xc9d6            // =51670
               	movk	x17, #0xa323, lsl #16
               	movk	x17, #0x40a5, lsl #32
               	movk	x17, #0x7a70, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldr	w1, [x0]
               	lsl	x1, x1, #31
               	lsl	x1, x1, #1
               	ldr	w0, [x0, #0x4]
               	orr	x0, x1, x0
               	mov	x17, #0x27f9            // =10233
               	movk	x17, #0x6cb2, lsl #16
               	movk	x17, #0x8b51, lsl #32
               	movk	x17, #0xba1, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x18
               	ldr	w1, [x0]
               	lsl	x1, x1, #31
               	lsl	x1, x1, #1
               	ldr	w0, [x0, #0x4]
               	orr	x0, x1, x0
               	mov	x17, #0xcb5a            // =52058
               	movk	x17, #0x3210, lsl #16
               	movk	x17, #0x95cf, lsl #32
               	movk	x17, #0x194f, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
