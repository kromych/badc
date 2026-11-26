
sroa_copies_between_objects.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<swap_loop>:
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x10]
               	ldr	x1, [x1, #0x10]
               	add	x2, x1, x1, lsl #1
               	mov	x1, #0x0                // =0
               	cmp	x1, x0
               	b.ge	<addr>
               	add	x3, x3, x1
               	add	x1, x1, #0x1
               	mov	x16, x3
               	mov	x3, x2
               	mov	x2, x16
               	cmp	x1, x0
               	b.lt	<addr>
               	sub	x0, x3, x2
               	ret

<rotate>:
               	adrp	x1, <page>
               	ldr	x4, [x1, #0x10]
               	mov	x5, #0x1                // =1
               	mov	x3, #0x2                // =2
               	ldr	x7, [x1, #0x10]
               	mov	x6, #0x3                // =3
               	mov	x2, #0x4                // =4
               	mov	x1, #0x0                // =0
               	cmp	x1, x0
               	b.ge	<addr>
               	add	x4, x4, x1
               	add	x1, x1, #0x1
               	mov	x16, x4
               	mov	x4, x3
               	mov	x3, x6
               	mov	x6, x16
               	mov	x16, x2
               	mov	x2, x5
               	mov	x5, x7
               	mov	x7, x16
               	cmp	x1, x0
               	b.lt	<addr>
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x0, x4, x17
               	mov	x17, #0x2710            // =10000
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	mov	x17, #0x64              // =100
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	add	x0, x0, x2
               	ret

<member_copy>:
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	ldr	x3, [x1, #0x10]
               	add	x3, x3, #0x1
               	ldr	x1, [x1, #0x10]
               	add	x5, x1, #0x2
               	mov	x1, #0x0                // =0
               	mov	x6, x1
               	mov	x4, x1
               	cmp	x4, x0
               	b.ge	<addr>
               	add	x2, x2, x3
               	add	x4, x4, #0x1
               	mov	x16, x3
               	mov	x3, x1
               	mov	x1, x16
               	mov	x16, x6
               	mov	x6, x5
               	mov	x5, x16
               	cmp	x4, x0
               	b.lt	<addr>
               	add	x0, x2, x5
               	sub	x0, x0, x6
               	ret

<two_widths>:
               	mov	x2, x0
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x0                // =0
               	cmp	x1, x2
               	b.ge	<addr>
               	add	x3, x1, x0, lsr #32
               	and	x4, x0, #0xffffffff00000000
               	orr	x3, x4, x3
               	mov	w3, w3
               	orr	x0, x3, x0, lsl #32
               	add	x1, x1, #0x1
               	cmp	x1, x2
               	b.lt	<addr>
               	ret

<fp_swap>:
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	scvtf	d0, x1
               	fmov	x3, d0
               	mov	x2, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x0                // =0
               	fmov	d0, #1.00000000
               	cmp	x1, x0
               	b.ge	<addr>
               	fmov	d1, x3
               	fadd	d1, d1, d0
               	fmov	x3, d1
               	add	x1, x1, #0x1
               	mov	x16, x3
               	mov	x3, x2
               	mov	x2, x16
               	cmp	x1, x0
               	b.lt	<addr>
               	fmov	d0, x3
               	fmov	d1, x2
               	fsub	d0, d0, d1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x17, #0x7665            // =30309
               	movk	x17, #0x2f, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	movk	x17, #0xc, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	fmov	d1, #-11.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
