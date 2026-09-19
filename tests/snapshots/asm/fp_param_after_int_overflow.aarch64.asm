
fp_param_after_int_overflow.aarch64:	file format elf64-littleaarch64

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

<tail_double>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldrsw	x1, [x29, #0x10]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	scvtf	d1, x0
               	fadd	d0, d1, d0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	mov	x8, #0x9                // =9
               	fmov	d0, #0.50000000
               	sub	sp, sp, #0x10
               	str	x8, [sp]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	mov	x1, #0x14               // =20
               	mov	x2, #0x1e               // =30
               	mov	x3, #0x28               // =40
               	mov	x4, #0x32               // =50
               	mov	x5, #0x3c               // =60
               	mov	x6, #0x46               // =70
               	mov	x7, #0x50               // =80
               	mov	x8, #0x5a               // =90
               	fmov	d0, #0.25000000
               	sub	sp, sp, #0x10
               	str	x8, [sp]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
