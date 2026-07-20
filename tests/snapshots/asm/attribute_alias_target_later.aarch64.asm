
attribute_alias_target_later.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x1, x2, x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<after_alias>:
               	mov	x0, #0x5                // =5
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x2
               	str	w1, [x0]
               	sxtw	x1, w1
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x4
               	str	w1, [x0]
               	sxtw	x0, w1
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
