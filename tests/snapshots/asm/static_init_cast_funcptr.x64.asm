
static_init_cast_funcptr.x64:	file format elf64-x86-64

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

<real_double>:
               	movq	%rdi, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	retq

<real_negate>:
               	imulq	$-0x1, %rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	movq	0x8(%rbx), %rax
               	movl	$0x15, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	0x20(%rbx), %rax
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	0x10(%rbx), %rax
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rbx), %rax
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpl	$-0x11, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	0x18(%rbx), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x6e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<__c5_sys_atoi>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
