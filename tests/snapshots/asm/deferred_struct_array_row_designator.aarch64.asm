
deferred_struct_array_row_designator.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0, #0x20]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x2c]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x1c]
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x2c]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x18
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	w1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x1c]
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x0                // =0
               	ret
