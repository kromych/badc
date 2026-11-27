
fp_contract_stays_within_an_expression.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x10]
               	adrp	x0, <page>
               	ldr	d2, [x0, #0x18]
               	adrp	x0, <page>
               	ldr	s1, [x0, #0x20]
               	adrp	x16, <page>
               	ldr	s3, [x16]
               	fmul	s1, s3, s1
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x4]
               	fsub	s1, s1, s3
               	movi	d3, #0000000000000000
               	fcmp	s1, s3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmul	d1, d0, d0
               	fsub	d1, d1, d2
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.ne	<addr>
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fnmsub	d1, d0, d0, d2
               	fneg	d2, d2
               	fmadd	d0, d0, d0, d2
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.eq	<addr>
               	mov	x16, #0x3c30000000000000 // =4336966441157787648
               	fmov	d2, x16
               	fcmp	d1, d2
               	b.ne	<addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x16, #0x3c30000000000000 // =4336966441157787648
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ret
