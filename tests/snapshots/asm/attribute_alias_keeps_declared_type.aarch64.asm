
attribute_alias_keeps_declared_type.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x0, [x0, #0x14]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x28]
               	lsl	x0, x0, #1
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x38]
               	add	x0, x0, #0x1
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
