
function_type_param.aarch64:	file format elf64-littleaarch64

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

<mixed>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sxtw	x20, w0
               	mov	x21, x2
               	mov	x0, x20
               	blr	x1
               	add	x22, x20, x0
               	mov	x0, x20
               	blr	x21
               	add	x0, x22, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<apply1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<inc>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<neg>:
               	mov	x17, #-0x1              // =-1
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
