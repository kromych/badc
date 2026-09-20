
ssa_fp_compare_nan.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	mov	x1, #0x1                // =1
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.le	<addr>
               	orr	x1, x1, #0x2
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.hi	<addr>
               	orr	x1, x1, #0x4
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.lt	<addr>
               	orr	x1, x1, #0x8
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	orr	x1, x1, #0x10
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	orr	x1, x1, #0x20
               	fcmp	d0, d0
               	b.pl	<addr>
               	orr	x1, x1, #0x40
               	fcmp	d0, d0
               	b.ne	<addr>
               	orr	x1, x1, #0x80
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
