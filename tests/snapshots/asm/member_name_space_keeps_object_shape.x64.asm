
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
               	cmpl	$0x2, %eax
               	jge	<addr>
               	imulq	$0x30, %rax, %rdx
               	leaq	(%rcx,%rdx), %rdi
               	addq	$0x0, %rdi
               	leaq	(%rdi), %r8
               	leaq	0x1(%rsi), %rdi
               	movl	%esi, (%r8)
               	leaq	(%rcx,%rdx), %rsi
               	leaq	(%rsi), %r8
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, 0x4(%r8)
               	leaq	(%rcx,%rdx), %rdi
               	leaq	(%rdi), %r8
               	leaq	0x1(%rsi), %rdi
               	movl	%esi, 0x8(%r8)
               	leaq	(%rcx,%rdx), %rsi
               	leaq	(%rsi), %r8
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, 0xc(%r8)
               	leaq	(%rcx,%rdx), %rdi
               	addq	$0x10, %rdi
               	leaq	(%rdi), %r8
               	leaq	0x1(%rsi), %rdi
               	movl	%esi, (%r8)
               	leaq	(%rcx,%rdx), %rsi
               	leaq	0x10(%rsi), %r8
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, 0x4(%r8)
               	leaq	(%rcx,%rdx), %rdi
               	leaq	0x10(%rdi), %r8
               	leaq	0x1(%rsi), %rdi
               	movl	%esi, 0x8(%r8)
               	addq	%rcx, %rdx
               	addq	$0x10, %rdx
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, 0xc(%rdx)
               	imulq	$0x30, %rax, %rdx
               	leaq	(%rcx,%rdx), %rdi
               	addq	$0x20, %rdi
               	leaq	(%rdi), %r8
               	leaq	0x1(%rsi), %rdi
               	movl	%esi, (%r8)
               	leaq	(%rcx,%rdx), %rsi
               	leaq	0x20(%rsi), %r8
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, 0x4(%r8)
               	leaq	(%rcx,%rdx), %rdi
               	leaq	0x20(%rdi), %r8
               	leaq	0x1(%rsi), %rdi
               	movl	%esi, 0x8(%r8)
               	addq	%rcx, %rdx
               	addq	$0x20, %rdx
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, 0xc(%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x5c(%rax), %rax
               	cmpl	$0x17, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	addq	$0x0, %rax
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movl	$0x1, 0x4(%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movl	$0x2, 0x8(%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movl	$0x3, %edx
               	movl	%edx, 0xc(%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	addq	$0x0, %rax
               	movl	$0xa, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0xb, 0x4(%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0xc, 0x8(%rax)
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0xd, 0xc(%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	addq	$0x0, %rax
               	movl	$0x14, (%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	$0x15, 0x4(%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	$0x16, 0x8(%rax)
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	$0x17, 0xc(%rax)
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x17, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rcx, %rax
               	retq
