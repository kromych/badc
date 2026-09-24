
early_return_before_frame.aarch64:	file format elf64-littleaarch64

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

<fib>:
               	cmp	w0, #0x2
               	b.lt	<addr>
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x20, w0
               	mov	x21, #0x0               // =0
               	sub	x0, x20, #0x1
               	bl	<addr>
               	sub	x20, x20, #0x2
               	add	x21, x21, x0
               	cmp	w20, #0x2
               	b.ge	<addr>
               	add	x0, x21, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sxtw	x0, w0
               	ret

<qs>:
               	cmp	w1, w2
               	b.ge	<addr>
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x0
               	sxtw	x22, w2
               	sxtw	x1, w1
               	add	x0, x1, x22
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	asr	x0, x0, #1
               	ldr	x0, [x21, x0, lsl #3]
               	mov	x2, x22
               	mov	x20, x1
               	b	<addr>
               	add	x20, x20, #0x1
               	ldr	x3, [x21, w20, sxtw #3]
               	cmp	x3, x0
               	b.lt	<addr>
               	ldr	x3, [x21, w2, sxtw #3]
               	cmp	x3, x0
               	b.le	<addr>
               	sub	x2, x2, #0x1
               	ldr	x3, [x21, w2, sxtw #3]
               	cmp	x3, x0
               	b.gt	<addr>
               	cmp	w20, w2
               	b.gt	<addr>
               	ldr	x3, [x21, w20, sxtw #3]
               	ldr	x4, [x21, w2, sxtw #3]
               	str	x4, [x21, w20, sxtw #3]
               	str	x3, [x21, w2, sxtw #3]
               	add	x20, x20, #0x1
               	sub	x2, x2, #0x1
               	cmp	w20, w2
               	b.le	<addr>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x1, w20
               	cmp	w1, w22
               	b.lt	<addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ret

<tree_sum>:
               	cbz	x0, <addr>
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, #0x0               // =0
               	ldr	x22, [x20, #0x10]
               	ldr	x0, [x20]
               	bl	<addr>
               	add	x0, x22, x0
               	ldr	x20, [x20, #0x8]
               	add	x21, x21, x0
               	cbnz	x20, <addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ret

<narrow>:
               	sxtb	x9, w0
               	cmp	w9, #0x0
               	b.le	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtb	x0, w0
               	sxth	x1, w1
               	sub	x2, x0, #0x1
               	sub	x1, x1, x0
               	mov	x0, x2
               	bl	<addr>
               	sxth	x0, w0
               	add	x0, x0, #0x1
               	sxth	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x0, w1
               	ret

<ucount>:
               	cmp	w0, w1
               	b.lo	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	w1, w1
               	sub	x0, x0, x1
               	mov	w0, w0
               	bl	<addr>
               	eor	x0, x0, #0x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x9, x0, #2
               	add	x9, x9, x1
               	mov	w0, w9
               	ret

<many>:
               	cmp	x0, #0x0
               	b.le	<addr>
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x3
               	mov	x24, x7
               	mov	x23, x6
               	mov	x22, x5
               	mov	x21, x4
               	sub	x0, x0, #0x1
               	ldr	x3, [x29, #0x10]
               	add	x1, x1, x3
               	ldr	x4, [x29, #0x18]
               	add	x2, x2, x4
               	sub	sp, sp, #0x10
               	str	x3, [sp]
               	str	x4, [sp, #0x8]
               	mov	x3, x20
               	mov	x7, x24
               	mov	x6, x23
               	mov	x5, x22
               	mov	x4, x21
               	bl	<addr>
               	add	sp, sp, #0x10
               	add	x0, x0, x20
               	add	x0, x0, x21
               	add	x0, x0, x22
               	add	x0, x0, x23
               	add	x0, x0, x24
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	eor	x0, x1, x2
               	ret

<gcd>:
               	cbz	w1, <addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	blr	x2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w0
               	ret

<count_yield>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<lex>:
               	cbz	x0, <addr>
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	ldrb	w0, [x20]
               	sub	x0, x0, #0x2a
               	cmp	x0, #0x10
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	add	x20, x20, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	ldrb	w0, [x20]
               	sub	x0, x0, #0x2a
               	cmp	x0, #0x10
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ret

<keep>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	ldr	x21, [x0, #0x8]
               	ldr	x22, [x0, #0x10]
               	ldr	x23, [x0, #0x18]
               	ldr	x24, [x0, #0x20]
               	ldr	x25, [x0, #0x28]
               	ldr	x26, [x0, #0x30]
               	ldr	x27, [x0, #0x38]
               	ldr	x28, [x0, #0x40]
               	ldr	x17, [x0, #0x48]
               	str	x17, [sp, #0x68]
               	ldr	x17, [x0, #0x50]
               	str	x17, [sp, #0x60]
               	ldr	x17, [x0, #0x58]
               	str	x17, [sp, #0x58]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	str	x0, [sp, #0x50]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	ldr	x16, [sp, #0x50]
               	add	x16, x16, x0
               	str	x16, [sp, #0x50]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	sxth	x0, w0
               	ldr	x16, [sp, #0x50]
               	add	x0, x16, x0
               	add	x16, x0, #0x7
               	str	x16, [sp, #0x50]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	sub	sp, sp, #0x10
               	str	x0, [sp]
               	str	x0, [sp, #0x8]
               	mov	x3, x0
               	mov	x7, x0
               	mov	x6, x0
               	mov	x5, x0
               	mov	x4, x0
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldr	x16, [sp, #0x50]
               	add	x0, x16, x0
               	add	x0, x0, x20
               	lsl	x1, x21, #1
               	add	x0, x0, x1
               	mov	x17, #0x3               // =3
               	mul	x1, x22, x17
               	add	x0, x0, x1
               	lsl	x1, x23, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x24, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x25, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x26, x17
               	add	x0, x0, x1
               	lsl	x1, x27, #3
               	add	x0, x0, x1
               	mov	x17, #0x9               // =9
               	mul	x1, x28, x17
               	add	x0, x0, x1
               	ldr	x16, [sp, #0x68]
               	mov	x17, #0xa               // =10
               	mul	x1, x16, x17
               	add	x0, x0, x1
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0xb               // =11
               	mul	x1, x16, x17
               	add	x0, x0, x1
               	ldr	x16, [sp, #0x58]
               	mov	x17, #0xc               // =12
               	mul	x1, x16, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2d0
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x17, #0x1a6d            // =6765
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3039             // =12345
               	mov	x0, #0x0                // =0
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	sub	x2, x29, #0x2a8
               	lsr	x3, x1, #33
               	mov	x17, #0x40000000        // =1073741824
               	sub	x3, x3, x17
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x20, x29, #0x2a8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x0, #0x1
               	ldr	x1, [x20, x1, lsl #3]
               	ldr	x2, [x20, x0, lsl #3]
               	cmp	x1, x2
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x2a8
               	mov	x1, #0x5                // =5
               	mov	x2, x1
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x2, x29, #0xa8
               	mov	x17, #0x18              // =24
               	mul	x3, x0, x17
               	add	x3, x2, x3
               	add	x4, x0, #0x1
               	str	x4, [x3, #0x10]
               	lsl	x0, x0, #1
               	add	x5, x0, #0x1
               	cmp	w5, #0x7
               	b.ge	<addr>
               	mov	x17, #0x18              // =24
               	mul	x5, x5, x17
               	add	x5, x2, x5
               	str	x5, [x3]
               	add	x0, x0, #0x2
               	cmp	w0, #0x7
               	b.ge	<addr>
               	mov	x17, #0x18              // =24
               	mul	x0, x0, x17
               	add	x0, x2, x0
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x5, x1
               	b	<addr>
               	str	x0, [x3, #0x8]
               	mov	x0, x4
               	cmp	w0, #0x7
               	b.lt	<addr>
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	sxth	x0, w0
               	cmp	w0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7               // =-7
               	mov	x1, #-0x12c             // =-300
               	bl	<addr>
               	sxth	x0, w0
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0xf
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffffff0         // =4294967280
               	mov	x1, #0x7ffffff0         // =2147483632
               	bl	<addr>
               	mov	x17, #0x30              // =48
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x7fffffff         // =2147483647
               	mov	x1, #0x80000000         // =2147483648
               	bl	<addr>
               	mov	x17, #0x7ffffffc        // =2147483644
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x22, #0x1               // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0xa                // =10
               	mov	x4, #0x14               // =20
               	mov	x5, #0x1e               // =30
               	mov	x6, #0x28               // =40
               	mov	x7, #0x32               // =50
               	mov	x1, #0x64               // =100
               	mov	x8, #0x3e8              // =1000
               	sub	sp, sp, #0x10
               	str	x1, [sp]
               	str	x8, [sp, #0x8]
               	mov	x1, x22
               	bl	<addr>
               	add	sp, sp, #0x10
               	cmp	x0, #0xc59
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x1, #0x6                // =6
               	mov	x2, #0x3                // =3
               	sub	sp, sp, #0x10
               	str	x21, [sp]
               	str	x21, [sp, #0x8]
               	mov	x0, x21
               	mov	x7, x21
               	mov	x6, x21
               	mov	x5, x21
               	mov	x4, x21
               	mov	x3, x21
               	bl	<addr>
               	add	sp, sp, #0x10
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1ce              // =462
               	mov	x1, #0x93               // =147
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x29a
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w0, [x20]
               	sub	x0, x0, #0x2a
               	cmp	x0, #0x10
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w22, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w21, [x0]
               	add	x20, x20, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	ldrb	w0, [x20]
               	sub	x0, x0, #0x2a
               	cmp	x0, #0x10
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2d0
               	ldp	x29, x30, [sp], #0x10
               	ret
