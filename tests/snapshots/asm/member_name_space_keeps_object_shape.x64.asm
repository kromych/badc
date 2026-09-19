
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
               	xorl	%esi, %esi
               	leaq	<rip>, %rcx
               	movq	%rsi, %rax
               	imulq	$0x30, %rax, %rdi
               	leaq	(%rcx,%rdi), %rdx
               	leaq	0x1(%rsi), %r8
               	movl	%esi, (%rdx)
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0x4(%rdx)
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x8(%rdx)
               	leaq	(%rcx,%rdi), %rdx
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0xc(%rdx)
               	imulq	$0x30, %rax, %rdx
               	leaq	(%rcx,%rdx), %r9
               	leaq	0x10(%r9), %rsi
               	leaq	0x1(%rdi), %r8
               	movl	%edi, (%rsi)
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0x4(%rsi)
               	leaq	(%rcx,%rdx), %r9
               	leaq	0x10(%r9), %rsi
               	leaq	0x1(%rdi), %r8
               	movl	%edi, 0x8(%rsi)
               	leaq	0x1(%r8), %rdi
               	movl	%r8d, 0xc(%rsi)
               	addq	%rcx, %rdx
               	addq	$0x20, %rdx
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, (%rdx)
               	imulq	$0x30, %rax, %rdi
               	leaq	(%rcx,%rdi), %r9
               	leaq	0x20(%r9), %rdx
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x4(%rdx)
               	leaq	0x1(%r8), %r9
               	movl	%r8d, 0x8(%rdx)
               	leaq	(%rcx,%rdi), %rdx
               	addq	$0x20, %rdx
               	leaq	0x1(%r9), %rsi
               	movl	%r9d, 0xc(%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x5c(%rax), %rcx
               	cmpl	$0x17, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x2, 0x8(%rax)
               	movl	$0x3, 0xc(%rax)
               	leaq	0x8(%rax), %rcx
               	movl	$0xa, (%rcx)
               	movl	$0xb, 0x4(%rcx)
               	movl	$0xc, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	leaq	0x8(%rcx), %rax
               	movl	$0xd, 0xc(%rax)
               	leaq	0x10(%rcx), %rax
               	movl	$0x14, (%rax)
               	movl	$0x15, 0x4(%rax)
               	movl	$0x16, 0x8(%rax)
               	movl	$0x17, 0xc(%rax)
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rcx
               	cmpl	$0x17, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
