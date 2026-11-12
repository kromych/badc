
ssa_variadic_fp_arg.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	d0, [x1, #0x10]
               	bl	<addr>
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x18]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	ldr	d0, [x1]
               	adrp	x1, <page>
               	ldr	d1, [x1, #0x10]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x10]
               	adrp	x16, <addr>
               	ldr	d1, [x16, #0x18]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
