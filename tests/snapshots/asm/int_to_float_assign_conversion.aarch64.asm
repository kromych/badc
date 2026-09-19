
int_to_float_assign_conversion.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xa                // =10
               	scvtf	s2, x0
               	mov	x0, #0x64               // =100
               	scvtf	s0, x0
               	mov	x0, #0xc8               // =200
               	scvtf	s3, x0
               	fmov	s1, #10.00000000
               	fmul	s4, s2, s1
               	fcvtzs	x0, s4
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	s4, s0, s1
               	fcvtzs	x0, s4
               	cmp	x0, #0x3e8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	s1, s3, s1
               	fcvtzs	x0, s1
               	cmp	x0, #0x7d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s1, w16
               	fmul	s1, s0, s1
               	fcvtzs	x0, s1
               	mov	x17, #0x2710            // =10000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x1c]
               	adrp	x16, <page>
               	ldr	s4, [x16, #0x20]
               	fmul	s0, s4, s0
               	fmadd	s0, s1, s2, s0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x24]
               	fmadd	s0, s1, s3, s0
               	mov	x16, #0x43000000        // =1124073472
               	fmov	s1, w16
               	fsub	s0, s0, s1
               	mov	x16, #0x422c0000        // =1110179840
               	fmov	s1, w16
               	fneg	s1, s1
               	fcmp	s0, s1
               	b.gt	<addr>
               	mov	x16, #0x42300000        // =1110441984
               	fmov	s1, w16
               	fneg	s1, s1
               	fcmp	s0, s1
               	b.pl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	s0, x0
               	fmov	s1, #7.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
