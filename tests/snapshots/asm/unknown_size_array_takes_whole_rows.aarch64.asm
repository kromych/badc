
unknown_size_array_takes_whole_rows.aarch64:	file format elf64-littleaarch64

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

<file_scope>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x7]
               	mov	x17, #0x66              // =102
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x9]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x1c]
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x14]
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret

<block_scope>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	b	<addr>
