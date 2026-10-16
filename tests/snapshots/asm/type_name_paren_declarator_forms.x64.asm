
type_name_paren_declarator_forms.x64:	file format elf64-x86-64

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

<f1>:
               	movl	$0x1, %eax
               	retq

<f2>:
               	movl	$0x2, %eax
               	retq

<f3>:
               	leaq	0x3(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax       # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax       # <addr>
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movl	$0x4, %edi
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rcx
               	movl	(%rcx), %ecx
               	movq	0x8(%rax), %rax
               	movl	(%rax), %eax
               	addq	%rcx, %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	shlq	%rax
               	addq	%rbx, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	movw	%ax, -0x8(%rbp)
               	movswq	%ax, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
