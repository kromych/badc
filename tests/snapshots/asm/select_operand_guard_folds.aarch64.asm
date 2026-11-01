
select_operand_guard_folds.aarch64:	file format elf64-littleaarch64

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

<add_page>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	orr	x0, x1, x0
               	str	x0, [x2]
               	and	x0, x0, #0x3
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	ldr	x3, [x3]
               	tbz	w3, #0x16, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x3, #0x400000           // =4194304
               	str	x3, [x1]
               	ldr	x1, [x2]
               	ldr	x1, [x1]
               	tbz	w1, #0x16, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1000             // =4096
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x1                // =1
               	str	w3, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x1001             // =4097
               	str	x4, [x2]
               	ldr	x2, [x2]
               	mov	x17, #0x1001            // =4097
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w3, [x2]
               	ldrsw	x3, [x1]
               	cbz	x3, <addr>
               	str	w0, [x1]
               	ldrsw	x3, [x2]
               	cbz	x3, <addr>
               	ldrsw	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	str	w0, [x2]
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x2                // =2
               	ret
