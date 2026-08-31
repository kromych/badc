
unroll_multi_exit_peel_guard.aarch64:	file format elf64-littleaarch64

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

<tier_idx>:
               	mov	x1, #0x0                // =0
               	mov	x0, #0x1                // =1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x1
               	mov	x3, x1
               	mov	x2, x1
               	cmp	w0, #0x0
               	b.gt	<addr>
               	sxtw	x2, w0
               	ldr	x5, [x4, x2, lsl #3]
               	add	x3, x3, x5
               	add	x0, x2, #0x1
               	b	<addr>
               	lsl	x6, x3, #1
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	mov	x1, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, x0
               	mov	x3, x0
               	cmp	w1, #0x1
               	b.gt	<addr>
               	sxtw	x3, w1
               	ldr	x5, [x4, x3, lsl #3]
               	add	x2, x2, x5
               	add	x1, x3, #0x1
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	cmp	x1, x6
               	b.gt	<addr>
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x2                // =2
               	mov	x2, #0x0                // =0
               	mov	x1, #0x1                // =1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, x0
               	mov	x3, x0
               	cmp	w1, #0x2
               	b.gt	<addr>
               	sxtw	x3, w1
               	ldr	x5, [x4, x3, lsl #3]
               	add	x2, x2, x5
               	add	x1, x3, #0x1
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	cmp	x1, x6
               	b.gt	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	mov	x2, #0x0                // =0
               	mov	x1, #0x1                // =1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, x0
               	mov	x3, x0
               	cmp	w1, #0x3
               	b.gt	<addr>
               	sxtw	x3, w1
               	ldr	x5, [x4, x3, lsl #3]
               	add	x2, x2, x5
               	add	x1, x3, #0x1
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	cmp	x1, x6
               	b.gt	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>

<tier_span>:
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, x0
               	mov	x1, #0x3                // =3
               	cmp	w0, #0x3
               	b.gt	<addr>
               	sxtw	x1, w0
               	ldr	x4, [x3, x1, lsl #3]
               	add	x2, x2, x4
               	add	x0, x1, #0x1
               	b	<addr>
               	mul	x0, x2, x5
               	ret

<walk>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x0
               	ldr	x1, [x1]
               	mov	x4, x0
               	lsr	x1, x1, #0
               	mul	x1, x1, x2
               	add	x1, x1, #0x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, #0x0
               	ldr	x3, [x3]
               	cmp	x3, #0x0
               	b.ge	<addr>
               	sxtw	x0, w0
               	add	x0, x1, x0
               	ret
               	mov	x0, #0x1                // =1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, #0x8]
               	mov	x5, x0
               	mov	x4, #0xa                // =10
               	mul	x3, x3, x4
               	madd	x1, x3, x2, x1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, #0x8]
               	cmp	x3, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, #0x10]
               	mov	x5, x0
               	mov	x4, #0x64               // =100
               	mul	x3, x3, x4
               	madd	x1, x3, x2, x1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, #0x10]
               	cmp	x3, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, #0x18]
               	mov	x5, x0
               	mov	x4, #0x3e8              // =1000
               	mul	x3, x3, x4
               	madd	x1, x3, x2, x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>

<scan>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x0
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	sub	x0, x0, #0x1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldr	x0, [x0]
               	lsr	x0, x0, #0
               	add	x0, x0, #0x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x0
               	ldr	x2, [x2]
               	cmp	x2, x1
               	b.ge	<addr>
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x8]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x8]
               	cmp	x2, x1
               	b.ge	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x10]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x10]
               	cmp	x2, x1
               	b.ge	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x18]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x18]
               	cmp	x2, x1
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x22, #0x3               // =3
               	mov	x2, #0x4                // =4
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x22, [x20, #0x10]
               	str	x2, [x20, #0x18]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x0, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsr	x4, x4, #0
               	add	x2, x2, x4
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsl	x4, x4, #1
               	add	x2, x2, x4
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.ne	<addr>
               	mov	x22, #0x3               // =3
               	mov	x0, x22
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	madd	x2, x4, x22, x2
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.ne	<addr>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x22
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x22
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x1
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x2
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x22, #0x3               // =3
               	mov	x3, #0x4                // =4
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x22, [x20, #0x10]
               	str	x3, [x20, #0x18]
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x2, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsr	x4, x4, #0
               	add	x2, x2, x4
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsl	x4, x4, #1
               	add	x2, x2, x4
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.ne	<addr>
               	mov	x22, #0x3               // =3
               	mov	x0, x22
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	madd	x2, x4, x22, x2
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.ne	<addr>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x22
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x22
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x1
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x2
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x22, #0x3               // =3
               	mov	x2, #0x4                // =4
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x22, [x20, #0x10]
               	str	x2, [x20, #0x18]
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x0, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsl	x4, x4, #1
               	add	x2, x2, x4
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x0, #0x2                // =2
               	mov	x22, #0x3               // =3
               	mov	x2, #0x4                // =4
               	str	x1, [x20]
               	str	x0, [x20, #0x8]
               	str	x22, [x20, #0x10]
               	str	x2, [x20, #0x18]
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x1, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x8, x0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x4, x6, x2
               	ldr	x4, [x4]
               	add	x5, x20, x2
               	ldr	x5, [x5]
               	madd	x3, x4, x5, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x7]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsr	x4, x4, #0
               	add	x2, x2, x4
               	ldr	x4, [x21, x1, lsl #3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x1, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x22, #0x3               // =3
               	mov	x2, #0x4                // =4
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x22, [x20, #0x10]
               	str	x2, [x20, #0x18]
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x0, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x21c6            // =8646
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x17, #0x10e1            // =4321
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, x0
               	mov	x1, x22
               	cmp	w0, #0x3
               	b.gt	<addr>
               	sxtw	x1, w0
               	ldr	x4, [x3, x1, lsl #3]
               	add	x2, x2, x4
               	add	x0, x1, #0x1
               	b	<addr>
               	lsl	x0, x2, #1
               	cmp	x0, #0x8ae
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x3, x17
               	sub	x3, x0, #0x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
