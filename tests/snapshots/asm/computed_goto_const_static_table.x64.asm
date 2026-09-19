
computed_goto_const_static_table.x64:	file format elf64-x86-64

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

<interp_ptr_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movl	$0x1, -0x10(%rbp)
               	movzbq	(%rdi), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %r8
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	-0x20(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rdx,%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<interp_decl_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movl	$0x1, -0x10(%rbp)
               	movzbq	(%rdi), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %r8
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	-0x20(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rdx,%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<interp_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movl	$0x1, -0x10(%rbp)
               	movzbq	(%rdi), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %r8
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rcx,%rdx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	-0x20(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rdx,%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
