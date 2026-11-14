
thread_local_tentative_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<thread_main>:
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x63, (%rax)
               	movl	$0x63, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movl	$0x7, (%rax)
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	0x18(%rsp), %r11
               	movq	%rsi, %rcx
               	callq	*%r11
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	*%rbx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
