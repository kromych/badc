
posix_option_macros_name_their_interfaces.aarch64:	file format elf64-littleaarch64

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

<pthread_atfork>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, x0, lsl #3]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldr	x2, [x1, x0, lsl #3]
               	cbnz	x2, <addr>
               	cmp	w0, #0x0
               	b.le	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x63               // =99
               	b	<addr>
