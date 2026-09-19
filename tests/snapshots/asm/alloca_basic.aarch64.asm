
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
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x2, #0x20               // =32
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
               	mov	x1, #0x55               // =85
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x55               // =85
               	ldrb	w2, [x20, x0]
               	eor	x2, x2, x1
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<dynamic>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x28               // =40
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	mov	x1, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x0, x1
               	mul	x4, x0, x3
               	sub	x4, x4, #0x3
               	str	w4, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldrsw	x3, [x2, x0, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	sxtw	x0, w1
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<distinct>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x10               // =16
               	add	x17, x0, #0xf
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
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x21, sp
               	sub	x21, x21, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x21
               	cmp	x20, x21
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x41               // =65
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x42               // =66
               	mov	x2, #0x10               // =16
               	mov	x0, x21
               	bl	<addr>
               	ldrb	w0, [x20]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x20, #0xf]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrb	w0, [x21]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x21, #0xf]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
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
               	sxtw	x0, w1
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
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
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x20, x0]
               	cmp	w1, #0x33
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	cmp	w2, #0xbe
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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x11d
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	cmp	x0, #0x4c9
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x33               // =51
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
