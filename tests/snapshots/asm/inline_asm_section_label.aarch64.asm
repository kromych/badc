
inline_asm_section_label.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x280              // =640
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	mov	x17, #0x74              // =116
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x67              // =103
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w1, [x0, #0x3]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x1, x1, x0
               	cmp	x1, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x63
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x1, [x0, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x0, [x0, #0x8]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x2a               // =42
               	ret
               	b	<addr>
               	b	<addr>
