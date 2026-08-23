
libc_math_hyperbolic.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x0               // =0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x21, #0xd695            // =54933
               	movk	x21, #0xe826, lsl #16
               	movk	x21, #0x2e0b, lsl #32
               	movk	x21, #0x3e11, lsl #48
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	mov	x20, #0x0               // =0
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d17, x22
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x22, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d17, x22
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x20, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x21, #0xd695            // =54933
               	movk	x21, #0xe826, lsl #16
               	movk	x21, #0x2e0b, lsl #32
               	movk	x21, #0x3e11, lsl #48
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x22, #0x0               // =0
               	fmov	d0, x22
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x20, #0x0               // =0
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	fmov	d0, x22
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
