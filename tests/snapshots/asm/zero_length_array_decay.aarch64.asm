
zero_length_array_decay.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x1, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
