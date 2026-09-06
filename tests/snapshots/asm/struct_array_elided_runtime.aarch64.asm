
struct_array_elided_runtime.aarch64:	file format elf64-littleaarch64

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

<run>:
               	add	x2, x0, #0x1
               	add	x3, x0, #0x2
               	add	x1, x0, #0x3
               	cmp	w0, w0
               	b.ne	<addr>
               	cmp	w2, w2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	w3, w3
               	b.ne	<addr>
               	cmp	w1, w1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x2, x0, #0x4
               	mov	x3, #0x0                // =0
               	mov	x6, x3
               	cmp	w1, w1
               	b.ne	<addr>
               	cmp	w2, w2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, x3
               	mov	x0, x3
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
