
undeclared_library_calls_keep_the_header_types.aarch64:	file format elf64-littleaarch64

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
               	str	d8, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	fmov	d8, d0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fmov	d0, d8
               	bl	<addr>
               	fmov	d0, #1.50000000
               	fcmp	d8, d0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	orr	x0, x1, x0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
