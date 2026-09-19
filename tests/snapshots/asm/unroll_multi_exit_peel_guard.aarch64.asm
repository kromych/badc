
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
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	cmp	w0, #0x0
               	b.gt	<addr>
               	sxtw	x3, w0
               	ldr	x3, [x2, x3, lsl #3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.le	<addr>
               	lsl	x6, x1, #1
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x1
               	cmp	w0, #0x1
               	b.gt	<addr>
               	sxtw	x4, w0
               	ldr	x4, [x3, x4, lsl #3]
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.le	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x2, x17
               	cmp	x0, x6
               	b.gt	<addr>
               	sub	x0, x1, #0x1
               	sxtw	x0, w0
               	ret
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x1
               	cmp	w0, #0x2
               	b.gt	<addr>
               	sxtw	x4, w0
               	ldr	x4, [x3, x4, lsl #3]
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.le	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x2, x17
               	cmp	x0, x6
               	b.le	<addr>
               	mov	x1, #0x3                // =3
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x1
               	cmp	w0, #0x3
               	b.gt	<addr>
               	sxtw	x4, w0
               	ldr	x4, [x3, x4, lsl #3]
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x2, x17
               	cmp	x0, x6
               	b.le	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>

<tier_span>:
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	cmp	w0, #0x3
               	b.gt	<addr>
               	sxtw	x3, w0
               	ldr	x3, [x2, x3, lsl #3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	mul	x0, x1, x5
               	ret

<walk>:
               	mov	x1, x0
               	mov	x4, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x0, x2, #0x0
               	ldr	x0, [x0]
               	lsr	x0, x0, #0
               	mul	x0, x0, x1
               	add	x0, x0, #0x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x6, x3, #0x0
               	ldr	x6, [x6]
               	cmp	x6, #0x0
               	b.ge	<addr>
               	sxtw	x1, w4
               	add	x0, x0, x1
               	ret
               	mov	x4, #0x1                // =1
               	ldr	x6, [x2, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x6, x6, x17
               	madd	x0, x6, x1, x0
               	ldr	x6, [x3, #0x8]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	mov	x4, #0x2                // =2
               	ldr	x6, [x2, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x6, x6, x17
               	madd	x0, x6, x1, x0
               	ldr	x6, [x3, #0x10]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	mov	x4, #0x3                // =3
               	ldr	x2, [x2, #0x18]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	madd	x0, x2, x1, x0
               	ldr	x1, [x3, #0x18]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	mov	x4, #0x4                // =4
               	b	<addr>

<scan>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x3, x1, #0x0
               	ldr	x4, [x3]
               	cmp	x4, #0x0
               	b.ge	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x0, x17
               	sub	x0, x0, #0x1
               	ret
               	ldr	x0, [x3]
               	lsr	x0, x0, #0
               	add	x0, x0, #0x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, #0x0
               	ldr	x3, [x3]
               	cmp	x3, x2
               	b.ge	<addr>
               	ret
               	ldr	x3, [x1, #0x8]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	add	x0, x0, x3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, #0x8]
               	cmp	x3, x2
               	b.lt	<addr>
               	ldr	x3, [x1, #0x10]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	ldr	x3, [x1, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	add	x0, x0, x3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, #0x10]
               	cmp	x3, x2
               	b.lt	<addr>
               	ldr	x3, [x1, #0x18]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	ldr	x1, [x1, #0x18]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x18]
               	cmp	x1, x2
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsr	x4, x4, #0
               	add	x2, x2, x4
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsl	x4, x4, #1
               	add	x2, x2, x4
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	madd	x2, x4, x22, x2
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.ne	<addr>
               	mov	x22, #-0x2              // =-2
               	mov	x0, x22
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, x22
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x22, #-0x1              // =-1
               	mov	x0, x22
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, x22
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x1
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x2
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #-0x1               // =-1
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsr	x4, x4, #0
               	add	x2, x2, x4
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsl	x4, x4, #1
               	add	x2, x2, x4
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	madd	x2, x4, x22, x2
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x8, x0
               	b.ne	<addr>
               	mov	x22, #-0x2              // =-2
               	mov	x0, x22
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, x22
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x22, #-0x1              // =-1
               	mov	x0, x22
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, x22
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x1
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x2
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #-0x2               // =-2
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
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsl	x4, x4, #1
               	add	x2, x2, x4
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
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
               	mov	x1, #-0x1               // =-1
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
               	mov	x7, x0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x20, x1, lsl #3]
               	cmp	x3, #0x0
               	b.lt	<addr>
               	lsl	x1, x1, #3
               	add	x3, x5, x1
               	ldr	x3, [x3]
               	add	x4, x20, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x21, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x6]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x7, x2
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
               	ldrsw	x1, [x5]
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldr	x6, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	b.ge	<addr>
               	mov	x4, x1
               	ldr	x4, [x3, x4, lsl #3]
               	mul	x4, x6, x4
               	lsr	x4, x4, #0
               	add	x2, x2, x4
               	ldr	x1, [x21, x1, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x22
               	b	<addr>
               	add	x0, x0, #0x1
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
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x2, [x20, #0x10]
               	str	x3, [x20, #0x18]
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
               	mov	x0, #-0x2               // =-2
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	cmp	w0, #0x3
               	b.gt	<addr>
               	sxtw	x3, w0
               	ldr	x3, [x2, x3, lsl #3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	lsl	x0, x1, #1
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
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x2, x0, #0x1
               	b	<addr>
