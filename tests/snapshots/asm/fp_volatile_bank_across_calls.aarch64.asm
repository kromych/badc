
fp_volatile_bank_across_calls.aarch64:	file format elf64-littleaarch64

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

<spread>:
               	fmov	d2, #1.00000000
               	fadd	d5, d0, d2
               	fmov	d2, #2.00000000
               	fadd	d6, d0, d2
               	fmov	d2, #3.00000000
               	fadd	d7, d0, d2
               	fmov	d3, #4.00000000
               	fadd	d19, d0, d3
               	fmov	d3, #5.00000000
               	fadd	d20, d1, d3
               	fmov	d4, #6.00000000
               	fadd	d21, d1, d4
               	fmov	d4, #7.00000000
               	fadd	d22, d1, d4
               	fmov	d23, #8.00000000
               	fadd	d23, d1, d23
               	fmul	d24, d0, d1
               	fsub	d25, d0, d1
               	fmul	d2, d0, d2
               	fmul	d3, d1, d3
               	fadd	d26, d0, d1
               	fsub	d27, d1, d0
               	fmul	d0, d0, d4
               	fmov	d4, #9.00000000
               	fmul	d1, d1, d4
               	fmul	d4, d7, d19
               	fmadd	d4, d5, d6, d4
               	fmadd	d4, d20, d21, d4
               	fmadd	d4, d22, d23, d4
               	fmadd	d4, d24, d25, d4
               	fmadd	d2, d2, d3, d4
               	fmadd	d2, d26, d27, d2
               	fmadd	d0, d0, d1, d2
               	ret

