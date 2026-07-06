
int_to_float_assign_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	mov	x1, #0xa                // =10
               	strb	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x2, #0x64               // =100
               	strb	w2, [x0, #0x1]
               	sub	x0, x29, #0x8
               	mov	x2, #0xc8               // =200
               	strb	w2, [x0, #0x2]
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	scvtf	d1, x0
               	fcvt	s1, d1
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x2]
               	scvtf	d2, x0
               	fcvt	s2, d2
               	scvtf	d3, x1
               	fcvt	s3, d3
               	fmul	s3, s0, s3
               	fcvt	d3, s3
               	fcvtzs	x0, d3
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	scvtf	d3, x0
               	fcvt	s3, d3
               	fmul	s3, s1, s3
               	fcvt	d3, s3
               	fcvtzs	x0, d3
               	cmp	x0, #0x3e8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	scvtf	d3, x0
               	fcvt	s3, d3
               	fmul	s3, s2, s3
               	fcvt	d3, s3
               	fcvtzs	x0, d3
               	cmp	x0, #0x7d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	scvtf	d3, x0
               	fcvt	s3, d3
               	mov	x0, #0x64               // =100
               	scvtf	d4, x0
               	fcvt	s4, d4
               	fmul	s3, s3, s4
               	fcvt	d3, s3
               	fcvtzs	x0, d3
               	mov	x17, #0x2710            // =10000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1687             // =5767
               	movk	x0, #0x3e99, lsl #16
               	mov	x1, #0x45a2             // =17826
               	movk	x1, #0x3f16, lsl #16
               	fmov	s16, w1
               	fmul	s1, s16, s1
               	fmov	s16, w0
               	fmadd	s0, s16, s0, s1
               	mov	x0, #0x78d5             // =30933
               	movk	x0, #0x3de9, lsl #16
               	fmov	s16, w0
               	fmadd	s0, s16, s2, s0
               	mov	x0, #0x43000000         // =1124073472
               	fmov	s17, w0
               	fsub	s0, s0, s17
               	mov	x0, #0x422c0000         // =1110179840
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x1, gt
               	cbnz	x1, <addr>
               	mov	x0, #0x42300000         // =1110441984
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x1, mi
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
