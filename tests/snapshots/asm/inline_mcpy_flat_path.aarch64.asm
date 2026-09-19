
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
               	mov	x5, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x1]
               	lsr	x3, x0, #62
               	lsl	x4, x3, #2
               	add	x0, x2, x4
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x5]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x5, #0x1]
               	ldr	x10, [sp], #0x10
               	ldrsw	x5, [x1, #0x8]
               	ldrb	w6, [x0, #0x2]
               	add	x5, x5, x6
               	str	w5, [x1, #0x8]
               	ldrb	w0, [x0, #0x3]
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
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0x8]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x20]
               	str	w0, [x20, #0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	eor	x0, x0, #0x1e
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldurh	w0, [x29, #-0x8]
               	mov	x17, #0x3333            // =13107
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrsw	x0, [x20, #0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	bl	<addr>
               	cmp	x0, #0x435
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	cmp	x0, #0x475
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
