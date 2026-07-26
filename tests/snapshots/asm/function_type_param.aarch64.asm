
function_type_param.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<mixed>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x22, x2
               	sxtw	x20, w20
               	mov	x9, x1
               	mov	x0, x20
               	blr	x9
               	add	x21, x20, x0
               	mov	x9, x22
               	mov	x0, x20
               	blr	x9
               	add	x0, x21, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<apply1>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<inc>:
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<neg>:
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x29               // =41
               	mov	x9, x20
               	blr	x9
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x22, #0x3               // =3
               	mov	x9, x20
               	mov	x0, x22
               	blr	x9
               	add	x20, x0, #0x3
               	mov	x9, x21
               	mov	x0, x22
               	blr	x9
               	add	x0, x20, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
