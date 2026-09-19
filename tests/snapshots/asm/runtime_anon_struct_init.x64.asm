
runtime_anon_struct_init.x64:	file format elf64-x86-64

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

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<check_anon_struct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x1, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%r12, 0x10(%rax)
               	movl	$0x7, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x2, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%r12, 0x10(%rax)
               	movl	$0x8, 0x18(%rax)
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movslq	(%r13), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%r13), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x10(%r13), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movslq	0x18(%r13), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x0, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	movq	$0x10, -0x48(%rbp)
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x3, (%rdi)
               	movq	%rbx, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	$0x18, -0x48(%rbp)
               	movq	-0x48(%rbp), %r12
               	leaq	-0x28(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$0x0, 0x20(%rax)
               	movl	$0x9, (%rax)
               	movl	$0x4, 0x8(%rax)
               	movq	%rbx, 0x10(%rax)
               	movq	%r12, 0x18(%rax)
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x5, 0x20(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movslq	0x20(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
