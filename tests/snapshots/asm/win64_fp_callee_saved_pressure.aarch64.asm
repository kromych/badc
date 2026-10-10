
win64_fp_callee_saved_pressure.aarch64:	file format elf64-littleaarch64

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

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mix3>:
               	stp	d8, d9, [sp, #-0x40]!
               	stp	d10, d11, [sp, #0x10]
               	str	d12, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	fmov	d8, d0
               	fmov	d10, d3
               	fmov	d11, d2
               	fmov	d9, d1
               	fmov	d0, d9
               	bl	<addr>
               	fmov	d12, d0
               	fmov	d0, d8
               	bl	<addr>
               	fmul	d0, d11, d0
               	fmadd	d8, d8, d12, d0
               	fmov	d0, d10
               	bl	<addr>
               	fmadd	d0, d9, d0, d8
               	fadd	d0, d0, d10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret

<pressure>:
               	stp	d8, d9, [sp, #-0x80]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	stur	d0, [x29, #-0x10]
               	stur	d1, [x29, #-0x8]
               	ldur	d0, [x29, #-0x10]
               	fmov	d1, #1.00000000
               	fadd	d0, d0, d1
               	ldur	d1, [x29, #-0x8]
               	fmov	d2, #2.00000000
               	fadd	d16, d1, d2
               	str	d16, [sp, #0x48]
               	ldur	d1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fmov	d3, #3.00000000
               	fmadd	d15, d1, d2, d3
               	ldur	d1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fsub	d1, d1, d2
               	fmov	d2, #4.00000000
               	fadd	d16, d1, d2
               	str	d16, [sp, #0x58]
               	ldur	d1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fmov	d3, #5.00000000
               	fmadd	d18, d2, d3, d1
               	str	d18, [sp, #0x50]
               	ldur	d1, [x29, #-0x10]
               	fmov	d2, #6.00000000
               	ldur	d3, [x29, #-0x8]
               	fmadd	d8, d1, d2, d3
               	ldur	d1, [x29, #-0x10]
               	fmov	d2, #7.00000000
               	fdiv	d1, d1, d2
               	ldur	d2, [x29, #-0x8]
               	fadd	d9, d1, d2
               	ldur	d1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fmov	d3, #8.00000000
               	fdiv	d2, d2, d3
               	fadd	d10, d1, d2
               	ldur	d1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fmov	d3, #9.00000000
               	fmadd	d11, d1, d2, d3
               	ldur	d1, [x29, #-0x10]
               	fmov	d2, #10.00000000
               	ldur	d3, [x29, #-0x8]
               	fmadd	d12, d1, d2, d3
               	ldur	d1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fmov	d3, #11.00000000
               	fmadd	d13, d2, d3, d1
               	fmov	d2, d15
               	fmov	d3, d13
               	ldr	d1, [sp, #0x48]
               	bl	<addr>
               	fmov	d14, d0
               	fmov	d1, d15
               	fmov	d3, d12
               	ldr	d0, [sp, #0x48]
               	ldr	d2, [sp, #0x58]
               	bl	<addr>
               	str	d0, [sp, #0x48]
               	fmov	d0, d15
               	fmov	d3, d11
               	ldr	d1, [sp, #0x58]
               	ldr	d2, [sp, #0x50]
               	bl	<addr>
               	fmov	d15, d0
               	fmov	d2, d8
               	fmov	d3, d10
               	ldr	d0, [sp, #0x58]
               	ldr	d1, [sp, #0x50]
               	bl	<addr>
               	str	d0, [sp, #0x58]
               	fmov	d1, d8
               	fmov	d3, d9
               	fmov	d2, d9
               	ldr	d0, [sp, #0x50]
               	bl	<addr>
               	str	d0, [sp, #0x50]
               	fmov	d0, d8
               	fmov	d3, d8
               	fmov	d2, d10
               	fmov	d1, d9
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, d9
               	fmov	d2, d11
               	fmov	d1, d10
               	ldr	d3, [sp, #0x50]
               	bl	<addr>
               	fmov	d9, d0
               	fmov	d0, d10
               	fmov	d2, d12
               	fmov	d1, d11
               	ldr	d3, [sp, #0x58]
               	bl	<addr>
               	fmov	d10, d0
               	fmov	d0, d11
               	fmov	d3, d15
               	fmov	d2, d13
               	fmov	d1, d12
               	bl	<addr>
               	fmov	d11, d0
               	fmov	d0, d12
               	fmov	d2, d14
               	fmov	d1, d13
               	ldr	d3, [sp, #0x48]
               	bl	<addr>
               	fmov	d12, d0
               	fmov	d0, d13
               	fmov	d3, d14
               	fmov	d1, d14
               	ldr	d2, [sp, #0x48]
               	bl	<addr>
               	ldr	d17, [sp, #0x48]
               	fadd	d1, d14, d17
               	fadd	d1, d1, d15
               	ldr	d17, [sp, #0x58]
               	fadd	d1, d1, d17
               	ldr	d17, [sp, #0x50]
               	fadd	d1, d1, d17
               	fadd	d1, d1, d8
               	fadd	d1, d1, d9
               	fadd	d1, d1, d10
               	fadd	d1, d1, d11
               	fadd	d1, d1, d12
               	fadd	d0, d1, d0
               	ldp	x29, x30, [sp, #0x70]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x80
               	ret

<main>:
               	str	d8, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	fmov	d0, #0.50000000
               	fmov	d1, #2.00000000
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, #0.50000000
               	fmov	d1, #2.00000000
               	bl	<addr>
               	fcmp	d8, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d8, d17
               	b.hi	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
