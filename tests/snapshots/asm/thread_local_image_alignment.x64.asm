
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x20, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	movq	%fs:0x0, %rcx
               	addq	$-0x30, %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movl	$0x2, %edx
               	movb	%dl, (%rcx)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movsbq	(%rax), %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rbx, %rbx
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
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
