
struct_array_brace_elision.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	pushq	%rbx
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	<rip>, %rsi
               	xorl	%ecx, %ecx
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%rsi,%rdi), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	leaq	(%r8,%r9), %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rdx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	leaq	-0x30(%rbp), %rsi
               	xorl	%ecx, %ecx
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%rsi,%rdi), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	leaq	(%r8,%r9), %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rdx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x20(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x2c(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
