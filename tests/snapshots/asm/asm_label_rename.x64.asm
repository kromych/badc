
asm_label_rename.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<badc_real_fn>:
               	movl	$0xb, %eax
               	retq

<badc_real_weak>:
               	movl	$0x21, %eax
               	retq

<badc_real_hidden>:
               	movl	$0x37, %eax
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x58, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xb, %rax
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq

<badc_real_sect>:
               	movl	$0x58, %eax
               	retq
