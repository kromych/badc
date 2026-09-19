
thread_local_image_alignment.x64:	file format elf64-x86-64

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

<check>:
               	movq	%fs:0x0, %rax
               	addq	$-0x20, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq
               	movq	$0x3, (%rax)
               	movq	$0x4, 0x8(%rax)
               	movq	%fs:0x0, %rcx
               	addq	$-0x30, %rcx
               	movb	$0x1, (%rcx)
               	movq	%fs:0x0, %rdx
               	addq	$-0x10, %rdx
               	movb	$0x2, (%rdx)
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	addq	%rsi, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	retq
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	retq
               	xorl	%eax, %eax
               	retq

<thread_main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	popq	%rbp
               	retq

<second_thread_result>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x10(%rbp), %rdi
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%r13, %rax
               	movq	%rbx, %rsi
               	movq	%rbx, %rcx
               	callq	*%rax
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movq	%r12, %rax
               	callq	*%rax
               	movq	-0x8(%rbp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
