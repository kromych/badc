
ssa_callee_saved_x19.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x280              // =640
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, #0x298
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
