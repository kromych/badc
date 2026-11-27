
volatile_fn_pointer_declarator.x64:	file format elf64-x86-64

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

<r41>:
               	movl	$0x29, %eax
               	retq

<r42>:
               	movl	$0x2a, %eax
               	retq

<p41>:
               	leaq	<rip>, %rax # <addr>
               	retq

<p42>:
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x29, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
