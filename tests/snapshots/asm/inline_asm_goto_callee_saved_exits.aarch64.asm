
inline_asm_goto_callee_saved_exits.aarch64:	file format elf64-littleaarch64

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

<leaves_by_patched_branch>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	stur	x0, [x29, #-0x20]
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x8]
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	mov	x20, xzr
               	br	x1
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	x30, [sp, #0x18]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x10]
               	mov	x20, #0x65              // =101
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	add	x1, x0, x20
               	ldr	x16, [sp, #0x10]
               	str	x1, [x16]
               	ldr	x30, [sp, #0x18]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x6c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
