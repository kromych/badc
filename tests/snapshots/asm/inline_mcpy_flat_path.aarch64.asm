
inline_mcpy_flat_path.aarch64:	file format elf64-littleaarch64

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

<use_decode>:
               	mov	x2, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x0]
               	lsr	x3, x3, #62
               	lsl	x3, x3, #2
               	add	x1, x1, x3
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x2]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x2, #0x1]
               	ldr	x10, [sp], #0x10
               	ldrsw	x2, [x0, #0x8]
               	ldrb	w3, [x1, #0x2]
               	add	x2, x2, x3
               	str	w2, [x0, #0x8]
               	ldrb	w0, [x1, #0x3]
               	ret

<use_widen>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x0, [x0, #0x20]
               	add	x1, x1, #0x1
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret

<use_preset>:
               	mov	x0, #0x475              // =1141
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	str	x2, [x1]
               	str	w0, [x1, #0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	eor	x0, x0, #0x1e
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x8]
               	mov	x17, #0x3333            // =13107
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x435
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	cmp	x0, #0x475
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
