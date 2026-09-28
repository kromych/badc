
inline_asm_a64_fmov_forms.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	fmov	d0, x0
               	fmov	x2, d0
               	fmov	s1, w1
               	fmov	w3, s1
               	fmov	d0, x0
               	fmov	d2, d0
               	fmov	x4, d2
               	fmov	s1, w1
               	fmov	s3, s1
               	fmov	w1, s3
               	fmov	d4, #-2.50000000
               	fmov	x5, d4
               	fmov	s5, #0.12500000
               	fmov	w6, s5
               	fmov	v6.d[1], x0
               	fmov	x7, v6.d[1]
               	fmov	v7.d[1], x0
               	fmov	s7, w0
               	fmov	x0, v7.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x17, #-0x3ffc000000000000 // =-4610560118520545280
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x17, #0x3e000000        // =1040187392
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x7, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x2a               // =42
               	ret
