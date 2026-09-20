
flexible_array_member_after_tentative_decl.aarch64:	file format elf64-littleaarch64

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

<early_ref>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0x5a5a            // =23130
               	movk	x17, #0x5a5a, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x0, x0, #0x10
               	ldr	x1, [x0]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0xb
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	cmp	x1, #0xc
               	b.ne	<addr>
               	ldr	x1, [x0, #0x18]
               	cmp	x1, #0xd
               	b.ne	<addr>
               	ldr	x1, [x0, #0x20]
               	cmp	x1, #0xe
               	b.ne	<addr>
               	ldr	x1, [x0, #0x28]
               	cmp	x1, #0xf
               	b.ne	<addr>
               	ldr	x1, [x0, #0x30]
               	cmp	x1, #0x10
               	b.ne	<addr>
               	ldr	x1, [x0, #0x38]
               	cmp	x1, #0x11
               	b.ne	<addr>
               	ldr	x1, [x0, #0x40]
               	cmp	x1, #0x12
               	b.ne	<addr>
               	ldr	x1, [x0, #0x48]
               	cmp	x1, #0x13
               	b.ne	<addr>
               	ldr	x0, [x0, #0x50]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
