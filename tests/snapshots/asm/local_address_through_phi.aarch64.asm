
local_address_through_phi.aarch64:	file format elf64-littleaarch64

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

<fill>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldrb	w16, [x1, #0xc]
               	strb	w16, [x0, #0xc]
               	mov	x0, #0xd                // =13
               	ret

<keep>:
               	adrp	x1, <page>
               	str	x0, [x1, #0x20]
               	ret

<dir_length>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	mov	x1, #0x3f               // =63
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x0
               	b.le	<addr>
               	sub	x0, x29, #0x40
               	strb	wzr, [x0, x1]
               	cbz	x0, <addr>
               	bl	<addr>
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x1               // =-1
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, x20
               	bl	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0xd
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
