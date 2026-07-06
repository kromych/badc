
inline_forward_ref_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<combine>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x0, #0x1
               	str	w3, [x2]
               	add	x0, x0, x1
               	ret

<scale>:
               	lsl	x0, x0, #1
               	ret

<compute>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	add	x1, x0, #0x1
               	sxtw	x20, w1
               	cbz	x0, <addr>
               	add	x1, x0, #0x64
               	add	x0, x0, #0x1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	lsl	x2, x1, #1
               	mov	x1, x0
               	mov	x0, x2
               	bl	<addr>
               	sxtw	x1, w20
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sub	x0, x0, #0xde
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
