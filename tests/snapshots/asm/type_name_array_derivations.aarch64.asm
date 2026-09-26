
type_name_array_derivations.aarch64:	file format elf64-littleaarch64

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

<half>:
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	ret

<twice>:
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	ret

<pick>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #4.00000000
               	bl	<addr>
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #5.00000000
               	blr	x0
               	fmov	d1, #10.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #7.00000000
               	bl	<addr>
               	fmov	d1, #14.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #7.00000000
               	bl	<addr>
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x38]
               	sub	x0, x29, #0x38
               	stur	x0, [x29, #-0x30]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x30]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x30]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d1, #9.00000000
               	fmov	d0, #2.00000000
               	fdiv	d1, d1, d0
               	fmov	d2, #4.50000000
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
