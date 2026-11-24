
runtime_anon_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x70, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	$0x10, 0x78(%rsp)
               	movq	0x70(%rsp), %rbx
               	movq	0x78(%rsp), %r12
               	leaq	0x28(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x1, 0x28(%rsp)
               	movq	%rbx, 0x30(%rsp)
               	movq	%r12, 0x38(%rsp)
               	movl	$0x7, 0x40(%rsp)
               	leaq	0x50(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x2, 0x50(%rsp)
               	movq	%rbx, 0x58(%rsp)
               	movq	%r12, 0x60(%rsp)
               	movl	$0x8, 0x68(%rsp)
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x50(%rsp), %rdi
               	callq	<addr>
               	movl	(%r13), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%r13), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x10(%r13), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movl	0x18(%r13), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x70, %rsp
               	retq
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x3, 0x60(%rsp)
               	movq	%rbx, 0x68(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
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
               	popq	%r13
               	addq	$0x70, %rsp
               	retq
               	movq	$0x18, 0x78(%rsp)
               	movq	0x78(%rsp), %r12
               	leaq	0x48(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$0x0, 0x20(%rax)
               	movl	$0x9, 0x48(%rsp)
               	movl	$0x4, 0x50(%rsp)
               	movq	%rbx, 0x58(%rsp)
               	movq	%r12, 0x60(%rsp)
               	leaq	0x48(%rsp), %rdi
               	movl	$0x5, 0x68(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movl	0x20(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x70, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x70, %rsp
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movl	0x18(%rax), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