<across>:
               	stp	d8, d9, [sp, #-0x90]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	fmov	d8, d0
               	fmov	d9, d1
               	fmov	d10, #2.00000000
               	fmov	d0, #3.00000000
               	fmul	d11, d8, d0
               	fmov	d1, #5.00000000
               	fmul	d12, d8, d1
               	fmov	d2, #7.00000000
               	fmul	d13, d8, d2
               	fmul	d14, d9, d10
               	fmul	d15, d9, d0
               	fmul	d16, d9, d1
               	str	d16, [sp, #0x78]
               	fmul	d16, d9, d2
               	str	d16, [sp, #0x70]
               	fadd	d16, d8, d9
               	str	d16, [sp, #0x68]
               	fsub	d16, d8, d9
               	str	d16, [sp, #0x60]
               	fmul	d16, d8, d9
               	str	d16, [sp, #0x58]
               	fmov	d0, #11.00000000
               	fadd	d16, d8, d0
               	str	d16, [sp, #0x50]
               	fmov	d0, d8
               	fmov	d1, d9
               	bl	<addr>
               	str	d0, [sp, #0x48]
               	fmov	d0, d9
               	fmov	d1, d8
               	bl	<addr>
               	ldr	d16, [sp, #0x48]
               	fadd	d0, d16, d0
               	fmadd	d0, d8, d10, d0
               	fmov	d1, #2.00000000
               	fmadd	d0, d11, d1, d0
               	fmov	d1, #3.00000000
               	fmadd	d0, d12, d1, d0
               	fmov	d1, #4.00000000
               	fmadd	d0, d13, d1, d0
               	fmov	d1, #5.00000000
               	fmadd	d0, d14, d1, d0
               	fmov	d1, #6.00000000
               	fmadd	d0, d15, d1, d0
               	fmov	d1, #7.00000000
               	ldr	d16, [sp, #0x78]
               	fmadd	d0, d16, d1, d0
               	fmov	d1, #8.00000000
               	ldr	d16, [sp, #0x70]
               	fmadd	d0, d16, d1, d0
               	fmov	d1, #9.00000000
               	ldr	d16, [sp, #0x68]
               	fmadd	d0, d16, d1, d0
               	fmov	d1, #10.00000000
               	ldr	d16, [sp, #0x60]
               	fmadd	d0, d16, d1, d0
               	fmov	d1, #11.00000000
               	ldr	d16, [sp, #0x58]
               	fmadd	d0, d16, d1, d0
               	fmov	d1, #12.00000000
               	ldr	d16, [sp, #0x50]
               	fmadd	d0, d16, d1, d0
               	ldp	x29, x30, [sp, #0x80]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret

<across_ref>:
               	add	x2, x0, #0x1
               	add	x3, x0, #0x2
               	add	x4, x0, #0x3
               	add	x5, x0, #0x4
               	mul	x4, x4, x5
               	madd	x2, x2, x3, x4
               	add	x3, x1, #0x5
               	add	x4, x1, #0x6
               	madd	x2, x3, x4, x2
               	add	x3, x1, #0x7
               	add	x4, x1, #0x8
               	madd	x4, x3, x4, x2
               	mul	x2, x0, x1
               	sub	x3, x0, x1
               	madd	x4, x2, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x5, x0, x17
               	mul	x6, x5, x1
               	mov	x17, #0x5               // =5
               	mul	x6, x6, x17
               	add	x7, x4, x6
               	add	x4, x0, x1
               	sub	x6, x1, x0
               	madd	x8, x4, x6, x7
               	mov	x17, #0x7               // =7
               	mul	x7, x0, x17
               	mul	x9, x7, x1
               	mov	x17, #0x9               // =9
               	mul	x9, x9, x17
               	add	x9, x8, x9
               	add	x8, x1, #0x1
               	add	x10, x1, #0x2
               	add	x11, x1, #0x3
               	add	x12, x1, #0x4
               	mul	x11, x11, x12
               	madd	x8, x8, x10, x11
               	add	x10, x0, #0x5
               	add	x11, x0, #0x6
               	madd	x8, x10, x11, x8
               	add	x10, x0, #0x7
               	add	x11, x0, #0x8
               	madd	x8, x10, x11, x8
               	madd	x8, x2, x6, x8
               	mov	x17, #0x3               // =3
               	mul	x6, x1, x17
               	mul	x10, x6, x0
               	mov	x17, #0x5               // =5
               	mul	x10, x10, x17
               	add	x8, x8, x10
               	madd	x10, x4, x3, x8
               	mov	x17, #0x7               // =7
               	mul	x8, x1, x17
               	mul	x11, x8, x0
               	mov	x17, #0x9               // =9
               	mul	x11, x11, x17
               	add	x10, x10, x11
               	add	x9, x9, x10
               	lsl	x10, x0, #1
               	add	x9, x9, x10
               	lsl	x5, x5, #1
               	add	x5, x9, x5
               	mov	x17, #0x5               // =5
               	mul	x9, x0, x17
               	mov	x17, #0x3               // =3
               	mul	x9, x9, x17
               	add	x5, x5, x9
               	lsl	x7, x7, #2
               	add	x5, x5, x7
               	lsl	x7, x1, #1
               	mov	x17, #0x5               // =5
               	mul	x7, x7, x17
               	add	x5, x5, x7
               	mov	x17, #0x6               // =6
               	mul	x6, x6, x17
               	add	x5, x5, x6
               	mov	x17, #0x5               // =5
               	mul	x1, x1, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x5, x1
               	lsl	x5, x8, #3
               	add	x1, x1, x5
               	mov	x17, #0x9               // =9
               	mul	x4, x4, x17
               	add	x1, x1, x4
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	mov	x17, #0xb               // =11
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	add	x0, x0, #0xb
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret

<main>:
               	str	d8, [sp, #-0x40]!
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x0               // =0
               	mov	x21, #0x3               // =3
               	mov	x22, #0x5               // =5
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	mov	x0, #0x5cc              // =1484
               	scvtf	d1, x0
               	fcmp	d0, d1
               	b.eq	<addr>
               	lsl	x0, x20, #1
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	scvtf	d0, x0
               	fcmp	d8, d0
               	b.eq	<addr>
               	lsl	x0, x20, #1
               	add	x0, x0, #0x2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
               	mov	x20, #0x1               // =1
               	mov	x21, #-0x4              // =-4
               	mov	x22, #0x9               // =9
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	mov	x0, #-0x6fb             // =-1787
               	scvtf	d1, x0
               	fcmp	d0, d1
               	b.ne	<addr>
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	scvtf	d0, x0
               	fcmp	d8, d0
               	b.ne	<addr>
               	mov	x20, #0x2               // =2
               	mov	x21, #0x3e8             // =1000
               	mov	x22, #-0x4d             // =-77
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	mov	x0, #-0x62fb            // =-25339
               	movk	x0, #0xfac2, lsl #16
               	scvtf	d1, x0
               	fcmp	d0, d1
               	b.ne	<addr>
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	scvtf	d0, x0
               	fcmp	d8, d0
               	b.ne	<addr>
               	mov	x20, #0x3               // =3
               	mov	x21, #0x0               // =0
               	mov	x22, #0x1               // =1
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	mov	x0, #0x81               // =129
               	scvtf	d1, x0
               	fcmp	d0, d1
               	b.ne	<addr>
               	scvtf	d0, x21
               	scvtf	d1, x22
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	scvtf	d0, x0
               	fcmp	d8, d0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
