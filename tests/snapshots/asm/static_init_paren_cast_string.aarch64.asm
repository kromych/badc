
static_init_paren_cast_string.aarch64:	file format elf64-littleaarch64

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
               	ldr	x1, [x0]
               	ldrb	w2, [x1]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w1, [x1, #0x5]
               	cmp	w1, #0x1a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrb	w2, [x1]
               	cmp	w2, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrb	w1, [x1, #0x9]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0, #0x9]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
