
unsigned_constant_to_floating.aarch64:	file format elf64-littleaarch64

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
               	ldr	s1, [x0]
               	mov	x16, #0x5f800000        // =1602224128
               	fmov	s0, w16
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d2, [x0]
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d1, x16
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d2, [x0]
               	mov	x16, #0x43e0000000000000 // =4890909195324358656
               	fmov	d3, x16
               	fcmp	d2, d3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s2, [x0]
               	fcmp	s2, s0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	mov	x16, #0x5f000000        // =1593835520
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	mov	x16, #0x43efffffffffffff // =4895412794951729151
               	fmov	d0, x16
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
