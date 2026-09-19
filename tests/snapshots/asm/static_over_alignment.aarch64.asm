
static_over_alignment.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	and	x2, x0, #0x3f
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x9                // =9
               	strb	w2, [x0]
               	and	x2, x0, #0xfff
               	cbz	x2, <addr>
               	mov	x0, x1
               	ret
               	ldrb	w0, [x0]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0x7f
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	ldr	x0, [x0]
               	b	<addr>
