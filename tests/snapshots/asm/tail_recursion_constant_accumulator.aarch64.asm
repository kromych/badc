
tail_recursion_constant_accumulator.aarch64:	file format elf64-littleaarch64

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

<depth>:
               	mov	x1, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	mov	x0, x1
               	ret

<down>:
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x0, #0x1
               	sub	x1, x1, #0x3
               	cbnz	x0, <addr>
               	add	x0, x1, #0x64
               	ret

<twice>:
               	mov	x1, #0x1                // =1
               	cbz	x0, <addr>
               	sub	x0, x0, #0x1
               	lsl	x1, x1, #1
               	cbnz	x0, <addr>
               	mov	x0, x1
               	ret

<wrap>:
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x0, #0x1
               	sub	x1, x1, #0x7
               	cbnz	x0, <addr>
               	add	x0, x1, #0x5
               	ret

<times8>:
               	mov	x1, #0x1                // =1
               	cbz	x0, <addr>
               	sub	x0, x0, #0x1
               	lsl	x1, x1, #3
               	cbnz	x0, <addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x46
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x17, #0x100000          // =1048576
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x17, #-0x41             // =-65
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
