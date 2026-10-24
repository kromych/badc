
socket_type_peek_and_pktinfo.aarch64:	file format elf64-littleaarch64

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

<pktinfo_round_trip>:
               	stp	x20, x21, [sp, #-0xb0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x80]
               	mov	x0, #0x70               // =112
               	sturb	w0, [x29, #-0x78]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x70]
               	mov	x0, #0x2                // =2
               	mov	x2, #0x0                // =0
               	mov	x1, x0
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x68
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	sturh	w0, [x29, #-0x68]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	stur	w0, [x29, #-0x64]
               	cmp	w22, #0x0
               	b.lt	<addr>
               	sub	x1, x29, #0x68
               	mov	x2, #0x10               // =16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x1, x29, #0x68
               	sub	x2, x29, #0x80
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sub	x3, x29, #0x70
               	mov	x4, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x1, x29, #0x78
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	sub	x4, x29, #0x68
               	mov	x5, #0x10               // =16
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x78
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x1, x29, #0x38
               	sub	x0, x29, #0x58
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x28               // =40
               	stur	x0, [x29, #-0x10]
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x20, [x29, #-0x18]
               	mov	x21, #0x0               // =0
               	cbz	x20, <addr>
               	ldrsw	x0, [x20, #0x8]
               	cbnz	w0, <addr>
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	sub	x0, x29, #0x48
               	add	x1, x20, #0x10
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	ldur	w21, [x29, #-0x40]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	cmp	x21, x0
               	mov	x21, #0x0               // =0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x48]
               	cmp	w0, #0x0
               	cset	x21, gt
               	ldr	x0, [x20]
               	add	x0, x0, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x0, x20, x0
               	add	x0, x0, #0x10
               	ldur	x1, [x29, #-0x18]
               	ldur	x2, [x29, #-0x10]
               	add	x1, x1, x2
               	cmp	x0, x1
               	b.ls	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	ldr	x0, [x20]
               	add	x0, x0, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x20, x20, x0
               	cbnz	x20, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbnz	w21, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0xa                // =10
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.lt	<addr>
               	mov	x1, #0x29               // =41
               	mov	x2, #0x31               // =49
               	sub	x3, x29, #0x70
               	mov	x4, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x18]
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	sub	x3, x29, #0x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x20]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x3                // =3
               	sub	x3, x29, #0x18
               	sub	x4, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x20]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x1c]
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	sub	x3, x29, #0x20
               	mov	x1, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x1c]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x3                // =3
               	sub	x3, x29, #0x18
               	sub	x4, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	ldursw	x0, [x29, #-0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x1c]
               	sub	x1, x29, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	sub	x1, x29, #0x8
               	ldurb	w0, [x29, #-0x8]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x1c]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x100              // =256
               	bl	<addr>
               	cmp	x0, #0x2
               	b.ne	<addr>
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x20]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x1c]
               	bl	<addr>
               	bl	<addr>
               	cbz	w0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
