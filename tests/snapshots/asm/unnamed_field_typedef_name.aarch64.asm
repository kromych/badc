
unnamed_field_typedef_name.aarch64:	file format elf64-littleaarch64

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
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x2
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x1, [x0, #0x18]
               	cmp	x1, #0x6
               	b.ne	<addr>
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x29               // =41
               	ret
               	mov	x0, #0x0                // =0
               	ret
