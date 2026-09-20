
max_alignment_placement.aarch64:	file format elf64-littleaarch64

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
               	and	x1, x0, #0xffff
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x2, x1, #0xffff
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x2, x2, #0xffff
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x3, x2, #0xffff
               	cbz	x3, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x4, x3, #0xffff
               	cbz	x4, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	add	x3, x3, #0x10, lsl #12  // =0x10000
               	and	x4, x3, #0xffff
               	cbz	x4, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	add	x4, x0, #0x1
               	and	x4, x4, #0xffff
               	cbnz	w4, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	add	x0, x0, #0x8, lsl #12   // =0x8000
               	and	x0, x0, #0xffff
               	cbnz	w0, <addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x0, #0xb                // =11
               	str	x0, [x1]
               	mov	x0, #0x16               // =22
               	str	x0, [x2]
               	mov	x0, #0x21               // =33
               	str	x0, [x3]
               	ldr	x0, [x1]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	ldr	x0, [x2]
               	cmp	x0, #0x16
               	b.ne	<addr>
               	ldr	x0, [x3]
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
