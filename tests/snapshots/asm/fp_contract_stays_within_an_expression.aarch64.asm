
fp_contract_stays_within_an_expression.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s2, [x0]
               	adrp	x16, <page>
               	ldr	s3, [x16]
               	fmul	s2, s3, s2
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x4]
               	fsub	s2, s2, s3
               	movi	d3, #0000000000000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmul	d2, d0, d0
               	fsub	d2, d2, d1
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d2, d17
               	b.ne	<addr>
               	fmov	d17, x0
               	fcmp	d2, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d17, x0
               	fcmp	d2, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fnmsub	d2, d0, d0, d1
               	fneg	d1, d1
               	fmadd	d0, d0, d0, d1
               	fmov	d17, x0
               	fcmp	d2, d17
               	b.eq	<addr>
               	mov	x16, #0x3c30000000000000 // =4336966441157787648
               	fmov	d1, x16
               	fcmp	d2, d1
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
