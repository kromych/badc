
float_register_resident.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x0, #0x0                // =0
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x1                // =1
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x2                // =2
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x3                // =3
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x4                // =4
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x5                // =5
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x6                // =6
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x7                // =7
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x8                // =8
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x9                // =9
               	scvtf	s0, x0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvtzs	x0, s0
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
