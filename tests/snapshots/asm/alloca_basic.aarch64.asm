
alloca_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2f0              // =752
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x2, #0x20               // =32
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x55               // =85
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	b	<addr>

<dynamic>:
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	stur	w0, [x29, #0x10]
               	ldursw	x0, [x29, #0x10]
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldur	x2, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x7               // =7
               	mul	x1, x0, x17
               	sub	x1, x1, #0x3
               	str	w1, [x2, x0, lsl #2]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x2, [x29, #-0x18]
               	ldur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x10]
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x0, x2, x0
               	stur	w0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x18]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	add	sp, sp, #0x10
               	ret

<distinct>:
               	str	x20, [sp, #-0x70]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x10               // =16
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	mov	sp, x1
               	stur	x1, [x29, #-0x8]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x41               // =65
               	mov	x20, #0x10              // =16
               	mov	x2, x20
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x42               // =66
               	mov	x2, x20
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldrb	w0, [x0]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x38]
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x40]
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x40]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret

<looped>:
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	stur	w0, [x29, #0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	mov	x0, #0x8                // =8
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	ldursw	x1, [x29, #-0x10]
               	str	x1, [x0]
               	ldursw	x1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x18]
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x8]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	add	sp, sp, #0x10
               	ret

<inner_alloca_disturbs_outer>:
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	stur	w0, [x29, #0x10]
               	mov	x2, #0x40               // =64
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #0x10]
               	bl	<addr>
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	ldursw	x1, [x29, #0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	x0, x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x40
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0xbe
               	b.eq	<addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0x10
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
