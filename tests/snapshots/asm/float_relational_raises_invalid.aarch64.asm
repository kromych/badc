
float_relational_raises_invalid.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	fcvt	d1, s0
               	stur	d1, [x29, #-0x20]
               	fmov	d1, #1.00000000
               	stur	d1, [x29, #-0x18]
               	stur	s0, [x29, #-0x10]
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x8]
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fcmpe	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x20]
               	fcmpe	d0, d1
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	s0, [x29, #-0x10]
               	ldur	s1, [x29, #-0x8]
               	fcmpe	s0, s1
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fcmpe	d0, d1
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fcmp	d0, d1
               	b.eq	<addr>
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fcmp	d0, d1
               	b.mi	<addr>
               	ldur	d0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x20]
               	fcmp	d0, d1
               	b.ge	<addr>
               	ldur	s0, [x29, #-0x10]
               	ldur	s1, [x29, #-0x8]
               	fcmp	s0, s1
               	b.ls	<addr>
               	ldur	s0, [x29, #-0x10]
               	ldur	s1, [x29, #-0x8]
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
