
inline_asm_a64_ldst_modes.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	mov	x17, #0x8               // =8
               	add	x16, x16, x17
               	ldur	x2, [x16, #-0x8]
               	ldr	x3, [x0, #0x8]!
               	mov	x16, x0
               	ldr	x4, [x16], #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, #0x6               // =6
               	strb	w16, [x0, #0x1]!
               	mov	x1, x0
               	ldrb	w0, [x1], #0x1
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	mov	x17, #0x10              // =16
               	add	x16, x16, x17
               	ldp	x5, x6, [x16, #-0x10]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	mov	x17, #0x3               // =3
               	ldr	x7, [x16, w17, sxtw #3]
               	cmp	x0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x2
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x0, x2, x3
               	add	x0, x0, x4
               	add	x1, x0, x5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x18]
               	sub	x2, x6, x2
               	add	x1, x1, x2
               	add	x1, x1, x7
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	ret
