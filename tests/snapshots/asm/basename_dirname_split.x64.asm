
basename_dirname_split.x64:	file format elf64-x86-64

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

<splits_to>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %rbx
               	movq	%rdx, %r12
               	leaq	-0x40(%rbp), %rax
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	callq	*%rbx
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x8(%rbp), %rax
               	movb	$0x0, (%rax)
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax      # <addr>
               	imulq	$0x18, %rbx, %r12
               	addq	%r12, %rax
               	movq	(%rax), %rdi
               	movq	<rip>, %rsi      # <addr>
               	movq	0x8(%rax), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	addq	%r12, %rax
               	movq	(%rax), %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	decq	%rax
               	movsbq	(%r12,%rax), %rax
               	cmpl	$0x2f, %eax
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	imulq	$0x18, %rbx, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rdi
               	movq	<rip>, %rsi      # <addr>
               	movq	0x10(%rax), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jb	<addr>
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	shlq	%rbx
               	leaq	0x2(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rax
               	shlq	%rax
               	incq	%rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
