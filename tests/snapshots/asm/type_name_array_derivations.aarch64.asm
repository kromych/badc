
type_name_array_derivations.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #4.00000000
               	bl	<addr>
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #5.00000000
               	blr	x0
               	fmov	d1, #10.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #7.00000000
               	bl	<addr>
               	fmov	d1, #14.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #7.00000000
               	bl	<addr>
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.00000000
               	bl	<addr>
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
