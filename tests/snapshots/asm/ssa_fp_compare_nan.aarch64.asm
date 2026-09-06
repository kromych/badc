
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

<nan_value>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fdiv	d0, d0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.pl	<addr>
               	mov	x0, #0x1                // =1
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.le	<addr>
               	mov	x17, #0x2               // =2
               	orr	x0, x0, x17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.hi	<addr>
               	mov	x17, #0x4               // =4
               	orr	x0, x0, x17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.lt	<addr>
               	mov	x17, #0x8               // =8
               	orr	x0, x0, x17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x17, #0x10              // =16
               	orr	x0, x0, x17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x17, #0x20              // =32
               	orr	x0, x0, x17
               	fcmp	d0, d0
               	b.pl	<addr>
               	mov	x17, #0x40              // =64
               	orr	x0, x0, x17
               	fcmp	d0, d0
               	b.ne	<addr>
               	mov	x17, #0x80              // =128
               	orr	x0, x0, x17
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x2
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
