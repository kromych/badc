
init_scalar_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<rect_ok>:
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fcmp	d2, d0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	fcmp	d3, d0
               	cset	x0, eq
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	movi	d0, #0000000000000000
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x8]
               	fmov	d1, d0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	movi	d0, #0000000000000000
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x8]
               	fmov	d1, d0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
