
member_name_space_keeps_object_shape.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	%esi, %rdi
               	imulq	$0x30, %rdi, %r8
               	leaq	(%rdx,%r8), %r9
               	movslq	%eax, %rdx
               	movq	%rdx, %rbx
               	shlq	$0x4, %rbx
               	addq	%rbx, %r9
               	leaq	(%r9), %r12
               	leaq	0x1(%rcx), %r9
               	movl	%ecx, (%r12)
               	leaq	<rip>, %rcx
               	addq	%r8, %rcx
               	addq	%rcx, %rbx
               	leaq	0x1(%r9), %rcx
               	movl	%r9d, 0x4(%rbx)
               	leaq	<rip>, %r9
               	addq	%r8, %r9
               	movq	%rdx, %rbx
               	shlq	$0x4, %rbx
               	leaq	(%r9,%rbx), %r12
               	leaq	0x1(%rcx), %r9
               	movl	%ecx, 0x8(%r12)
               	leaq	<rip>, %rcx
               	addq	%r8, %rcx
               	leaq	(%rcx,%rbx), %rdi
               	leaq	0x1(%r9), %rcx
               	movl	%r9d, 0xc(%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	cmpl	$0x2, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x5c(%rax), %rax
               	cmpl	$0x17, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	leaq	(%rax), %r8
               	imulq	$0xa, %rdx, %rax
               	leaq	(%rax), %rdi
               	movl	%edi, (%r8)
               	leaq	<rip>, %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	0x1(%rax), %rdi
               	movl	%edi, 0x4(%r8)
               	leaq	<rip>, %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	0x2(%rax), %rdi
               	movl	%edi, 0x8(%r8)
               	leaq	<rip>, %rdi
               	addq	%rdi, %rsi
               	addq	$0x3, %rax
               	movl	%eax, 0xc(%rsi)
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x17, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
