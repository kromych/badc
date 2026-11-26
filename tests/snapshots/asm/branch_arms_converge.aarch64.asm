
branch_arms_converge.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<same_constant>:
               	mov	x0, #0x2                // =2
               	ret

<both_arms_assign>:
               	mov	x0, #0x5                // =5
               	ret

<or_true>:
               	mov	x0, #0x1                // =1
               	ret

<and_false>:
               	mov	x0, #0x0                // =0
               	ret

<keeps_values>:
               	cmp	w0, #0x0
               	mov	x16, #0x2               // =2
               	mov	x17, #0x1               // =1
               	csel	x0, x16, x17, ne
               	ret

<keeps_store>:
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
