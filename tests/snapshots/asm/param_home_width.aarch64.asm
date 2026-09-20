
param_home_width.aarch64:	file format elf64-littleaarch64

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

<step_u8>:
               	mov	x2, #0x0                // =0
               	mov	x3, #0x3                // =3
               	cmp	w2, w1
               	b.ge	<addr>
               	and	x0, x0, #0xff
               	mul	x0, x0, x3
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	and	x0, x0, #0xff
               	ret

<step_u16>:
               	mov	x2, #0x0                // =0
               	mov	x3, #0x3                // =3
               	cmp	w2, w1
               	b.ge	<addr>
               	and	x0, x0, #0xffff
               	mul	x0, x0, x3
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	and	x0, x0, #0xffff
               	ret

<step_u32>:
               	mov	x2, #0x0                // =0
               	mov	x3, #0x3                // =3
               	cmp	w2, w1
               	b.ge	<addr>
               	mul	x0, x0, x3
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<step_i8>:
               	sxtb	x0, w0
               	mov	x2, #0x0                // =0
               	cmp	w2, w1
               	b.ge	<addr>
               	sxtb	x0, w0
               	sub	x0, x0, #0x3
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	sxtb	x0, w0
               	ret

<step_i16>:
               	sxth	x0, w0
               	mov	x2, #0x0                // =0
               	cmp	w2, w1
               	b.ge	<addr>
               	sxth	x0, w0
               	sub	x0, x0, #0x3
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	sxth	x0, w0
               	ret

<step_i32>:
               	mov	x2, #0x0                // =0
               	cmp	w2, w1
               	b.ge	<addr>
               	sub	x0, x0, #0x3
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<step_long>:
               	mov	x2, #0x0                // =0
               	cmp	w2, w1
               	b.ge	<addr>
               	sub	x0, x0, #0x3
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<flip>:
               	mov	x2, #0x0                // =0
               	cmp	w2, w1
               	b.ge	<addr>
               	and	x0, x0, #0xff
               	cmp	w0, #0x0
               	cset	x0, eq
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	and	x0, x0, #0xff
               	ret

<toggle>:
               	mov	x2, #0x0                // =0
               	cmp	w2, w1
               	b.ge	<addr>
               	eor	x0, x0, #0x1
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<widen_u32>:
               	mov	w0, w0
               	add	x0, x0, #0x1
               	ret

<widen_i32>:
               	sxtw	x0, w0
               	sub	x0, x0, #0x1
               	ret

<main>:
               	str	x20, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x20, #0xa500            // =42240
               	movk	x20, #0xa5a5, lsl #16
               	movk	x20, #0xa5a5, lsl #32
               	movk	x20, #0xa5a5, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x50]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x48]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x40]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0xa507             // =42247
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x50]
               	blr	x2
               	and	x0, x0, #0xff
               	eor	x0, x0, #0x7
               	cbnz	w0, <addr>
               	mov	x0, #0xa507             // =42247
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x2                // =2
               	ldur	x2, [x29, #-0x50]
               	blr	x2
               	and	x0, x0, #0xff
               	mov	x17, #0x43              // =67
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0xa5c8             // =42440
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x1                // =1
               	ldur	x2, [x29, #-0x50]
               	blr	x2
               	and	x0, x0, #0xff
               	cmp	w0, #0x59
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x7                // =7
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x48]
               	blr	x2
               	and	x0, x0, #0xffff
               	eor	x0, x0, #0x7
               	cbnz	w0, <addr>
               	mov	x0, #0xea60             // =60000
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x1                // =1
               	ldur	x2, [x29, #-0x48]
               	blr	x2
               	and	x0, x0, #0xffff
               	mov	x17, #0xbf21            // =48929
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x7                // =7
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x40]
               	blr	x2
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x2                // =2
               	ldur	x2, [x29, #-0x40]
               	blr	x2
               	cmp	w0, #0x43
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #-0x10              // =-16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x1                // =1
               	ldur	x2, [x29, #-0x40]
               	blr	x2
               	mov	x17, #0xffd1            // =65489
               	movk	x17, #0xffff, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0xa5fb             // =42491
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x38]
               	blr	x2
               	sxtb	x0, w0
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0xa5fb             // =42491
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x2                // =2
               	ldur	x2, [x29, #-0x38]
               	blr	x2
               	sxtb	x0, w0
               	mov	x17, #-0xb              // =-11
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x30]
               	blr	x2
               	sxth	x0, w0
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x2                // =2
               	ldur	x2, [x29, #-0x30]
               	blr	x2
               	sxth	x0, w0
               	mov	x17, #-0xb              // =-11
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #-0x5               // =-5
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x28]
               	blr	x2
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #-0x5               // =-5
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x2                // =2
               	ldur	x2, [x29, #-0x28]
               	blr	x2
               	mov	x17, #-0xb              // =-11
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x17, #-0xb              // =-11
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x40000000         // =1073741824
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0x3fff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0xa501             // =42241
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x20]
               	blr	x2
               	and	x0, x0, #0xff
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0xa501             // =42241
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x3                // =3
               	ldur	x2, [x29, #-0x20]
               	blr	x2
               	and	x0, x0, #0xff
               	cbnz	w0, <addr>
               	mov	x1, #0x1                // =1
               	ldur	x0, [x29, #-0x20]
               	mov	x9, x0
               	mov	x0, x20
               	blr	x9
               	and	x0, x0, #0xff
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x18]
               	blr	x2
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x3                // =3
               	ldur	x2, [x29, #-0x18]
               	blr	x2
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #-0x10              // =-16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	ldur	x1, [x29, #-0x10]
               	blr	x1
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #-0x5               // =-5
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	ldur	x1, [x29, #-0x8]
               	blr	x1
               	mov	x17, #-0x6              // =-6
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
