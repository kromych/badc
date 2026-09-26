
typedef_member_types.aarch64:	file format elf64-littleaarch64

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

<twice>:
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	ret

<half>:
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	ret

<get>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<get_half>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<pick>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	fmov	d0, #3.00000000
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	blr	x0
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	blr	x0
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
