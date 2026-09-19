
addr_of_intrinsic_math.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x20, <page>
               	ldr	x20, [x20, <lo12>]
               	adrp	x21, <page>
               	ldr	x21, [x21, <lo12>]
               	adrp	x22, <page>
               	ldr	x22, [x22, <lo12>]
               	adrp	x23, <page>
               	ldr	x23, [x23, <lo12>]
               	fmov	d0, #-3.50000000
               	blr	x0
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	fmov	d0, #16.00000000
               	blr	x20
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	blr	x21
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	blr	x22
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x10]
               	blr	x23
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	fmov	d0, #-9.00000000
               	bl	<addr>
               	fmov	d1, #9.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x18]
               	bl	<addr>
               	fmov	d1, #9.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x20]
               	bl	<addr>
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	fmov	d0, #7.00000000
               	fmov	d1, #-7.00000000
               	fabs	d1, d1
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x28]
               	fsqrt	d0, d0
               	fmov	d1, #7.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<__c5_sys_sqrt>:
               	b	<addr>

<__c5_sys_fabs>:
               	b	<addr>

<__c5_sys_floor>:
               	b	<addr>
