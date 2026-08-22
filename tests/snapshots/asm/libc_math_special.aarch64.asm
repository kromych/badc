
libc_math_special.aarch64:	file format elf64-littleaarch64

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
               	str	d8, [sp, #-0x50]!
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x4038000000000000 // =4627448617123184640
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x20, #0x0               // =0
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x22, #0xed8d            // =60813
               	movk	x22, #0xa0b5, lsl #16
               	movk	x22, #0xc6f7, lsl #32
               	movk	x22, #0x3eb0, lsl #48
               	fmov	d17, x22
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x21
               	bl	<addr>
               	fmov	d17, x21
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x22
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	mov	x20, #0x0               // =0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x22
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d17, x21
               	fsub	d0, d0, d17
               	mov	x21, #0x0               // =0
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x22, #0xed8d            // =60813
               	movk	x22, #0xa0b5, lsl #16
               	movk	x22, #0xc6f7, lsl #32
               	movk	x22, #0x3eb0, lsl #48
               	fmov	d17, x22
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, x20
               	bl	<addr>
               	fadd	d0, d8, d0
               	fmov	d17, x20
               	fsub	d0, d0, d17
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x22
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	d0, x0
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x4038000000000000 // =4627448617123184640
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x22
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x1, #0xed8d             // =60813
               	movk	x1, #0xa0b5, lsl #16
               	movk	x1, #0xc6f7, lsl #32
               	movk	x1, #0x3eb0, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, mi
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
