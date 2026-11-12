
sysv_abi_tail_call.aarch64:	file format elf64-littleaarch64

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

<ms_id>:
               	ret

<ms_idd>:
               	ret

<sv_sum>:
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, x2
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

<tail_int>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, x1
               	adrp	x1, <page>
               	ldr	x21, [x1, #0x10]
               	adrp	x1, <page>
               	ldr	x22, [x1, #0x18]
               	adrp	x1, <page>
               	ldr	x23, [x1, #0x20]
               	adrp	x1, <page>
               	ldr	x24, [x1, #0x28]
               	adrp	x1, <page>
               	ldr	x25, [x1, #0x30]
               	adrp	x1, <page>
               	ldr	x26, [x1, #0x38]
               	adrp	x1, <page>
               	ldr	x27, [x1, #0x40]
               	bl	<addr>
               	mov	x28, x0
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x28, x0
               	add	x1, x21, x22
               	add	x1, x1, x23
               	add	x0, x1, x0
               	add	x1, x24, x25
               	add	x2, x26, x27
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret

<tail_fp>:
               	stp	d8, d9, [sp, #-0x60]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	fmov	d8, d1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d9, [x0]
               	ldr	d10, [x0, #0x8]
               	ldr	d11, [x0, #0x10]
               	ldr	d12, [x0, #0x18]
               	ldr	d13, [x0, #0x20]
               	ldr	d14, [x0, #0x28]
               	ldr	d15, [x0, #0x30]
               	ldr	d16, [x0, #0x38]
               	str	d16, [sp, #0x48]
               	bl	<addr>
               	str	d0, [sp, #0x40]
               	fmov	d0, d8
               	bl	<addr>
               	ldr	d16, [sp, #0x40]
               	fadd	d0, d16, d0
               	fadd	d0, d9, d0
               	fmov	d1, d10
               	fmov	d6, d15
               	fmov	d5, d14
               	fmov	d4, d13
               	fmov	d3, d12
               	fmov	d2, d11
               	ldr	d7, [sp, #0x48]
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x50]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0xa                // =10
               	mov	x1, #0x14               // =20
               	bl	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0xe77
               	csel	x20, x1, x2, ne
               	fmov	d0, #0.50000000
               	fmov	d1, #0.25000000
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	orr	x0, x20, #0x2
               	fcmp	d0, d1
               	csel	x0, x0, x20, ne
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
