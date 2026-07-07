
int_to_float_assign_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sub	x0, x29, #0x8
               	mov	x1, #0xa                // =10
               	strb	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x64               // =100
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x8
               	mov	x1, #0xc8               // =200
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	scvtf	s0, x0
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	scvtf	s2, x0
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x2]
               	scvtf	s1, x0
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fmul	s3, s0, s17
               	fcvtzs	x0, s3
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fmul	s3, s2, s17
               	fcvtzs	x0, s3
               	cmp	x0, #0x3e8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fmul	s3, s1, s17
               	fcvtzs	x0, s3
               	cmp	x0, #0x7d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	scvtf	s3, x0
               	mov	x0, #0x42c80000         // =1120403456
               	fmov	s17, w0
               	fmul	s3, s3, s17
               	fcvtzs	x0, s3
               	mov	x17, #0x2710            // =10000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x1687             // =5767
               	movk	x0, #0x3e99, lsl #16
               	mov	x1, #0x45a2             // =17826
               	movk	x1, #0x3f16, lsl #16
               	fmov	s16, w1
               	fmul	s2, s16, s2
               	fmov	s16, w0
               	fmadd	s0, s16, s0, s2
               	mov	x0, #0x78d5             // =30933
               	movk	x0, #0x3de9, lsl #16
               	fmov	s16, w0
               	fmadd	s0, s16, s1, s0
               	mov	x0, #0x43000000         // =1124073472
               	fmov	s17, w0
               	fsub	s0, s0, s17
               	mov	x0, #0x422c0000         // =1110179840
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, gt
               	cbnz	x0, <addr>
               	mov	x0, #0x42300000         // =1110441984
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	s0, x0
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	b	<addr>
