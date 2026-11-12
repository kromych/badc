
typedef_pointer_array.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	ldrsw	x0, [x0, #0x30]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x38]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x18]
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x1c]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x20]
               	add	x0, x0, x1
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x64
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
