
packed_nested_static_member.aarch64:	file format elf64-littleaarch64

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

<read_ro>:
               	sxtw	x0, w0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x9
               	add	x0, x1, x0, lsl #3
               	ldrsh	x0, [x0, #0x4]
               	add	x0, x0, #0xb
               	ret

<write_rw>:
               	mov	x1, #0x28               // =40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	w1, [x0, #0x1]
               	mov	x1, #0x29               // =41
               	sturh	w1, [x0, #0x5]
               	mov	x1, #0x2a               // =42
               	stur	w1, [x0, #0x11]
               	ret

<grid_sum>:
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x19              // =25
               	mul	x2, x0, x17
               	add	x2, x1, x2
               	add	x0, x0, #0xa
               	stur	w0, [x2, #0x1]
               	mov	x0, #0x14               // =20
               	strh	w0, [x1, #0x2e]
               	ldursw	x0, [x2, #0x1]
               	add	x0, x0, #0x14
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x0, #0x1]
               	cmp	w1, #0x28
               	b.ne	<addr>
               	ldursh	x1, [x0, #0x5]
               	cmp	w1, #0x29
               	b.ne	<addr>
               	ldursw	x0, [x0, #0x11]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x1f
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
