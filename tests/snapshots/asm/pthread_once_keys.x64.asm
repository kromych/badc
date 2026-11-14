
pthread_once_keys.x64:	file format elf64-x86-64

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

<init>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	xorl	%esi, %esi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leave
               	retq

<call_once>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<destroy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	(%rbx), %ecx
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq

<destroy_again>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x8(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	movq	0x8(%rsp), %rsi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leave
               	retq

<never>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	popq	%rbp
               	retq

<ends_process>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x63, %edi
               	callq	<addr>
               	ud2

<use_keys>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<no_value>:
               	xorl	%eax, %eax
               	retq

<set_again>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rsi
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<outlives_key>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rsi
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	-0x40(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rax,%rcx), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	movq	-0x40(%rbp,%rbx,8), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7c, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x7d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7f, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x800000004, %rax      # imm = 0x800000004
               	movq	%rax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x83, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x84, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x85, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x86, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x87, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movl	$0x88, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	0xc(%rcx), %rsi
               	movq	%rax, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8a, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %rax
               	movq	%r8, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rax,%rcx), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%r8, %rcx
               	shlq	$0x2, %rcx
               	addq	%rax, %rcx
               	movq	%r8, 0x18(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x18(%rsp), %r8
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	xorl	%ebx, %ebx
               	movq	-0x40(%rbp,%rbx,8), %rdi
               	leaq	-0x48(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x48(%rbp)
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	movl	<rip>, %edx # <addr>
               	orq	%rdx, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0xc, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x93, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	-0x40(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x96, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x97, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	leaq	<rip>, %rcx # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x99, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	-0x40(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9b, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	leaq	<rip>, %rcx # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx # <addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	$0x2, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movq	-0x40(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xa8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8f, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7b, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x79, %eax
               	popq	%rbx
               	leave
               	retq
