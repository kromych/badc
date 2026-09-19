
int_times_double_into_local.aarch64:	file format elf64-littleaarch64

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

<compute>:
               	sxtw	x1, w1
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	mov	x2, #-0x4000000000000000 // =-4611686018427387904
               	fmov	d16, x2
               	fmov	d17, x0
               	fmul	d0, d16, d17
               	scvtf	d1, x1
               	fmul	d0, d0, d1
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2d18             // =11544
               	movk	x1, #0x5444, lsl #16
               	movk	x1, #0x21fb, lsl #32
               	movk	x1, #0x4009, lsl #48
               	mov	x2, #-0x4000000000000000 // =-4611686018427387904
               	fmov	d16, x2
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	scvtf	d1, x0
               	fmul	d1, d0, d1
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x2, #0x1                // =1
               	scvtf	d1, x2
               	fmul	d1, d0, d1
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	fneg	d2, d16
               	fmov	d17, x1
               	fmul	d2, d2, d17
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x2, #0x2                // =2
               	scvtf	d1, x2
               	fmul	d0, d0, d1
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x2
               	fneg	d1, d16
               	fmov	d17, x1
               	fmul	d1, d1, d17
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ret
