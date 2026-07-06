
addr_of_intrinsic_math_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x370              // =880
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x1, #0x41800000         // =1098907648
               	str	x1, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x402c, lsl #16
               	str	x0, [sp, #-0x10]!
               	mov	x9, x20
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x4006, lsl #16
               	str	x0, [sp, #-0x10]!
               	mov	x9, x21
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x4039, lsl #16
               	str	x0, [sp, #-0x10]!
               	mov	x9, x22
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x40600000        // =1080033280
               	fmov	s16, w20
               	fneg	s0, s16
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x42a20000         // =1117913088
               	fmov	s16, w0
               	sub	x17, x29, #0x48
               	str	s16, [x17]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x40bc, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x50
               	str	s16, [x17]
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x4006, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x58
               	str	s16, [x17]
               	sub	x0, x29, #0x40
               	ldr	x0, [x0]
               	sub	x16, x29, #0x48
               	ldr	s0, [x16]
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x41100000         // =1091567616
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x8]
               	sub	x16, x29, #0x50
               	ldr	s0, [x16]
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x10]
               	sub	x16, x29, #0x58
               	ldr	s0, [x16]
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s16, w0
               	fneg	s0, s16
               	fabs	s0, s0
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x42440000         // =1111752704
               	fmov	s16, w0
               	fsqrt	s0, s16
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_sqrtf>:
               	b	<addr>

<__c5_sys_floorf>:
               	b	<addr>

<__c5_sys_ceilf>:
               	b	<addr>
