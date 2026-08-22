
file_scope_asm_rept_type_size.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x3, #0x4                // =4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	eor	x2, x2, x3
               	mov	w2, w2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x0, #0x3                // =3
               	mov	x3, #0x7                // =7
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	eor	x2, x2, x3
               	mov	w2, w2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x8
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<rept_run>:
               	<unknown>
               	<unknown>

<rept_run_len>:
               	udf	#0x8
