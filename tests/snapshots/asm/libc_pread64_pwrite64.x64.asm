
libc_pread64_pwrite64.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movzbq	0x10(%rax), %rcx
               	movb	%cl, 0x10(%rdi)
               	movzbq	0x11(%rax), %rcx
               	movb	%cl, 0x11(%rdi)
               	movzbq	0x12(%rax), %rcx
               	movb	%cl, 0x12(%rdi)
               	movzbq	0x13(%rax), %rcx
               	movb	%cl, 0x13(%rdi)
               	popq	%rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0xa8(%rax), %r8
               	movq	0x88(%rax), %r12
               	movslq	%ebx, %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	callq	*%r8
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	callq	*%r12
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<__c5_sys_pread64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	-0x40(%rbp), %rdi
               	movq	-0x30(%rbp), %rsi
               	movq	-0x20(%rbp), %rdx
               	movq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	leave
               	retq

<__c5_sys_pwrite64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	-0x40(%rbp), %rdi
               	movq	-0x30(%rbp), %rsi
               	movq	-0x20(%rbp), %rdx
               	movq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	leave
               	retq
