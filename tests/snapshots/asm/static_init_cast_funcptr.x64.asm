
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
               	movq	%rdi, %rax
               	negq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x15, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rax
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpl	$-0x11, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x64, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	0x18(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x6e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<__c5_sys_atoi>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
