
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
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	leaq	<rip>, %rdx
               	movq	%rdi, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	imulq	$0x30, %rcx, %rsi
               	leaq	(%rdx,%rsi), %r8
               	addq	$0x0, %r8
               	leaq	(%r8), %r9
               	leaq	0x1(%rdi), %r8
               	movl	%edi, (%r9)
               	leaq	(%rdx,%rsi), %rdi
               	leaq	(%rdi), %r9
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0x4(%r9)
               	leaq	(%rdx,%rsi), %r8
               	leaq	(%r8), %r9
               	leaq	0x1(%rdi), %r8
               	movl	%edi, 0x8(%r9)
               	leaq	(%rdx,%rsi), %rdi
               	leaq	(%rdi), %r9
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0xc(%r9)
               	leaq	(%rdx,%rsi), %r8
               	addq	$0x10, %r8
               	leaq	(%r8), %r9
               	leaq	0x1(%rdi), %r8
               	movl	%edi, (%r9)
               	leaq	(%rdx,%rsi), %rdi
               	leaq	0x10(%rdi), %r9
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0x4(%r9)
               	addq	%rdx, %rsi
               	addq	$0x10, %rsi
               	leaq	0x1(%rdi), %r8
               	movl	%edi, 0x8(%rsi)
               	imulq	$0x30, %rcx, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	leaq	0x10(%rdi), %r9
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0xc(%r9)
               	leaq	(%rdx,%rsi), %r8
               	addq	$0x20, %r8
               	leaq	(%r8), %r9
               	leaq	0x1(%rdi), %r8
               	movl	%edi, (%r9)
               	leaq	(%rdx,%rsi), %rdi
               	leaq	0x20(%rdi), %r9
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0x4(%r9)
               	leaq	(%rdx,%rsi), %r8
               	leaq	0x20(%r8), %r9
               	leaq	0x1(%rdi), %r8
               	movl	%edi, 0x8(%r9)
               	addq	%rdx, %rsi
               	addq	$0x20, %rsi
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0xc(%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
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
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movl	$0x1, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movl	$0x2, %edx
               	movl	%edx, 0x8(%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movl	$0x3, %edx
               	movl	%edx, 0xc(%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	addq	$0x0, %rax
               	movl	$0xa, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0xb, %esi
               	movl	%esi, 0x4(%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0xc, %esi
               	movl	%esi, 0x8(%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0xd, %esi
               	movl	%esi, 0xc(%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	addq	$0x0, %rax
               	movl	$0x14, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	$0x15, %esi
               	movl	%esi, 0x4(%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	$0x16, %esi
               	movl	%esi, 0x8(%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	$0x17, %esi
               	movl	%esi, 0xc(%rax)
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
               	movq	%rdx, %rax
               	retq
               	movq	%rcx, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
