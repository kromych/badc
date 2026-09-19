
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
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fmov	d1, #-2.00000000
               	fmul	d0, d1, d0
               	scvtf	d1, x1
               	fmul	d0, d0, d1
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fmov	d0, #-2.00000000
               	fmul	d0, d0, d1
               	scvtf	d2, x0
               	fmul	d2, d0, d2
               	fmov	d17, x0
               	fcmp	d2, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x1                // =1
               	scvtf	d2, x1
               	fmul	d2, d0, d2
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x2                // =2
               	scvtf	d2, x1
               	fmul	d0, d0, d2
               	fmov	d2, #-4.00000000
               	fmul	d1, d2, d1
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ret
