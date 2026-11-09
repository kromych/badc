
fp_direct_width_cast.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #-5.00000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16]
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s0, #14.00000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s0, w16
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x4]
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	movi	d0, #0000000000000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x16, #0x5f000000        // =1593835520
               	fmov	s0, w16
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
