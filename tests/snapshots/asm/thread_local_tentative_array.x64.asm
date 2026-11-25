
thread_local_tentative_array.x64:	file format elf64-x86-64

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

<thread_main>:
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x63, %eax
               	movl	%eax, (%rcx)
               	retq

<main>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movl	$0x7, (%rax)
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	0x18(%rsp), %r11
               	leaq	0x20(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%ecx, %ecx
               	callq	*%r11
               	movq	0x20(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	callq	*%rbx
               	movq	0x28(%rsp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
