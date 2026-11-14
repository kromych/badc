
msvc_pragma_operator_in_place.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
