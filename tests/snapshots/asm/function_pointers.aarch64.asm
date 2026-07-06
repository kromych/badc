
function_pointers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<sub>:
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0xa               // =10
               	mov	x1, #0x14               // =20
               	mov	x9, x0
               	mov	x0, x20
               	blr	x9
               	mov	x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	mov	x9, x0
               	mov	x0, x20
               	blr	x9
               	mul	x0, x21, x0
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
