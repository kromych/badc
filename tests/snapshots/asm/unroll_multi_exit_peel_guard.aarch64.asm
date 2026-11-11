
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
               	mov	x0, #0x3                // =3
               	ret

<tier_span>:
               	mov	x1, #0x0                // =0
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	mov	x2, x1
               	ldr	x4, [x3, x1, lsl #3]
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.le	<addr>
               	mul	x0, x2, x0
               	ret

<walk>:
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x1, [x3]
               	mul	x1, x1, x0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x5, [x4]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	add	x0, x1, x2
               	ret
               	mov	x2, #0x1                // =1
               	ldr	x5, [x3, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x5, x5, x17
               	madd	x1, x5, x0, x1
               	ldr	x5, [x4, #0x8]
               	cmp	x5, #0x0
               	b.lt	<addr>
               	mov	x2, #0x2                // =2
               	ldr	x5, [x3, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x5, x5, x17
               	madd	x1, x5, x0, x1
               	ldr	x5, [x4, #0x10]
               	cmp	x5, #0x0
               	b.lt	<addr>
               	mov	x2, #0x3                // =3
               	ldr	x3, [x3, #0x18]
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	madd	x1, x3, x0, x1
               	ldr	x0, [x4, #0x18]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	mov	x2, #0x4                // =4
               	b	<addr>

<scan>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1]
               	cmp	x3, #0x0
               	b.ge	<addr>
               	mvn	x0, x0
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
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x23, <page>
               	ldrsw	x4, [x23, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w4
               	b.ge	<addr>
               	ldr	x5, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	csel	x6, x1, x22, lt
               	ldr	x6, [x3, x6, lsl #3]
               	madd	x2, x5, x6, x2
               	ldr	x5, [x21, x1, lsl #3]
               	cmp	x5, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w4
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x5, [x23, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w5
               	b.ge	<addr>
               	ldr	x6, [x20, x1, lsl #3]
               	mov	x7, #0x3                // =3
               	cmp	w1, #0x3
               	csel	x7, x1, x7, lt
               	ldr	x7, [x3, x7, lsl #3]
               	mul	x6, x6, x7
               	add	x2, x2, x6, lsl #1
               	ldr	x6, [x4, x1, lsl #3]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w5
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x23, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w6
               	b.ge	<addr>
               	ldr	x7, [x4, x1, lsl #3]
               	cmp	w1, #0x3
               	csel	x8, x1, x20, lt
               	ldr	x8, [x3, x8, lsl #3]
               	mul	x7, x7, x8
               	madd	x2, x7, x20, x2
               	ldr	x7, [x5, x1, lsl #3]
               	cmp	x7, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w6
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x20, #-0x2              // =-2
               	mov	x0, x20
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x21, <page>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, x20
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x20, #-0x1              // =-1
               	mov	x0, x20
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, x20
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x23, <page>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x23, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x1
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x23, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x2
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #-0x1               // =-1
               	mov	x22, #0x3               // =3
               	mov	x3, #0x4                // =4
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x22, [x20, #0x10]
               	str	x3, [x20, #0x18]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x2, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	bl	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x23, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w4
               	b.ge	<addr>
               	ldr	x5, [x20, x1, lsl #3]
               	cmp	w1, #0x3
               	csel	x6, x1, x22, lt
               	ldr	x6, [x3, x6, lsl #3]
               	madd	x2, x5, x6, x2
               	ldr	x5, [x21, x1, lsl #3]
               	cmp	x5, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w4
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x21, <page>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w6
               	b.ge	<addr>
               	ldr	x7, [x4, x1, lsl #3]
               	mov	x8, #0x3                // =3
               	cmp	w1, #0x3
               	csel	x8, x1, x8, lt
               	ldr	x8, [x3, x8, lsl #3]
               	mul	x7, x7, x8
               	add	x2, x2, x7, lsl #1
               	ldr	x7, [x5, x1, lsl #3]
               	cmp	x7, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w6
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w6
               	b.ge	<addr>
               	ldr	x7, [x4, x1, lsl #3]
               	cmp	w1, #0x3
               	csel	x8, x1, x20, lt
               	ldr	x8, [x3, x8, lsl #3]
               	mul	x7, x7, x8
               	madd	x2, x7, x20, x2
               	ldr	x7, [x5, x1, lsl #3]
               	cmp	x7, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w6
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x20, #-0x2              // =-2
               	mov	x0, x20
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, x20
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x20, #-0x1              // =-1
               	mov	x0, x20
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x21, <page>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, x20
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x21, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x1
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x22, <page>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x22, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w7
               	b.ge	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x8, x5, x2
               	ldr	x8, [x8]
               	add	x9, x4, x2
               	ldr	x9, [x9]
               	madd	x3, x8, x9, x3
               	add	x2, x6, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x2
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w7
               	b.lt	<addr>
               	cmp	x0, x3
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
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x0, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	ldrsw	x5, [x22, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w5
               	b.ge	<addr>
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x6, x4, x2
               	ldr	x6, [x6]
               	add	x7, x20, x2
               	ldr	x7, [x7]
               	madd	x3, x6, x7, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w5
               	b.lt	<addr>
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x22, <page>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x22, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w6
               	b.ge	<addr>
               	ldr	x7, [x4, x1, lsl #3]
               	mov	x8, #0x3                // =3
               	cmp	w1, #0x3
               	csel	x8, x1, x8, lt
               	ldr	x8, [x3, x8, lsl #3]
               	mul	x7, x7, x8
               	add	x2, x2, x7, lsl #1
               	ldr	x7, [x5, x1, lsl #3]
               	cmp	x7, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w6
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
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
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x1, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	ldrsw	x5, [x22, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w5
               	b.ge	<addr>
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x6, x4, x2
               	ldr	x6, [x6]
               	add	x7, x20, x2
               	ldr	x7, [x7]
               	madd	x3, x6, x7, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w5
               	b.lt	<addr>
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x1, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w1, w6
               	b.ge	<addr>
               	ldr	x7, [x4, x1, lsl #3]
               	mov	x8, #0x3                // =3
               	cmp	w1, #0x3
               	csel	x8, x1, x8, lt
               	ldr	x8, [x3, x8, lsl #3]
               	madd	x2, x7, x8, x2
               	ldr	x7, [x5, x1, lsl #3]
               	cmp	x7, #0x0
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w6
               	b.lt	<addr>
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x1, [x2]
               	str	x0, [x2, #0x8]
               	str	x3, [x2, #0x10]
               	str	x4, [x2, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	str	x1, [x2, #0x10]
               	str	x1, [x2, #0x18]
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
               	adrp	x2, <addr>
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
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
               	mvn	x3, x3
               	b	<addr>
