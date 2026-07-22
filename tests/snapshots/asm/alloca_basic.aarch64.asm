
alloca_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2f0              // =752
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x2, #0x20               // =32
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	mov	sp, x20
               	mov	x1, #0x55               // =85
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x20, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x55              // =85
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	b	<addr>

<dynamic>:
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x5, x0
               	sxtw	x5, w5
               	lsl	x0, x5, #2
               	sxtw	x0, w0
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	mov	sp, x2
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	mov	x17, #0x7               // =7
               	mul	x4, x1, x17
               	sub	x4, x4, #0x3
               	str	w4, [x2, x1, lsl #2]
               	add	x3, x1, #0x1
               	sxtw	x1, w3
               	cmp	x1, x5
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrsw	x4, [x2, x3, lsl #2]
               	add	x0, x0, x4
               	add	x1, x3, #0x1
               	sxtw	x3, w1
               	cmp	x3, x5
               	b.lt	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret

<distinct>:
               	stp	x20, x21, [sp, #-0x80]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x0, #0x10               // =16
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	mov	sp, x20
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x21, sp
               	sub	x21, x21, x17
               	mov	sp, x21
               	cmp	x20, x21
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x70
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x41               // =65
               	mov	x22, #0x10              // =16
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	mov	x1, #0x42               // =66
               	mov	x0, x21
               	mov	x2, x22
               	bl	<addr>
               	ldrb	w0, [x20]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0xf]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x70
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	ldrb	w0, [x21]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x21, #0xf]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x70
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x70
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	b	<addr>
               	b	<addr>

<looped>:
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x4, x0
               	sxtw	x4, w4
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	mov	x3, #0x8                // =8
               	add	x17, x3, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x3, sp
               	sub	x3, x3, x17
               	mov	sp, x3
               	str	x1, [x3]
               	add	x2, x2, x1
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, x4
               	b.lt	<addr>
               	sxtw	x0, w2
               	sxtw	x0, w0
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret

<inner_alloca_disturbs_outer>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, x0
               	sxtw	x20, w20
               	mov	x2, #0x40               // =64
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x21, sp
               	sub	x21, x21, x17
               	mov	sp, x21
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x4, x0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x21, x1
               	ldrb	w2, [x2]
               	mov	x17, #0xff              // =255
               	and	x3, x20, x17
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	sxtw	x0, w4
               	cmp	x0, #0xbe
               	b.eq	<addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
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
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
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
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x33               // =51
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
