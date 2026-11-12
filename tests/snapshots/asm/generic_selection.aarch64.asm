
generic_selection.aarch64:	file format elf64-littleaarch64

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

<touched>:
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x44]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x44]
               	mov	x0, #-0x1               // =-1
               	ret

<chosen>:
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	str	w0, [x1, #0x44]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cmp	w2, #0x64
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x18]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x1c]
               	cmp	w1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	ret
