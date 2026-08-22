
fn_ptr_typedef_multi_declarator.aarch64:	file format elf64-littleaarch64

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

<wide>:
               	mov	x0, #0x6789             // =26505
               	movk	x0, #0x2345, lsl #16
               	movk	x0, #0x1, lsl #32
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	bl	<addr>
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	bl	<addr>
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
