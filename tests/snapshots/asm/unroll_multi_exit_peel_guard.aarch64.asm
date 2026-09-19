
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
               	mov	x1, x0
               	add	x1, x1, #0x1
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x0
               	b.le	<addr>
               	lsl	x3, x1, #1
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	mov	x2, x0
               	add	x1, x1, #0xa
               	mov	x2, #0x2                // =2
               	cmp	w2, #0x1
               	b.le	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	cmp	x1, x3
               	b.gt	<addr>
               	sub	x0, x0, #0x1
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x0                // =0
               	mov	x2, x0
               	add	x1, x1, #0x64
               	mov	x2, #0x3                // =3
               	cmp	w2, #0x2
               	b.le	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	cmp	x1, x3
               	b.le	<addr>
               	mov	x0, #0x3                // =3
               	mov	x1, #0x0                // =0
               	mov	x2, x0
               	add	x1, x1, #0x3e8
               	mov	x2, #0x4                // =4
               	cmp	w2, #0x3
               	b.le	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	cmp	x1, x3
               	b.le	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>

<tier_span>:
               	mov	x4, x0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	ldr	x3, [x2, x0, lsl #3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	mul	x0, x1, x4
               	ret

<walk>:
               	mov	x2, x0
               	mov	x1, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x0, [x3]
               	mul	x0, x0, x2
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x5, [x4]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	add	x0, x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	ldr	x5, [x3, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x5, x5, x17
               	madd	x0, x5, x2, x0
               	ldr	x5, [x4, #0x8]
               	cmp	x5, #0x0
               	b.lt	<addr>
               	mov	x1, #0x2                // =2
               	ldr	x5, [x3, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x5, x5, x17
               	madd	x0, x5, x2, x0
               	ldr	x5, [x4, #0x10]
               	cmp	x5, #0x0
               	b.lt	<addr>
               	mov	x1, #0x3                // =3
               	ldr	x3, [x3, #0x18]
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	madd	x0, x3, x2, x0
               	ldr	x2, [x4, #0x18]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>

<scan>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1]
               	cmp	x3, #0x0
               	b.ge	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x0, x0, x17
               	sub	x0, x0, #0x1
               	ret
               	ldr	x0, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	cmp	x4, x2
               	b.ge	<addr>
               	ret
               	ldr	x4, [x1, #0x8]
               	cmp	x4, #0x0
               	b.lt	<addr>
               	ldr	x4, [x1, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x4, x4, x17
               	add	x0, x0, x4
               	ldr	x4, [x3, #0x8]
               	cmp	x4, x2
               	b.lt	<addr>
               	ldr	x4, [x1, #0x10]
               	cmp	x4, #0x0
               	b.lt	<addr>
               	ldr	x4, [x1, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x4, x4, x17
               	add	x0, x0, x4
               	ldr	x4, [x3, #0x10]
               	cmp	x4, x2
               	b.lt	<addr>
               	ldr	x4, [x1, #0x18]
               	cmp	x4, #0x0
               	b.lt	<addr>
               	ldr	x1, [x1, #0x18]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x3, #0x18]
               	cmp	x1, x2
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x23, #0x3               // =3
               	mov	x2, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x0, [x21]
               	str	x1, [x21, #0x8]
               	str	x23, [x21, #0x10]
               	str	x2, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	str	x0, [x22, #0x8]
               	str	x0, [x22, #0x10]
               	str	x0, [x22, #0x18]
               	bl	<addr>
               	mov	x5, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldr	x3, [x21, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x4, x0
               	ldr	x4, [x2, x4, lsl #3]
               	madd	x1, x3, x4, x1
               	ldr	x3, [x22, x0, lsl #3]
               	cmp	x3, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x23
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x6, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x2, [x20]
               	cmp	w0, w2
               	b.ge	<addr>
               	ldr	x5, [x21, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x2, x0
               	ldr	x2, [x3, x2, lsl #3]
               	mul	x2, x5, x2
               	lsl	x2, x2, #1
               	add	x1, x1, x2
               	ldr	x2, [x4, x0, lsl #3]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x2, [x20]
               	cmp	w0, w2
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x6, x0
               	b.ne	<addr>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	bl	<addr>
               	mov	x7, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x5, [x20]
               	cmp	w0, w5
               	b.ge	<addr>
               	ldr	x5, [x3, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x6, x0
               	ldr	x6, [x2, x6, lsl #3]
               	mul	x5, x5, x6
               	madd	x1, x5, x21, x1
               	ldr	x5, [x4, x0, lsl #3]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x6, x21
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x5, [x20]
               	cmp	w0, w5
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x7, x0
               	b.ne	<addr>
               	mov	x21, #-0x2              // =-2
               	mov	x0, x21
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, x21
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #-0x1              // =-1
               	mov	x0, x21
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, x21
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x1
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x2
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #-0x1               // =-1
               	mov	x23, #0x3               // =3
               	mov	x3, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x0, [x21]
               	str	x1, [x21, #0x8]
               	str	x23, [x21, #0x10]
               	str	x3, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	str	x0, [x22, #0x8]
               	str	x2, [x22, #0x10]
               	str	x0, [x22, #0x18]
               	bl	<addr>
               	mov	x5, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldr	x3, [x21, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x4, x0
               	ldr	x4, [x2, x4, lsl #3]
               	madd	x1, x3, x4, x1
               	ldr	x3, [x22, x0, lsl #3]
               	cmp	x3, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x4, x23
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x7, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x2, [x20]
               	cmp	w0, w2
               	b.ge	<addr>
               	ldr	x6, [x4, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x2, x0
               	ldr	x2, [x3, x2, lsl #3]
               	mul	x2, x6, x2
               	lsl	x2, x2, #1
               	add	x1, x1, x2
               	ldr	x2, [x5, x0, lsl #3]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x2, [x20]
               	cmp	w0, w2
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x7, x0
               	b.ne	<addr>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	bl	<addr>
               	mov	x7, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x5, [x20]
               	cmp	w0, w5
               	b.ge	<addr>
               	ldr	x5, [x3, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x6, x0
               	ldr	x6, [x2, x6, lsl #3]
               	mul	x5, x5, x6
               	madd	x1, x5, x21, x1
               	ldr	x5, [x4, x0, lsl #3]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x6, x21
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x5, [x20]
               	cmp	w0, w5
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x7, x0
               	b.ne	<addr>
               	mov	x21, #-0x2              // =-2
               	mov	x0, x21
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, x21
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #-0x1              // =-1
               	mov	x0, x21
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, x21
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x1
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x8, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x6, x4, x1
               	ldr	x6, [x6]
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	madd	x2, x6, x7, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x2
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x8, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #-0x2               // =-2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x2, [x20, #0x10]
               	str	x3, [x20, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	str	x0, [x22, #0x8]
               	str	x0, [x22, #0x10]
               	str	x0, [x22, #0x18]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x6, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x20, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x4, x3, x1
               	ldr	x4, [x4]
               	add	x5, x20, x1
               	ldr	x5, [x5]
               	madd	x2, x4, x5, x2
               	add	x1, x22, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x6, x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x7, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x2, [x21]
               	cmp	w0, w2
               	b.ge	<addr>
               	ldr	x6, [x4, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x2, x0
               	ldr	x2, [x3, x2, lsl #3]
               	mul	x2, x6, x2
               	lsl	x2, x2, #1
               	add	x1, x1, x2
               	ldr	x2, [x5, x0, lsl #3]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x2, [x21]
               	cmp	w0, w2
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x7, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #-0x1               // =-1
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	x1, [x20]
               	str	x0, [x20, #0x8]
               	str	x2, [x20, #0x10]
               	str	x3, [x20, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	str	x0, [x22, #0x8]
               	str	x1, [x22, #0x10]
               	str	x0, [x22, #0x18]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x6, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x20, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x4, x3, x1
               	ldr	x4, [x4]
               	add	x5, x20, x1
               	ldr	x5, [x5]
               	madd	x2, x4, x5, x2
               	add	x1, x22, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x6, x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x8, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x2, [x4]
               	cmp	w0, w2
               	b.ge	<addr>
               	ldr	x7, [x5, x0, lsl #3]
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mov	x2, x0
               	ldr	x2, [x3, x2, lsl #3]
               	madd	x1, x7, x2, x1
               	ldr	x2, [x6, x0, lsl #3]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x2, [x4]
               	cmp	w0, w2
               	b.lt	<addr>
               	add	x0, x1, x0
               	cmp	x8, x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	str	x3, [x1, #0x10]
               	str	x4, [x1, #0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	mov	x0, x2
               	bl	<addr>
               	mov	x17, #0x21c6            // =8646
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #-0x2               // =-2
               	bl	<addr>
               	mov	x17, #0x10e1            // =4321
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	ldr	x3, [x2, x0, lsl #3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	lsl	x0, x1, #1
               	cmp	x0, #0x8ae
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
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
