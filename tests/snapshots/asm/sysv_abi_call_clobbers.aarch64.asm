
sysv_abi_call_clobbers.aarch64:	file format elf64-littleaarch64

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

<clobber>:
               	ret

<keep_fp>:
               	stp	d8, d9, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	fmov	d8, d0
               	fmov	d9, d1
               	bl	<addr>
               	fmadd	d0, d8, d9, d8
               	fadd	d0, d0, d9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x20
               	ret

<keep_gpr>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	mul	x0, x22, x23
               	madd	x24, x20, x21, x0
               	bl	<addr>
               	add	x0, x24, x20
               	add	x0, x0, x21
               	add	x0, x0, x22
               	add	x0, x0, x23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<sv8>:
               	fmov	d19, #2.00000000
               	fmadd	d0, d1, d19, d0
               	fmov	d1, #3.00000000
               	fmadd	d0, d2, d1, d0
               	fmov	d1, #4.00000000
               	fmadd	d0, d3, d1, d0
               	fmov	d1, #5.00000000
               	fmadd	d0, d4, d1, d0
               	fmov	d1, #6.00000000
               	fmadd	d0, d5, d1, d0
               	fmov	d1, #7.00000000
               	fmadd	d0, d6, d1, d0
               	fmov	d1, #8.00000000
               	fmadd	d0, d7, d1, d0
               	ret

<keep_across_sv8>:
               	stp	d8, d9, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	fmov	d8, d0
               	fmov	d9, d1
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d3, #4.00000000
               	fmov	d4, #5.00000000
               	fmov	d5, #6.00000000
               	fmov	d6, #7.00000000
               	fmov	d7, #8.00000000
               	bl	<addr>
               	fmadd	d0, d8, d9, d0
               	fadd	d0, d0, d8
               	fadd	d0, d0, d9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x20
               	ret

<twice>:
               	lsl	x0, x0, #1
               	ret

<keep_pointer>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	mov	x0, x21
               	blr	x20
               	mov	x24, x0
               	mov	x0, x22
               	blr	x20
               	add	x0, x24, x0
               	madd	x0, x21, x22, x0
               	add	x0, x0, x23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<sv6>:
               	fmov	d6, #10.00000000
               	fmadd	d0, d1, d6, d0
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fmadd	d0, d2, d1, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fmadd	d0, d3, d1, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fmadd	d0, d4, d1, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fmadd	d0, d5, d1, d0
               	ret

<swap6>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	fmov	d3, #3.00000000
               	fmov	d4, #4.00000000
               	fmov	d5, #5.00000000
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	fmov	d17, d5
               	fmov	d5, d2
               	fmov	d2, d3
               	fmov	d3, d4
               	fmov	d4, d17
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	d8, d9, [sp, #-0xa0]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x20, x21, [sp, #0x40]
               	stp	x22, x23, [sp, #0x50]
               	stp	x24, x25, [sp, #0x60]
               	str	x26, [sp, #0x70]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d8, [x0]
               	ldr	d9, [x0, #0x8]
               	ldr	d10, [x0, #0x10]
               	ldr	d11, [x0, #0x18]
               	ldr	d12, [x0, #0x20]
               	ldr	d13, [x0, #0x28]
               	ldr	d14, [x0, #0x30]
               	ldr	d15, [x0, #0x38]
               	ldr	d16, [x0, #0x40]
               	str	d16, [sp, #0x88]
               	ldr	d16, [x0, #0x48]
               	str	d16, [sp, #0x80]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	ldr	x22, [x0, #0x8]
               	ldr	x23, [x0, #0x10]
               	ldr	x24, [x0, #0x18]
               	ldr	x25, [x0, #0x20]
               	ldr	x26, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	bl	<addr>
               	fmov	d1, #11.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x0, [x3]
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x3, #0x10]
               	ldr	x3, [x3, #0x18]
               	bl	<addr>
               	cmp	x0, #0x28
               	b.eq	<addr>
               	orr	x20, x20, #0x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x18]
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x1, [x3, #0x8]
               	ldr	x2, [x3, #0x10]
               	ldr	x3, [x3, #0x20]
               	bl	<addr>
               	cmp	x0, #0x23
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x20]
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x10
               	fmov	d0, #2.00000000
               	fmadd	d0, d9, d0, d8
               	fmov	d1, #3.00000000
               	fmadd	d0, d10, d1, d0
               	fmov	d1, #4.00000000
               	fmadd	d0, d11, d1, d0
               	fmov	d1, #5.00000000
               	fmadd	d0, d12, d1, d0
               	fmov	d1, #6.00000000
               	fmadd	d0, d13, d1, d0
               	fmov	d1, #7.00000000
               	fmadd	d0, d14, d1, d0
               	fmov	d1, #8.00000000
               	fmadd	d0, d15, d1, d0
               	fmov	d1, #9.00000000
               	ldr	d16, [sp, #0x88]
               	fmadd	d0, d16, d1, d0
               	fmov	d1, #10.00000000
               	ldr	d16, [sp, #0x80]
               	fmadd	d0, d16, d1, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x28]
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	lsl	x0, x22, #1
               	add	x0, x21, x0
               	mov	x17, #0x3               // =3
               	mul	x1, x23, x17
               	add	x0, x0, x1
               	lsl	x1, x24, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x25, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x26, x17
               	add	x0, x0, x1
               	cmp	x0, #0x12d
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x26, [sp, #0x70]
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0xa0
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>
