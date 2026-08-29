
addr_of_intrinsic_math_float.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x20, <page>
               	ldr	x20, [x20, <lo12>]
               	adrp	x21, <page>
               	ldr	x21, [x21, <lo12>]
               	adrp	x22, <page>
               	ldr	x22, [x22, <lo12>]
               	mov	x1, #0x41800000         // =1098907648
               	mov	x9, x0
               	fmov	d0, x1
               	blr	x9
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x402c, lsl #16
               	mov	x9, x20
               	fmov	d0, x0
               	blr	x9
               	mov	x20, #0x40000000        // =1073741824
               	fmov	s17, w20
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x23, #0x6666            // =26214
               	movk	x23, #0x4006, lsl #16
               	mov	x9, x21
               	fmov	d0, x23
               	blr	x9
               	mov	x21, #0x40400000        // =1077936128
               	fmov	s17, w21
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x4039, lsl #16
               	mov	x9, x22
               	fmov	d0, x0
               	blr	x9
               	fmov	s17, w20
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x20, #0x40600000        // =1080033280
               	fmov	s16, w20
               	fneg	s0, s16
               	mov	x9, x0
               	blr	x9
               	fmov	s17, w20
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x20, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x0, #0x42a20000         // =1117913088
               	fmov	s16, w0
               	sub	x17, x29, #0x30
               	str	s16, [x17]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x40bc, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x28
               	str	s16, [x17]
               	fmov	s16, w23
               	sub	x17, x29, #0x20
               	str	s16, [x17]
               	sub	x16, x29, #0x30
               	ldr	s0, [x16]
               	bl	<addr>
               	mov	x0, #0x41100000         // =1091567616
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldr	x0, [x20, #0x8]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x9, x0
               	blr	x9
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldr	x0, [x20, #0x10]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x9, x0
               	blr	x9
               	fmov	s17, w21
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s16, w0
               	fneg	s0, s16
               	fabs	s0, s0
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x1, #0x42440000         // =1111752704
               	fmov	s16, w1
               	fsqrt	s0, s16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<__c5_sys_sqrtf>:
               	b	<addr>

<__c5_sys_floorf>:
               	b	<addr>

<__c5_sys_ceilf>:
               	b	<addr>
