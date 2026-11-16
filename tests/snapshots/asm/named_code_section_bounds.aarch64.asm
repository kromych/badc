
named_code_section_bounds.aarch64:	file format elf64-littleaarch64

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

<outside>:
               	sub	x0, x0, #0x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x2, x0
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x2, x1
               	b.hs	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x2, x0
               	b.lo	<addr>
               	cmp	x2, x1
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x2, x0
               	b.lo	<addr>
               	cmp	x2, x1
               	b.hs	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x8
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>

<first>:
               	add	x0, x0, #0x1
               	ret

<second>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	lsl	x0, x0, #1
               	ldp	x29, x30, [sp], #0x10
               	ret
