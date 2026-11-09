
kr_old_style_def.aarch64:	file format elf64-littleaarch64

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

<mix>:
               	sub	x0, x0, x2
               	and	x1, x1, #0xff
               	add	x0, x0, x1
               	ret

<first>:
               	ldrb	w0, [x0]
               	ret

<scale>:
               	sxtw	x0, w0
               	fcvt	s0, d0
               	scvtf	s1, x0
               	fmov	s2, #2.00000000
               	fmadd	s0, s0, s2, s1
               	and	x0, x1, #0xff
               	scvtf	s1, x0
               	fadd	s0, s0, s1
               	fcvt	d0, s0
               	ret

<halve>:
               	fcvt	s0, d0
               	fmov	s1, #2.00000000
               	fdiv	s0, s0, s1
               	and	x0, x0, #0xff
               	scvtf	s1, x0
               	fadd	s0, s0, s1
               	fcvt	d0, s0
               	ret

<main>:
               	mov	x16, #0x4048000000000000 // =4631952216750555136
               	fmov	d0, x16
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d0, #3.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
