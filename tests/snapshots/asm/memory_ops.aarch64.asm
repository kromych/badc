
memory_ops.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, #0x41               // =65
               	mov	x2, #0x9                // =9
               	mov	x0, x21
               	bl	<addr>
               	mov	x2, #0x9                // =9
               	strb	wzr, [x21, #0x9]
               	mov	x1, #0x41               // =65
               	mov	x0, x20
               	bl	<addr>
               	strb	wzr, [x20, #0x9]
               	mov	x2, #0xa                // =10
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x42               // =66
               	strb	w0, [x20, #0x5]
               	mov	x2, #0xa                // =10
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
