
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
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x1, x1, #0xffff
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x1, x1, #0xffff
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x1, x1, #0xffff
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x1, x1, #0xffff
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x10, lsl #12  // =0x10000
               	and	x1, x1, #0xffff
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	add	x1, x0, #0x1
               	and	x1, x1, #0xffff
               	cbnz	x1, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	add	x0, x0, #0x8, lsl #12   // =0x8000
               	and	x0, x0, #0xffff
               	cbnz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x16               // =22
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x10, lsl #12  // =0x10000
               	mov	x2, #0x21               // =33
               	str	x2, [x1]
               	ldr	x0, [x0]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x16
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10, lsl #12  // =0x10000
               	ldr	x0, [x0]
               	cmp	x0, #0x21
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
