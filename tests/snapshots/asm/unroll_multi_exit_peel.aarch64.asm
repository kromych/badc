
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

<walk_peeled>:
               	mov	x5, x0
               	mov	x4, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	mul	x0, x0, x3
               	mul	x0, x0, x5
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x6, [x3]
               	cmp	x6, #0x0
               	b.ge	<addr>
               	lsl	x0, x0, #3
               	add	x0, x0, x4
               	ret
               	mov	x4, #0x1                // =1
               	ldr	x6, [x1, #0x8]
               	ldr	x7, [x2, #0x8]
               	mul	x6, x6, x7
               	madd	x0, x6, x5, x0
               	ldr	x6, [x3, #0x8]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	mov	x4, #0x2                // =2
               	ldr	x6, [x1, #0x10]
               	ldr	x7, [x2, #0x10]
               	mul	x6, x6, x7
               	madd	x0, x6, x5, x0
               	ldr	x6, [x3, #0x10]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	mov	x4, #0x3                // =3
               	ldr	x1, [x1, #0x18]
               	ldr	x2, [x2, #0x18]
               	mul	x1, x1, x2
               	madd	x0, x1, x5, x0
               	ldr	x1, [x3, #0x18]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	mov	x4, #0x4                // =4
               	b	<addr>

<scan_peeled>:
               	mov	x5, x0
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x2, x1
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x1
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x2, [x3]
               	ldr	x4, [x0]
               	mul	x2, x2, x4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x6, [x4]
               	cmp	x6, x5
               	b.ge	<addr>
               	lsl	x0, x2, #3
               	add	x0, x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	ldr	x6, [x0, #0x8]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	ldr	x6, [x3, #0x8]
               	ldr	x7, [x0, #0x8]
               	madd	x2, x6, x7, x2
               	ldr	x6, [x4, #0x8]
               	cmp	x6, x5
               	b.lt	<addr>
               	mov	x1, #0x2                // =2
               	ldr	x6, [x0, #0x10]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	ldr	x6, [x3, #0x10]
               	ldr	x7, [x0, #0x10]
               	madd	x2, x6, x7, x2
               	ldr	x6, [x4, #0x10]
               	cmp	x6, x5
               	b.lt	<addr>
               	mov	x1, #0x3                // =3
               	ldr	x6, [x0, #0x18]
               	cmp	x6, #0x0
               	b.lt	<addr>
               	ldr	x3, [x3, #0x18]
               	ldr	x0, [x0, #0x18]
               	madd	x2, x3, x0, x2
               	ldr	x0, [x4, #0x18]
               	cmp	x0, x5
               	b.lt	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	str	x3, [x0, #0x10]
               	str	x4, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	mov	x3, #0xa                // =10
               	str	x3, [x0, #0x8]
               	mov	x3, #0x64               // =100
               	str	x3, [x0, #0x10]
               	mov	x3, #0x3e8              // =1000
               	str	x3, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x2
               	bl	<addr>
               	mov	x17, #0xe14             // =3604
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
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
               	mov	x24, #0x1               // =1
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x2, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x24, [x21]
               	str	x0, [x21, #0x8]
               	str	x1, [x21, #0x10]
               	str	x2, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x24, [x22]
               	mov	x0, #0xa                // =10
               	str	x0, [x22, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x22, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x22, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x24, [x23]
               	str	x24, [x23, #0x8]
               	str	x24, [x23, #0x10]
               	str	x24, [x23, #0x18]
               	mov	x0, x24
               	bl	<addr>
               	mov	x6, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	lsl	x1, x0, #3
               	add	x3, x21, x1
               	ldr	x3, [x3]
               	add	x4, x22, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x23, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x6, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x1, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x2, #-0x1               // =-1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x0, [x21, #0x8]
               	str	x3, [x21, #0x10]
               	str	x4, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x1, [x22]
               	mov	x0, #0xa                // =10
               	str	x0, [x22, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x22, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x22, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x24
               	bl	<addr>
               	mov	x6, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x3, x21, x1
               	ldr	x3, [x3]
               	add	x4, x22, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x6, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x1                // =1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x2, [x21, #0x8]
               	str	x3, [x21, #0x10]
               	str	x4, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	mov	x1, #0xa                // =10
               	str	x1, [x22, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x22, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x22, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x0, [x23]
               	str	x0, [x23, #0x8]
               	str	x0, [x23, #0x10]
               	str	x0, [x23, #0x18]
               	mov	x0, x24
               	bl	<addr>
               	mov	x6, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	lsl	x1, x0, #3
               	add	x3, x21, x1
               	ldr	x3, [x3]
               	add	x4, x22, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	add	x1, x23, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x6, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x24, #0x2               // =2
               	mov	x1, #0x1                // =1
               	mov	x0, #0x3                // =3
               	mov	x2, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x24, [x21, #0x8]
               	str	x0, [x21, #0x10]
               	str	x2, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x1, [x22]
               	mov	x0, #0xa                // =10
               	str	x0, [x22, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x22, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x22, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x24
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x3, x21, x1
               	ldr	x3, [x3]
               	add	x4, x22, x1
               	ldr	x4, [x4]
               	mul	x3, x3, x4
               	lsl	x3, x3, #1
               	add	x2, x2, x3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #-0x1               // =-1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x0, [x21]
               	str	x1, [x21, #0x8]
               	str	x3, [x21, #0x10]
               	str	x4, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	mov	x1, #0xa                // =10
               	str	x1, [x22, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x22, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x22, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x0, [x23]
               	str	x0, [x23, #0x8]
               	str	x2, [x23, #0x10]
               	str	x0, [x23, #0x18]
               	mov	x0, x24
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	lsl	x1, x0, #3
               	add	x3, x21, x1
               	ldr	x3, [x3]
               	add	x4, x22, x1
               	ldr	x4, [x4]
               	mul	x3, x3, x4
               	lsl	x3, x3, #1
               	add	x2, x2, x3
               	add	x1, x23, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x1                // =1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x2, [x21, #0x8]
               	str	x3, [x21, #0x10]
               	str	x4, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	mov	x1, #0xa                // =10
               	str	x1, [x22, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x22, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x22, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x0, [x23]
               	str	x0, [x23, #0x8]
               	str	x0, [x23, #0x10]
               	str	x0, [x23, #0x18]
               	mov	x0, x24
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x3, x21, x1
               	ldr	x3, [x3]
               	add	x4, x22, x1
               	ldr	x4, [x4]
               	mul	x3, x3, x4
               	lsl	x3, x3, #1
               	add	x2, x2, x3
               	add	x1, x23, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x20]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x20, #0x3               // =3
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x4                // =4
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	str	x1, [x22, #0x8]
               	str	x20, [x22, #0x10]
               	str	x2, [x22, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x0, [x23]
               	mov	x1, #0xa                // =10
               	str	x1, [x23, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x23, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x23, #0x18]
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	str	x0, [x24]
               	str	x0, [x24, #0x8]
               	str	x0, [x24, #0x10]
               	str	x0, [x24, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	lsl	x1, x0, #3
               	add	x3, x22, x1
               	ldr	x3, [x3]
               	add	x4, x23, x1
               	ldr	x4, [x4]
               	mul	x3, x3, x4
               	madd	x2, x3, x20, x2
               	add	x1, x24, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x2, #-0x1               // =-1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x1, [x22]
               	str	x0, [x22, #0x8]
               	str	x3, [x22, #0x10]
               	str	x4, [x22, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x1, [x23]
               	mov	x0, #0xa                // =10
               	str	x0, [x23, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x23, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x23, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.ge	<addr>
               	lsl	x1, x0, #3
               	add	x3, x22, x1
               	ldr	x3, [x3]
               	add	x4, x23, x1
               	ldr	x4, [x4]
               	mul	x3, x3, x4
               	madd	x2, x3, x20, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x21]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x1                // =1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x2, [x21, #0x8]
               	str	x3, [x21, #0x10]
               	str	x4, [x21, #0x18]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x0, [x22]
               	mov	x1, #0xa                // =10
               	str	x1, [x22, #0x8]
               	mov	x1, #0x64               // =100
               	str	x1, [x22, #0x10]
               	mov	x1, #0x3e8              // =1000
               	str	x1, [x22, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x0, [x23]
               	str	x0, [x23, #0x8]
               	str	x0, [x23, #0x10]
               	str	x0, [x23, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	lsl	x1, x0, #3
               	add	x3, x21, x1
               	ldr	x3, [x3]
               	add	x4, x22, x1
               	ldr	x4, [x4]
               	mul	x3, x3, x4
               	madd	x2, x3, x20, x2
               	add	x1, x23, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x20, #-0x2              // =-2
               	cmp	w20, #0x2
               	b.gt	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x0, [x21, #0x8]
               	str	x2, [x21, #0x10]
               	str	x3, [x21, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x1, [x23]
               	mov	x0, #0xa                // =10
               	str	x0, [x23, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x23, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x23, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	ldr	x1, [x21, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x3, x23, x1
               	ldr	x3, [x3]
               	add	x4, x21, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, x20
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldrsw	x1, [x22]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x2, #-0x1               // =-1
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x0, [x21, #0x8]
               	str	x3, [x21, #0x10]
               	str	x4, [x21, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x1, [x23]
               	mov	x0, #0xa                // =10
               	str	x0, [x23, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x23, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x23, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x22]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x21, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x3, x23, x1
               	ldr	x3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, x20
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x22]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #-0x2               // =-2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x1, [x21]
               	str	x0, [x21, #0x8]
               	str	x2, [x21, #0x10]
               	str	x3, [x21, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	str	x1, [x23]
               	mov	x0, #0xa                // =10
               	str	x0, [x23, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x23, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x23, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	ldr	x1, [x21, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x3, x23, x1
               	ldr	x3, [x3]
               	add	x4, x21, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, x20
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldrsw	x1, [x22]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	mov	x2, #-0x1               // =-1
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x3, #0x4                // =4
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x2, [x21]
               	str	x0, [x21, #0x8]
               	str	x1, [x21, #0x10]
               	str	x3, [x21, #0x18]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x23]
               	mov	x0, #0xa                // =10
               	str	x0, [x23, #0x8]
               	mov	x0, #0x64               // =100
               	str	x0, [x23, #0x10]
               	mov	x0, #0x3e8              // =1000
               	str	x0, [x23, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrsw	x1, [x22]
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x1, [x21, x0, lsl #3]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	lsl	x1, x0, #3
               	add	x3, x23, x1
               	ldr	x3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	ldr	x4, [x4]
               	madd	x2, x3, x4, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, x20
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x1, [x22]
               	cmp	w0, w1
               	b.lt	<addr>
               	lsl	x1, x2, #3
               	add	x0, x1, x0
               	cmp	x5, x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x1, x2, x17
               	sub	x0, x1, x0
               	sub	x0, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x1, x2, x17
               	sub	x0, x1, x0
               	sub	x0, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x1, x2, x17
               	sub	x0, x1, x0
               	sub	x0, x0, #0x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x1, x2, x17
               	sub	x0, x1, x0
               	sub	x0, x0, #0x1
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x2
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
