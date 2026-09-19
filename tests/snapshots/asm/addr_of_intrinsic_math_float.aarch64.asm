
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
               	stp	d8, d9, [sp, #-0x40]!
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x20, <page>
               	ldr	x20, [x20, <lo12>]
               	adrp	x21, <page>
               	ldr	x21, [x21, <lo12>]
               	adrp	x22, <page>
               	ldr	x22, [x22, <lo12>]
               	fmov	s0, #16.00000000
               	blr	x0
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16]
               	blr	x20
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x4]
               	blr	x21
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x8]
               	blr	x22
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	fmov	s0, #3.50000000
               	fneg	s0, s0
               	blr	x0
               	fmov	s1, #3.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	mov	x16, #0x42a20000        // =1117913088
               	fmov	s0, w16
               	adrp	x16, <page>
               	ldr	s8, [x16, #0xc]
               	adrp	x16, <page>
               	ldr	s9, [x16, #0x4]
               	bl	<addr>
               	fmov	s1, #9.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	fmov	d0, d9
               	bl	<addr>
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	fmov	s0, #7.00000000
               	fneg	s1, s0
               	fabs	s1, s1
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	mov	x16, #0x42440000        // =1111752704
               	fmov	s0, w16
               	fsqrt	s0, s0
               	fmov	s1, #7.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret

<__c5_sys_sqrtf>:
               	b	<addr>

<__c5_sys_floorf>:
               	b	<addr>

<__c5_sys_ceilf>:
               	b	<addr>
