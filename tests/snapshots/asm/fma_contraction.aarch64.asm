
fma_contraction.aarch64:	file format elf64-littleaarch64

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

<dmadd>:
               	fmadd	d0, d0, d1, d2
               	ret

<dmsub>:
               	fnmsub	d0, d0, d1, d2
               	ret

<dnmadd>:
               	fmsub	d0, d0, d1, d2
               	ret

<fmadd_>:
               	fmadd	s0, s0, s1, s2
               	ret

<fmsub_>:
               	fnmsub	s0, s0, s1, s2
               	ret

<fnmadd_>:
               	fmsub	s0, s0, s1, s2
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x30]!
               	str	d10, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	fmov	d0, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d1, #4.00000000
               	fmadd	d5, d0, d2, d1
               	fmov	d6, #10.00000000
               	fcmp	d5, d6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fnmsub	d3, d0, d2, d1
               	fcmp	d3, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmsub	d1, d0, d2, d1
               	fneg	d3, d0
               	fcmp	d1, d3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	s1, #2.00000000
               	fmov	s3, #3.00000000
               	fmov	s4, #4.00000000
               	fmadd	s7, s1, s3, s4
               	fmov	s8, #10.00000000
               	fcmp	s7, s8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fnmsub	s9, s1, s3, s4
               	fcmp	s9, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmsub	s3, s1, s3, s4
               	fneg	s1, s1
               	fcmp	s3, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d3, #0.50000000
               	fmov	d1, #0.25000000
               	fmov	d4, #0.12500000
               	fmadd	d3, d3, d1, d4
               	fcmp	d3, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	s9, #0.50000000
               	fmov	s4, #0.25000000
               	fmov	s10, #0.12500000
               	fmadd	s9, s9, s4, s10
               	fcmp	s9, s4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fcmp	d5, d6
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fcmp	d3, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fcmp	s7, s8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d1, #4.00000000
               	fmadd	d0, d0, d2, d1
               	fmov	d1, #10.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
