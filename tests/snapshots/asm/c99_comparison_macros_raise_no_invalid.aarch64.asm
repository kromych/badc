
c99_comparison_macros_raise_no_invalid.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x16, #0x7ff8000000000000 // =9221120237041090560
               	fmov	d0, x16
               	stur	d0, [x29, #-0x38]
               	fmov	d0, #1.00000000
               	stur	d0, [x29, #-0x30]
               	fmov	d0, #2.00000000
               	stur	d0, [x29, #-0x28]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	stur	d0, [x29, #-0x20]
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x18]
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s0, w16
               	stur	s0, [x29, #-0x10]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x100, lsl #16
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.gt	<addr>
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.ge	<addr>
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.mi	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	b.ls	<addr>
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.mi	<addr>
               	b.gt	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	b.vs	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	b.gt	<addr>
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	b.mi	<addr>
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	b.mi	<addr>
               	b.gt	<addr>
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	b.vs	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x28]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.le	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.lt	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x28]
               	fcmp	d0, d1
               	b.pl	<addr>
               	ldur	d0, [x29, #-0x28]
               	ldur	d1, [x29, #-0x28]
               	fcmp	d0, d1
               	b.hi	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x28]
               	fcmp	d0, d1
               	b.eq	<addr>
               	b.vs	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.mi	<addr>
               	b.gt	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x28]
               	fcmp	d0, d1
               	b.vc	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.00000000
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.le	<addr>
               	ldur	s0, [x29, #-0x18]
               	fcvt	d0, s0
               	ldur	d1, [x29, #-0x28]
               	fcmp	d0, d1
               	b.pl	<addr>
               	ldur	s0, [x29, #-0x18]
               	fcvt	d0, s0
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.eq	<addr>
               	b.vs	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	scvtf	s0, x0
               	ldur	s1, [x29, #-0x10]
               	fcmp	s0, s1
               	b.mi	<addr>
               	b.gt	<addr>
               	ldursw	x0, [x29, #-0x8]
               	scvtf	s0, x0
               	ldur	s1, [x29, #-0x10]
               	fcmp	s0, s1
               	b.ls	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x20]
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x30]
               	fcmp	d0, d1
               	b.le	<addr>
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x20]
               	fneg	d1, d1
               	fcmp	d0, d1
               	b.vs	<addr>
               	ldur	d0, [x29, #-0x20]
               	fneg	d0, d0
               	ldur	d1, [x29, #-0x20]
               	fcmp	d0, d1
               	b.mi	<addr>
               	b.gt	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x9                // =9
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x1, x2, ne
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
