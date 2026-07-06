
sysv_variadic_host_abi.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x18
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	ldursw	x0, [x29, #0x10]
               	ldursw	x1, [x29, #0x18]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	asr	x3, x2, #63
               	lsr	x3, x3, #63
               	add	x4, x2, x3
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	cmp	x3, #0x0
               	b.ne	<addr>
               	sub	x3, x29, #0x20
               	mov	x17, x3
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldr	x3, [x3]
               	add	x0, x0, x3
               	b	<addr>
               	sub	x3, x29, #0x20
               	mov	x17, x3
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldr	d0, [x3]
               	fcvtzs	x3, d0
               	add	x0, x0, x3
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0xa
               	b.lt	<addr>
               	sub	x1, x29, #0x20
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<fsum>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	b	<addr>
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldr	d1, [x2]
               	fadd	d0, d0, d1
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	ldursw	x2, [x29, #0x10]
               	cmp	x1, x2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	mov	x4, #0x3                // =3
               	mov	x5, #0x4010000000000000 // =4616189618054758400
               	mov	x6, #0x5                // =5
               	mov	x7, #0x4018000000000000 // =4618441417868443648
               	mov	x2, #0x7                // =7
               	mov	x8, #0x4020000000000000 // =4620693217682128896
               	mov	x9, #0x9                // =9
               	mov	x10, #0x4024000000000000 // =4621819117588971520
               	fmov	d0, x3
               	fmov	d1, x5
               	fmov	d2, x7
               	fmov	d3, x8
               	fmov	d4, x10
               	mov	x3, x4
               	mov	x4, x6
               	mov	x5, x2
               	mov	x2, x0
               	mov	x6, x9
               	bl	<addr>
               	cmp	x0, #0x3a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x3, #0x4008000000000000 // =4613937818241073152
               	mov	x4, #0x4010000000000000 // =4616189618054758400
               	mov	x5, #0x4014000000000000 // =4617315517961601024
               	mov	x6, #0x4018000000000000 // =4618441417868443648
               	mov	x7, #0x401c000000000000 // =4619567317775286272
               	mov	x8, #0x4020000000000000 // =4620693217682128896
               	mov	x9, #0x4022000000000000 // =4621256167635550208
               	sub	sp, sp, #0x10
               	str	x9, [sp]
               	fmov	d0, x1
               	fmov	d1, x2
               	fmov	d2, x3
               	fmov	d3, x4
               	fmov	d4, x5
               	fmov	d5, x6
               	fmov	d6, x7
               	fmov	d7, x8
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4046, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
