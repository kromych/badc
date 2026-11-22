
file_scope_asm_incbin_skip_count.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	cmp	w2, #0x50
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	ret
               	mov	x2, #0x1                // =1
               	ldrb	w3, [x1, #0x1]
               	cmp	w3, #0x41
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x2                // =2
               	ldrb	w3, [x1, #0x2]
               	cmp	w3, #0x59
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x3                // =3
               	ldrb	w3, [x1, #0x3]
               	cmp	w3, #0x4c
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x4                // =4
               	ldrb	w3, [x1, #0x4]
               	cmp	w3, #0x4f
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x5                // =5
               	ldrb	w3, [x1, #0x5]
               	cmp	w3, #0x41
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x6                // =6
               	ldrb	w3, [x1, #0x6]
               	cmp	w3, #0x44
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x1, x1, #0x7
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	sub	x1, x1, x2
               	cmp	x1, #0x2
               	b.ne	<addr>
               	ldrb	w1, [x2]
               	cmp	w1, #0x30
               	b.ne	<addr>
               	ldrb	w1, [x2, #0x1]
               	cmp	w1, #0x31
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	ret
