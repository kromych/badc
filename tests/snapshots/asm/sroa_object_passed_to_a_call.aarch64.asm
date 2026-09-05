
sroa_object_passed_to_a_call.aarch64:	file format elf64-littleaarch64

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

<peek_lo>:
               	ldr	x0, [x0, #0x8]
               	ret

<peek_n>:
               	ldr	x0, [x0, #0x8]
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x28
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	bl	<addr>
               	add	x0, x0, #0x6
               	add	x20, x0, #0x5
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	bl	<addr>
               	add	x0, x0, #0x2
               	add	x0, x0, #0x2
               	add	x0, x0, #0x2
               	add	x0, x0, #0x7
               	cmp	x20, #0xf
               	b.ne	<addr>
               	cmp	x0, #0xf
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
