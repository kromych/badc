
float_register_resident.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	scvtf	s0, x0
               	mov	x1, #0x3f000000         // =1056964608
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fmov	s18, w2
               	fmadd	s1, s0, s17, s18
               	mov	x2, #0x1                // =1
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x2                // =2
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x3                // =3
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x4                // =4
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x5                // =5
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x6                // =6
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x7                // =7
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x8                // =8
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s1, s0, s17, s1
               	mov	x2, #0x9                // =9
               	scvtf	s0, x2
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	fcvtzs	x0, s0
               	sxtw	x0, w0
               	ret
