
libc_int_arith.aarch64:	file format elf64-littleaarch64

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

<strtoimax>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<strtoumax>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x7                // =7
               	mov	x0, #0x9                // =9
               	mov	x0, #0x80000000         // =2147483648
               	mov	x0, #0xb                // =11
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0xa                // =10
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x3039            // =12345
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x10               // =16
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0xff
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
