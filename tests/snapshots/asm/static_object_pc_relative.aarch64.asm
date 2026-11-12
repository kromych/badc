
static_object_pc_relative.aarch64:	file format elf64-littleaarch64

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

<store_imm>:
               	adrp	x0, <page>
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0, #0x30]
               	adrp	x0, <page>
               	mov	x1, #0x5678             // =22136
               	movk	x1, #0x1234, lsl #16
               	str	w1, [x0, #0x38]
               	adrp	x0, <page>
               	mov	x1, #-0x2               // =-2
               	strh	w1, [x0, #0x3c]
               	adrp	x0, <page>
               	mov	x1, #-0x80              // =-128
               	strb	w1, [x0, #0x3e]
               	adrp	x0, <page>
               	mov	x1, #0xff               // =255
               	strb	w1, [x0, #0x3f]
               	adrp	x0, <page>
               	mov	x1, #0xffff             // =65535
               	strh	w1, [x0, #0x40]
               	adrp	x0, <page>
               	mov	x1, #0x80000000         // =2147483648
               	str	w1, [x0, #0x44]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7a               // =122
               	strb	w1, [x0]
               	mov	x1, #0x12c              // =300
               	strh	w1, [x0, #0x2]
               	mov	x1, #-0x7               // =-7
               	str	w1, [x0, #0x4]
               	mov	x1, #0x7fffffff         // =2147483647
               	str	x1, [x0, #0x8]
               	fmov	d0, #0.50000000
               	str	d0, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x21               // =33
               	str	w1, [x0, #0xc]
               	mov	x1, #0x4d               // =77
               	str	w1, [x0, #0x1c]
               	ret

<sum>:
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x38]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrsh	x1, [x1, #0x3c]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrsb	x1, [x1, #0x3e]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x3f]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrh	w1, [x1, #0x40]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldr	w1, [x1, #0x44]
               	add	x1, x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w2, [x0]
               	add	x1, x1, x2
               	ldrsh	x2, [x0, #0x2]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	add	x1, x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x1c]
               	add	x0, x1, x0
               	ret

<store_reg>:
               	adrp	x1, <page>
               	str	x0, [x1, #0x30]
               	adrp	x1, <page>
               	str	w0, [x1, #0x38]
               	adrp	x1, <page>
               	strh	w0, [x1, #0x3c]
               	adrp	x1, <page>
               	strb	w0, [x1, #0x3e]
               	ret

<zero_tests>:
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldrsb	x1, [x1, #0x3e]
               	mov	x2, #0x1                // =1
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	adrp	x1, <page>
               	ldrsh	x1, [x1, #0x3c]
               	orr	x2, x0, #0x2
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x38]
               	orr	x2, x0, #0x4
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	orr	x2, x0, #0x8
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x3f]
               	orr	x2, x0, #0x10
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	ret

<floats>:
               	adrp	x1, <page>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x10]
               	fcvt	s0, d0
               	str	s0, [x1, #0x18]
               	ldr	d0, [x0, #0x10]
               	fmov	d1, #2.00000000
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	d2, [x2, #0x10]
               	fmadd	d0, d0, d1, d2
               	str	d0, [x0, #0x10]
               	ldr	d0, [x0, #0x10]
               	ldr	s1, [x1, #0x18]
               	fcvt	d1, s1
               	fadd	d0, d0, d1
               	ret

<counter>:
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x84]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x84]
               	mov	x0, x1
               	ret

<vol>:
               	adrp	x0, <page>
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x80]
               	ldrsw	x1, [x0, #0x80]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x80]
               	ldrsw	x0, [x0, #0x80]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	bl	<addr>
               	mov	x17, #0x58ff            // =22783
               	movk	x17, #0x1235, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x1f
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x100000000        // =4294967296
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x38]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	ldrsh	x0, [x0, #0x3c]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	ldrsb	x0, [x0, #0x3e]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	bl	<addr>
               	mov	x17, #0x2fe             // =766
               	movk	x17, #0x1, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	s0, [x0, #0x18]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d1, #11.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	s0, [x0, #0x18]
               	fmov	s1, #3.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	bl	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
