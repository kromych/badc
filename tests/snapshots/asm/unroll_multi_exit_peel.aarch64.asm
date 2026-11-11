
unroll_multi_exit_peel.aarch64:	file format elf64-littleaarch64

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

<scan_peeled>:
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x1, [x3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	mov	x1, x2
               	neg	x0, x1
               	sub	x0, x0, x2
               	sub	x0, x0, #0x1
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x4]
               	ldr	x5, [x3]
               	mul	x1, x1, x5
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x6, [x5]
               	cmp	x6, x0
               	b.ge	<addr>
               	add	x0, x2, x1, lsl #3
               	ret
               	mov	x2, #0x1                // =1
               	ldr	x6, [x3, #0x8]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	ldr	x6, [x4, #0x8]
               	ldr	x7, [x3, #0x8]
               	madd	x1, x6, x7, x1
               	ldr	x6, [x5, #0x8]
               	cmp	x6, x0
               	b.lt	<addr>
               	mov	x2, #0x2                // =2
               	ldr	x6, [x3, #0x10]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	ldr	x6, [x4, #0x10]
               	ldr	x7, [x3, #0x10]
               	madd	x1, x6, x7, x1
               	ldr	x6, [x5, #0x10]
               	cmp	x6, x0
               	b.lt	<addr>
               	mov	x2, #0x3                // =3
               	ldr	x6, [x3, #0x18]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	ldr	x4, [x4, #0x18]
               	ldr	x3, [x3, #0x18]
               	madd	x1, x4, x3, x1
               	ldr	x3, [x5, #0x18]
               	cmp	x3, x0
               	b.lt	<addr>
               	mov	x2, #0x4                // =4
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x1                // =1
               	mov	x6, #0x2                // =2
               	mov	x7, #0x3                // =3
               	mov	x5, #0x4                // =4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	str	x6, [x1, #0x8]
               	str	x7, [x1, #0x10]
               	str	x5, [x1, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	mov	x3, #0xa                // =10
               	str	x3, [x2, #0x8]
               	mov	x3, #0x64               // =100
               	str	x3, [x2, #0x10]
               	mov	x3, #0x3e8              // =1000
               	str	x3, [x2, #0x18]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x0, [x4]
               	str	x0, [x4, #0x8]
               	str	x0, [x4, #0x10]
               	str	x0, [x4, #0x18]
               	ldr	x3, [x1]
               	ldr	x8, [x2]
               	mul	x3, x3, x8
               	lsl	x3, x3, #1
               	ldr	x8, [x1, #0x8]
               	ldr	x9, [x2, #0x8]
               	mul	x8, x8, x9
               	add	x3, x3, x8, lsl #1
               	ldr	x8, [x4, #0x8]
               	cmp	x8, #0x0
               	b.ge	<addr>
               	mov	x5, x0
               	add	x1, x5, x3, lsl #3
               	mov	x17, #0xe14             // =3604
               	movk	x17, #0x1, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #-0x2               // =-2
               	bl	<addr>
               	mov	x17, #0x870c            // =34572
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x2, #0x1                // =1
               	mov	x7, #0x2                // =2
               	mov	x8, #0x3                // =3
               	mov	x6, #0x4                // =4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x2, [x3]
               	str	x7, [x3, #0x8]
               	str	x8, [x3, #0x10]
               	str	x6, [x3, #0x18]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x2, [x4]
               	mov	x0, #0xa                // =10
               	str	x0, [x4, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x4, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x4, #0x18]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x2, [x5]
               	str	x2, [x5, #0x8]
               	str	x2, [x5, #0x10]
               	str	x2, [x5, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x1, [x3]
               	ldr	x9, [x4]
               	ldr	x10, [x3, #0x8]
               	ldr	x11, [x4, #0x8]
               	mul	x10, x10, x11
               	madd	x1, x1, x9, x10
               	ldr	x9, [x5, #0x8]
               	cmp	x9, #0x0
               	b.ge	<addr>
               	mov	x6, x2
               	add	x9, x6, x1, lsl #3
               	adrp	x1, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x1, #0x18]
               	mov	x2, x0
               	cmp	w0, w6
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	madd	x2, x7, x8, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w6
               	b.lt	<addr>
               	add	x0, x0, x2, lsl #3
               	cmp	x9, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x5, #0x1                // =1
               	mov	x7, #0x2                // =2
               	mov	x0, #-0x1               // =-1
               	mov	x8, #0x3                // =3
               	mov	x6, #0x4                // =4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x5, [x3]
               	str	x7, [x3, #0x8]
               	str	x8, [x3, #0x10]
               	str	x6, [x3, #0x18]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x5, [x4]
               	mov	x1, #0xa                // =10
               	str	x1, [x4, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x4, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x4, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x5, [x2]
               	str	x5, [x2, #0x8]
               	str	x0, [x2, #0x10]
               	str	x5, [x2, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x1, [x3]
               	ldr	x9, [x4]
               	ldr	x10, [x3, #0x8]
               	ldr	x11, [x4, #0x8]
               	mul	x10, x10, x11
               	madd	x1, x1, x9, x10
               	ldr	x9, [x2, #0x8]
               	cmp	x9, #0x0
               	b.ge	<addr>
               	mov	x6, x5
               	add	x9, x6, x1, lsl #3
               	adrp	x1, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x1, #0x18]
               	mov	x2, x0
               	cmp	w0, w6
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	madd	x2, x7, x8, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w6
               	b.lt	<addr>
               	add	x0, x0, x2, lsl #3
               	cmp	x9, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #-0x1               // =-1
               	mov	x7, #0x2                // =2
               	mov	x5, #0x1                // =1
               	mov	x8, #0x3                // =3
               	mov	x6, #0x4                // =4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x0, [x3]
               	str	x7, [x3, #0x8]
               	str	x8, [x3, #0x10]
               	str	x6, [x3, #0x18]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x5, [x4]
               	mov	x0, #0xa                // =10
               	str	x0, [x4, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x4, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x4, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x5, [x2]
               	str	x5, [x2, #0x8]
               	str	x5, [x2, #0x10]
               	str	x5, [x2, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x1, [x3]
               	ldr	x9, [x4]
               	ldr	x10, [x3, #0x8]
               	ldr	x11, [x4, #0x8]
               	mul	x10, x10, x11
               	madd	x1, x1, x9, x10
               	ldr	x9, [x2, #0x8]
               	cmp	x9, #0x0
               	b.ge	<addr>
               	mov	x6, x5
               	add	x9, x6, x1, lsl #3
               	adrp	x1, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x1, #0x18]
               	mov	x2, x0
               	cmp	w0, w6
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	madd	x2, x7, x8, x2
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w6
               	b.lt	<addr>
               	add	x0, x0, x2, lsl #3
               	cmp	x9, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x2, #0x1                // =1
               	mov	x7, #0x2                // =2
               	mov	x8, #0x3                // =3
               	mov	x6, #0x4                // =4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x2, [x3]
               	str	x7, [x3, #0x8]
               	str	x8, [x3, #0x10]
               	str	x6, [x3, #0x18]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x2, [x4]
               	mov	x0, #0xa                // =10
               	str	x0, [x4, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x4, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x4, #0x18]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x2, [x5]
               	str	x2, [x5, #0x8]
               	str	x2, [x5, #0x10]
               	str	x2, [x5, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x1, [x3]
               	ldr	x9, [x4]
               	mul	x1, x1, x9
               	lsl	x1, x1, #1
               	ldr	x9, [x3, #0x8]
               	ldr	x10, [x4, #0x8]
               	mul	x9, x9, x10
               	add	x1, x1, x9, lsl #1
               	ldr	x9, [x5, #0x8]
               	cmp	x9, #0x0
               	b.ge	<addr>
               	mov	x6, x2
               	add	x9, x6, x1, lsl #3
               	adrp	x1, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x1, #0x18]
               	mov	x2, x0
               	cmp	w0, w6
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	mul	x7, x7, x8
               	add	x2, x2, x7, lsl #1
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w6
               	b.lt	<addr>
               	add	x0, x0, x2, lsl #3
               	cmp	x9, x0
               	b.ne	<addr>
               	mov	x5, #0x1                // =1
               	mov	x7, #0x2                // =2
               	mov	x0, #-0x1               // =-1
               	mov	x8, #0x3                // =3
               	mov	x6, #0x4                // =4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x5, [x3]
               	str	x7, [x3, #0x8]
               	str	x8, [x3, #0x10]
               	str	x6, [x3, #0x18]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x5, [x4]
               	mov	x1, #0xa                // =10
               	str	x1, [x4, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x4, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x4, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x5, [x2]
               	str	x5, [x2, #0x8]
               	str	x0, [x2, #0x10]
               	str	x5, [x2, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x1, [x3]
               	ldr	x9, [x4]
               	mul	x1, x1, x9
               	lsl	x1, x1, #1
               	ldr	x9, [x3, #0x8]
               	ldr	x10, [x4, #0x8]
               	mul	x9, x9, x10
               	add	x1, x1, x9, lsl #1
               	ldr	x9, [x2, #0x8]
               	cmp	x9, #0x0
               	b.ge	<addr>
               	mov	x6, x5
               	add	x9, x6, x1, lsl #3
               	adrp	x1, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x1, #0x18]
               	mov	x2, x0
               	cmp	w0, w6
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	mul	x7, x7, x8
               	add	x2, x2, x7, lsl #1
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w6
               	b.lt	<addr>
               	add	x0, x0, x2, lsl #3
               	cmp	x9, x0
               	b.ne	<addr>
               	mov	x0, #-0x1               // =-1
               	mov	x7, #0x2                // =2
               	mov	x5, #0x1                // =1
               	mov	x8, #0x3                // =3
               	mov	x6, #0x4                // =4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x0, [x3]
               	str	x7, [x3, #0x8]
               	str	x8, [x3, #0x10]
               	str	x6, [x3, #0x18]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x5, [x4]
               	mov	x0, #0xa                // =10
               	str	x0, [x4, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x4, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x4, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x5, [x2]
               	str	x5, [x2, #0x8]
               	str	x5, [x2, #0x10]
               	str	x5, [x2, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x1, [x3]
               	ldr	x9, [x4]
               	mul	x1, x1, x9
               	lsl	x1, x1, #1
               	ldr	x9, [x3, #0x8]
               	ldr	x10, [x4, #0x8]
               	mul	x9, x9, x10
               	add	x1, x1, x9, lsl #1
               	ldr	x9, [x2, #0x8]
               	cmp	x9, #0x0
               	b.ge	<addr>
               	mov	x6, x5
               	add	x9, x6, x1, lsl #3
               	adrp	x1, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x1, #0x18]
               	mov	x2, x0
               	cmp	w0, w6
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x7, x3, x1
               	ldr	x7, [x7]
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	mul	x7, x7, x8
               	add	x2, x2, x7, lsl #1
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w6
               	b.lt	<addr>
               	add	x0, x0, x2, lsl #3
               	cmp	x9, x0
               	b.ne	<addr>
               	mov	x1, #0x3                // =3
               	mov	x5, #0x1                // =1
               	mov	x8, #0x2                // =2
               	mov	x7, #0x4                // =4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x5, [x4]
               	str	x8, [x4, #0x8]
               	str	x1, [x4, #0x10]
               	str	x7, [x4, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x5, [x2]
               	mov	x0, #0xa                // =10
               	str	x0, [x2, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x2, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x2, #0x18]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x5, [x6]
               	str	x5, [x6, #0x8]
               	str	x5, [x6, #0x10]
               	str	x5, [x6, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x3, [x4]
               	ldr	x9, [x2]
               	mul	x3, x3, x9
               	ldr	x9, [x4, #0x8]
               	ldr	x10, [x2, #0x8]
               	mul	x9, x9, x10
               	mul	x9, x9, x1
               	madd	x3, x3, x1, x9
               	ldr	x9, [x6, #0x8]
               	cmp	x9, #0x0
               	b.ge	<addr>
               	mov	x7, x5
               	add	x10, x7, x3, lsl #3
               	adrp	x2, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x2, #0x18]
               	mov	x3, x0
               	cmp	w0, w7
               	b.ge	<addr>
               	lsl	x2, x0, #3
               	add	x8, x4, x2
               	ldr	x8, [x8]
               	add	x9, x6, x2
               	ldr	x9, [x9]
               	mul	x8, x8, x9
               	madd	x3, x8, x1, x3
               	add	x2, x5, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w7
               	b.lt	<addr>
               	add	x0, x0, x3, lsl #3
               	cmp	x10, x0
               	b.ne	<addr>
               	mov	x6, #0x1                // =1
               	mov	x8, #0x2                // =2
               	mov	x0, #-0x1               // =-1
               	mov	x9, #0x3                // =3
               	mov	x7, #0x4                // =4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x6, [x4]
               	str	x8, [x4, #0x8]
               	str	x9, [x4, #0x10]
               	str	x7, [x4, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x6, [x2]
               	mov	x3, #0xa                // =10
               	str	x3, [x2, #0x8]
               	mov	x3, #0x64               // =100
               	str	x3, [x2, #0x10]
               	mov	x3, #0x3e8              // =1000
               	str	x3, [x2, #0x18]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x6, [x5]
               	str	x6, [x5, #0x8]
               	str	x0, [x5, #0x10]
               	str	x6, [x5, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x3, [x4]
               	ldr	x10, [x2]
               	mul	x3, x3, x10
               	ldr	x10, [x4, #0x8]
               	ldr	x11, [x2, #0x8]
               	mul	x10, x10, x11
               	mul	x10, x10, x1
               	madd	x3, x3, x1, x10
               	ldr	x10, [x5, #0x8]
               	cmp	x10, #0x0
               	b.ge	<addr>
               	mov	x7, x6
               	add	x10, x7, x3, lsl #3
               	adrp	x2, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x2, #0x18]
               	mov	x3, x0
               	cmp	w0, w7
               	b.ge	<addr>
               	lsl	x2, x0, #3
               	add	x8, x4, x2
               	ldr	x8, [x8]
               	add	x9, x6, x2
               	ldr	x9, [x9]
               	mul	x8, x8, x9
               	madd	x3, x8, x1, x3
               	add	x2, x5, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w7
               	b.lt	<addr>
               	add	x0, x0, x3, lsl #3
               	cmp	x10, x0
               	b.ne	<addr>
               	mov	x0, #-0x1               // =-1
               	mov	x8, #0x2                // =2
               	mov	x6, #0x1                // =1
               	mov	x9, #0x3                // =3
               	mov	x7, #0x4                // =4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x0, [x4]
               	str	x8, [x4, #0x8]
               	str	x9, [x4, #0x10]
               	str	x7, [x4, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x6, [x2]
               	mov	x0, #0xa                // =10
               	str	x0, [x2, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x2, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x2, #0x18]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x6, [x5]
               	str	x6, [x5, #0x8]
               	str	x6, [x5, #0x10]
               	str	x6, [x5, #0x18]
               	mov	x0, #0x0                // =0
               	ldr	x3, [x4]
               	ldr	x10, [x2]
               	mul	x3, x3, x10
               	ldr	x10, [x4, #0x8]
               	ldr	x11, [x2, #0x8]
               	mul	x10, x10, x11
               	mul	x10, x10, x1
               	madd	x3, x3, x1, x10
               	ldr	x10, [x5, #0x8]
               	cmp	x10, #0x0
               	b.ge	<addr>
               	mov	x7, x6
               	add	x10, x7, x3, lsl #3
               	adrp	x2, <page>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x7, [x2, #0x18]
               	mov	x3, x0
               	cmp	w0, w7
               	b.ge	<addr>
               	lsl	x2, x0, #3
               	add	x8, x4, x2
               	ldr	x8, [x8]
               	add	x9, x6, x2
               	ldr	x9, [x9]
               	mul	x8, x8, x9
               	madd	x3, x8, x1, x3
               	add	x2, x5, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w7
               	b.lt	<addr>
               	add	x0, x0, x3, lsl #3
               	cmp	x10, x0
               	b.ne	<addr>
               	mov	x23, #-0x2              // =-2
               	adrp	x24, <page>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x2, [x20, #0x10]
               	str	x3, [x20, #0x18]
               	str	x0, [x22]
               	mov	x1, #0xa                // =10
               	str	x1, [x22, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x22, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x22, #0x18]
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x0, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, x23
               	bl	<addr>
               	ldrsw	x4, [x24, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w4
               	b.ge	<addr>
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x5, x22, x2
               	ldr	x5, [x5]
               	add	x6, x20, x2
               	ldr	x6, [x6]
               	madd	x3, x5, x6, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x23
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w4
               	b.lt	<addr>
               	add	x1, x1, x3, lsl #3
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #-0x1               // =-1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x3, [x20, #0x10]
               	str	x4, [x20, #0x18]
               	str	x0, [x22]
               	mov	x1, #0xa                // =10
               	str	x1, [x22, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x22, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x22, #0x18]
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x2, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, x23
               	bl	<addr>
               	ldrsw	x4, [x24, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w4
               	b.ge	<addr>
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x5, x22, x2
               	ldr	x5, [x5]
               	add	x6, x20, x2
               	ldr	x6, [x6]
               	madd	x3, x5, x6, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x23
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w4
               	b.lt	<addr>
               	add	x1, x1, x3, lsl #3
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #-0x2               // =-2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	str	x2, [x20, #0x10]
               	str	x3, [x20, #0x18]
               	str	x0, [x22]
               	mov	x1, #0xa                // =10
               	str	x1, [x22, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x22, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x22, #0x18]
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x0, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, x23
               	bl	<addr>
               	ldrsw	x4, [x24, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w4
               	b.ge	<addr>
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x5, x22, x2
               	ldr	x5, [x5]
               	add	x6, x20, x2
               	ldr	x6, [x6]
               	madd	x3, x5, x6, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x23
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w4
               	b.lt	<addr>
               	add	x1, x1, x3, lsl #3
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	str	x1, [x20]
               	str	x0, [x20, #0x8]
               	str	x2, [x20, #0x10]
               	str	x3, [x20, #0x18]
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	mov	x2, #0xa                // =10
               	str	x2, [x22, #0x8]
               	mov	x2, #0x64               // =100
               	str	x2, [x22, #0x10]
               	mov	x2, #0x3e8              // =1000
               	str	x2, [x22, #0x18]
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	str	x1, [x21, #0x10]
               	str	x0, [x21, #0x18]
               	mov	x0, x23
               	bl	<addr>
               	ldrsw	x4, [x24, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	cmp	w1, w4
               	b.ge	<addr>
               	ldr	x2, [x20, x1, lsl #3]
               	cmp	x2, #0x0
               	b.lt	<addr>
               	lsl	x2, x1, #3
               	add	x5, x22, x2
               	ldr	x5, [x5]
               	add	x6, x20, x2
               	ldr	x6, [x6]
               	madd	x3, x5, x6, x3
               	add	x2, x21, x2
               	ldr	x2, [x2]
               	cmp	x2, x23
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w4
               	b.lt	<addr>
               	add	x1, x1, x3, lsl #3
               	cmp	x0, x1
               	b.eq	<addr>
               	b	<addr>
               	neg	x2, x3
               	sub	x1, x2, x1
               	sub	x1, x1, #0x1
               	b	<addr>
               	neg	x2, x3
               	sub	x1, x2, x1
               	sub	x1, x1, #0x1
               	b	<addr>
               	neg	x2, x3
               	sub	x1, x2, x1
               	sub	x1, x1, #0x1
               	b	<addr>
               	neg	x2, x3
               	sub	x1, x2, x1
               	sub	x1, x1, #0x1
               	b	<addr>
               	add	x23, x23, #0x1
               	cmp	w23, #0x2
               	b.le	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x6, [x4, #0x10]
               	ldr	x10, [x2, #0x10]
               	mul	x6, x6, x10
               	madd	x3, x6, x1, x3
               	ldr	x6, [x5, #0x10]
               	cmp	x6, #0x0
               	b.ge	<addr>
               	mov	x7, x8
               	b	<addr>
               	ldr	x6, [x4, #0x18]
               	ldr	x2, [x2, #0x18]
               	mul	x2, x6, x2
               	madd	x3, x2, x1, x3
               	ldr	x2, [x5, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x7, x9
               	b	<addr>
               	ldr	x6, [x4, #0x10]
               	ldr	x10, [x2, #0x10]
               	mul	x6, x6, x10
               	madd	x3, x6, x1, x3
               	ldr	x6, [x5, #0x10]
               	cmp	x6, #0x0
               	b.ge	<addr>
               	mov	x7, x8
               	b	<addr>
               	ldr	x6, [x4, #0x18]
               	ldr	x2, [x2, #0x18]
               	mul	x2, x6, x2
               	madd	x3, x2, x1, x3
               	ldr	x2, [x5, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x7, x9
               	b	<addr>
               	ldr	x5, [x4, #0x10]
               	ldr	x9, [x2, #0x10]
               	mul	x5, x5, x9
               	madd	x3, x5, x1, x3
               	ldr	x5, [x6, #0x10]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	mov	x7, x8
               	b	<addr>
               	ldr	x5, [x4, #0x18]
               	ldr	x2, [x2, #0x18]
               	mul	x2, x5, x2
               	madd	x3, x2, x1, x3
               	ldr	x2, [x6, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x7, x1
               	b	<addr>
               	ldr	x5, [x3, #0x10]
               	ldr	x9, [x4, #0x10]
               	mul	x5, x5, x9
               	add	x1, x1, x5, lsl #1
               	ldr	x5, [x2, #0x10]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	mov	x6, x7
               	b	<addr>
               	ldr	x5, [x3, #0x18]
               	ldr	x7, [x4, #0x18]
               	mul	x5, x5, x7
               	add	x1, x1, x5, lsl #1
               	ldr	x2, [x2, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x8
               	b	<addr>
               	ldr	x5, [x3, #0x10]
               	ldr	x9, [x4, #0x10]
               	mul	x5, x5, x9
               	add	x1, x1, x5, lsl #1
               	ldr	x5, [x2, #0x10]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	mov	x6, x7
               	b	<addr>
               	ldr	x5, [x3, #0x18]
               	ldr	x7, [x4, #0x18]
               	mul	x5, x5, x7
               	add	x1, x1, x5, lsl #1
               	ldr	x2, [x2, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x8
               	b	<addr>
               	ldr	x2, [x3, #0x10]
               	ldr	x9, [x4, #0x10]
               	mul	x2, x2, x9
               	add	x1, x1, x2, lsl #1
               	ldr	x2, [x5, #0x10]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x7
               	b	<addr>
               	ldr	x2, [x3, #0x18]
               	ldr	x7, [x4, #0x18]
               	mul	x2, x2, x7
               	add	x1, x1, x2, lsl #1
               	ldr	x2, [x5, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x8
               	b	<addr>
               	ldr	x5, [x3, #0x10]
               	ldr	x9, [x4, #0x10]
               	madd	x1, x5, x9, x1
               	ldr	x5, [x2, #0x10]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	mov	x6, x7
               	b	<addr>
               	ldr	x5, [x3, #0x18]
               	ldr	x7, [x4, #0x18]
               	madd	x1, x5, x7, x1
               	ldr	x2, [x2, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x8
               	b	<addr>
               	ldr	x5, [x3, #0x10]
               	ldr	x9, [x4, #0x10]
               	madd	x1, x5, x9, x1
               	ldr	x5, [x2, #0x10]
               	cmp	x5, #0x0
               	b.ge	<addr>
               	mov	x6, x7
               	b	<addr>
               	ldr	x5, [x3, #0x18]
               	ldr	x7, [x4, #0x18]
               	madd	x1, x5, x7, x1
               	ldr	x2, [x2, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x8
               	b	<addr>
               	ldr	x2, [x3, #0x10]
               	ldr	x9, [x4, #0x10]
               	madd	x1, x2, x9, x1
               	ldr	x2, [x5, #0x10]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x7
               	b	<addr>
               	ldr	x2, [x3, #0x18]
               	ldr	x7, [x4, #0x18]
               	madd	x1, x2, x7, x1
               	ldr	x2, [x5, #0x18]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x6, x8
               	b	<addr>
               	ldr	x8, [x1, #0x10]
               	ldr	x9, [x2, #0x10]
               	mul	x8, x8, x9
               	add	x3, x3, x8, lsl #1
               	ldr	x8, [x4, #0x10]
               	cmp	x8, #0x0
               	b.ge	<addr>
               	mov	x5, x6
               	b	<addr>
               	ldr	x1, [x1, #0x18]
               	ldr	x2, [x2, #0x18]
               	mul	x1, x1, x2
               	add	x3, x3, x1, lsl #1
               	ldr	x1, [x4, #0x18]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	mov	x5, x7
               	b	<addr>
