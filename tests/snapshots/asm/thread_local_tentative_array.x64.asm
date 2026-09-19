
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
               	movl	$0x63, %ecx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	retq

<second_thread_result>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rsi, %rcx
               	callq	*%r12
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	*%rbx
               	movq	-0x8(%rbp), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movl	$0x7, (%rax)
               	callq	<addr>
               	cmpq	$0x63, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
