
inline_result_as_a_later_site_argument.x64:	file format elf64-x86-64

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

<share>:
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	movq	%rdx, %r13
               	cmpl	$0x3, %edi
               	jb	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	0x8(%r12), %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rbx)
               	movq	%r12, %rdi
               	callq	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rbx)
               	movq	%r13, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	0x8(%r13), %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rbx)
               	movq	%r13, %rdi
               	callq	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rbx)
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq

<lock>:
               	addl	$0x1, (%rdi)
               	retq

<unlock>:
               	subl	$0x1, (%rdi)
               	retq

<update>:
               	movq	0x8(%rdi), %rax
               	movq	%rsi, 0x8(%rdi)
               	movq	%rsi, <rip> # <addr>
               	retq

<put>:
               	retq

<main>:
               	subq	$0x40, %rsp
               	pushq	%rbx
               	leaq	0x18(%rsp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x0, 0x20(%rsp)
               	movq	%rax, 0x28(%rsp)
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	callq	<addr>
               	movq	0x28(%rsp), %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rbx)
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rbx)
               	movq	%rbx, %rsi
               	leaq	0x30(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x18(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	leaq	0x18(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	0x18(%rsp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x0, 0x20(%rsp)
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
