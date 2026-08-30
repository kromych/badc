
ms_abi_calling_convention.aarch64:	file format elf64-littleaarch64

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

<four>:
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	ret

<two>:
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<rtd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	d8, [sp, #-0x70]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	str	x24, [sp, #0x30]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x24, x0
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	lsl	x1, x21, #1
               	add	x1, x20, x1
               	mov	x17, #0x3               // =3
               	mul	x2, x22, x17
               	add	x1, x1, x2
               	lsl	x2, x23, #2
               	add	x1, x1, x2
               	mov	x17, #0x5               // =5
               	mul	x2, x24, x17
               	add	x1, x1, x2
               	mov	x17, #0x6               // =6
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	cmp	x0, #0x5b
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x21, x0
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x17, #0xa               // =10
               	mul	x1, x21, x17
               	add	x1, x1, x22
               	mov	x17, #0xa               // =10
               	mul	x2, x23, x17
               	add	x0, x2, x0
               	add	x0, x1, x0
               	cmp	x0, #0x2e
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x23, x0
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d8, d0
               	mov	x22, #0x3               // =3
               	mov	x0, x22
               	bl	<addr>
               	mov	x24, x0
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x21
               	bl	<addr>
               	scvtf	d1, x23
               	fmov	d17, x20
               	fmadd	d2, d8, d17, d1
               	scvtf	d1, x24
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fmadd	d1, d1, d17, d2
               	fmov	d17, x21
               	fmadd	d0, d0, d17, d1
               	mov	x0, #0x403e000000000000 // =4629137466983448576
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x3, x0
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x1fa
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x2c4
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x21, #0x9               // =9
               	mov	x0, x21
               	bl	<addr>
               	add	x1, x0, #0x1
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	cmp	x0, #0x38e
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x21, x17
               	mov	x17, #0x64              // =100
               	mul	x2, x22, x17
               	add	x1, x1, x2
               	mov	x17, #0xa               // =10
               	mul	x2, x23, x17
               	add	x1, x1, x2
               	add	x0, x1, x0
               	mov	x17, #0x2694            // =9876
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x20, x0
               	lsl	x21, x20, #1
               	mov	x17, #0x3               // =3
               	mul	x22, x20, x17
               	cmp	w20, #0x2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	cmp	w21, #0x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w22, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x24, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x2, x0
               	mov	x17, #0xa               // =10
               	mul	x0, x24, x17
               	add	x0, x23, x0
               	mov	x17, #0x64              // =100
               	mul	x1, x20, x17
               	add	x0, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x21, x17
               	add	x0, x0, x1
               	mov	x17, #0x2710            // =10000
               	mul	x1, x22, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	mov	x17, #0x9c13            // =39955
               	movk	x17, #0x8, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
