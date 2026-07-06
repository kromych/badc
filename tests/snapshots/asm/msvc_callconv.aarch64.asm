
msvc_callconv.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<add_cdecl>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<add_fast>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<record>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x0, x2, x0
               	str	w0, [x1]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x14               // =20
               	mov	x2, #0x16               // =22
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	add	x0, x0, #0x2
               	add	x0, x0, #0x7
               	sxtw	x21, w0
               	mov	x9, x20
               	mov	x0, x21
               	blr	x9
               	cmp	x21, #0x33
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x33
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>
