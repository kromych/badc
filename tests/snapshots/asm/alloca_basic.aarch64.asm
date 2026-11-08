
alloca_basic.aarch64:	file format elf64-littleaarch64

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

<single>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x20               // =32
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	mov	x0, #0x55               // =85
               	strb	w0, [x1]
               	strb	w0, [x1, #0x1]
               	strb	w0, [x1, #0x2]
               	strb	w0, [x1, #0x3]
               	strb	w0, [x1, #0x4]
               	strb	w0, [x1, #0x5]
               	strb	w0, [x1, #0x6]
               	strb	w0, [x1, #0x7]
               	strb	w0, [x1, #0x8]
               	strb	w0, [x1, #0x9]
               	strb	w0, [x1, #0xa]
               	strb	w0, [x1, #0xb]
               	strb	w0, [x1, #0xc]
               	strb	w0, [x1, #0xd]
               	strb	w0, [x1, #0xe]
               	strb	w0, [x1, #0xf]
               	strb	w0, [x1, #0x10]
               	strb	w0, [x1, #0x11]
               	strb	w0, [x1, #0x12]
               	strb	w0, [x1, #0x13]
               	strb	w0, [x1, #0x14]
               	strb	w0, [x1, #0x15]
               	strb	w0, [x1, #0x16]
               	strb	w0, [x1, #0x17]
               	strb	w0, [x1, #0x18]
               	strb	w0, [x1, #0x19]
               	strb	w0, [x1, #0x1a]
               	strb	w0, [x1, #0x1b]
               	strb	w0, [x1, #0x1c]
               	strb	w0, [x1, #0x1d]
               	strb	w0, [x1, #0x1e]
               	strb	w0, [x1, #0x1f]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x55
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<dynamic>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x28               // =40
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x3, sp
               	sub	x3, x3, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x3
               	mov	x2, #0x0                // =0
               	mov	x1, #0x7                // =7
               	mov	x0, x2
               	mul	x4, x0, x1
               	sub	x4, x4, #0x3
               	str	w4, [x3, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	ldrsw	x0, [x3, x1, lsl #2]
               	add	x2, x2, x0
               	add	x1, x1, #0x1
               	cmp	w1, #0xa
               	b.lt	<addr>
               	mov	x0, x2
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<distinct>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x10               // =16
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x41               // =65
               	strb	w2, [x0]
               	strb	w2, [x0, #0x1]
               	strb	w2, [x0, #0x2]
               	strb	w2, [x0, #0x3]
               	strb	w2, [x0, #0x4]
               	strb	w2, [x0, #0x5]
               	strb	w2, [x0, #0x6]
               	strb	w2, [x0, #0x7]
               	strb	w2, [x0, #0x8]
               	strb	w2, [x0, #0x9]
               	strb	w2, [x0, #0xa]
               	strb	w2, [x0, #0xb]
               	strb	w2, [x0, #0xc]
               	strb	w2, [x0, #0xd]
               	strb	w2, [x0, #0xe]
               	strb	w2, [x0, #0xf]
               	mov	x2, #0x42               // =66
               	strb	w2, [x1]
               	strb	w2, [x1, #0x1]
               	strb	w2, [x1, #0x2]
               	strb	w2, [x1, #0x3]
               	strb	w2, [x1, #0x4]
               	strb	w2, [x1, #0x5]
               	strb	w2, [x1, #0x6]
               	strb	w2, [x1, #0x7]
               	strb	w2, [x1, #0x8]
               	strb	w2, [x1, #0x9]
               	strb	w2, [x1, #0xa]
               	strb	w2, [x1, #0xb]
               	strb	w2, [x1, #0xc]
               	strb	w2, [x1, #0xd]
               	strb	w2, [x1, #0xe]
               	strb	w2, [x1, #0xf]
               	ldrb	w1, [x0]
               	cmp	w1, #0x41
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xf]
               	cmp	w0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<looped>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x3, #0x8                // =8
               	add	x17, x3, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x3, sp
               	sub	x3, x3, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x3
               	str	x0, [x3]
               	add	x1, x1, x0
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, x1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<inner_alloca_disturbs_outer>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x33               // =51
               	mov	x2, #0x40               // =64
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	ldrb	w2, [x20, x1]
               	cmp	w2, #0x33
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w0, #0xbe
               	b.eq	<addr>
               	mov	x0, #-0x2               // =-2
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #-0x1               // =-1
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	w0, #0x11d
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	cmp	w0, #0x4c9
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x33               // =51
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
