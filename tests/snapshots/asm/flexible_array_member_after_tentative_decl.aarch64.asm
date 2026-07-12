
flexible_array_member_after_tentative_decl.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x3, x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	x0, [x3, #0x8]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x5a5a            // =23130
               	movk	x17, #0x5a5a, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x3, #0x10
               	ldr	x4, [x2, x1, lsl #3]
               	add	x2, x1, #0xa
               	sxtw	x2, w2
               	cmp	x4, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0xb
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x3, x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	b	<addr>
               	b	<addr>
