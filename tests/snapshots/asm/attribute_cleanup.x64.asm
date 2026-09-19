
attribute_cleanup.x64:	file format elf64-x86-64

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

<loopy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x32, -0x10(%rbp)
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movl	%edi, (%rdx,%rsi,4)
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movl	%edi, (%rdx,%rsi,4)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	movl	$0xa, -0x18(%rbp)
               	movl	$0xb, -0x10(%rbp)
               	movl	$0xc, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, -0x18(%rbp)
               	movl	$0x2, -0x10(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	leaq	<rip>, %rcx
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rdi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rdx)
               	movl	%edi, (%rcx,%rsi,4)
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movslq	0x8(%rsi), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0x1, (%rdx)
               	movl	$0x0, -0x8(%rbp)
               	movslq	(%rdx), %rdi
               	movl	$0x0, (%rdx)
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	$0x2bc, (%rsi,%rcx,4)   # imm = 0x2BC
               	cmpl	$0x1, %edi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movl	$0x0, (%rbx)
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x32, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	cmpl	$0xc, %edx
               	jne	<addr>
               	movslq	0x4(%rax), %rdx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, (%rcx)
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0xc, %edx
               	jne	<addr>
               	movslq	0x4(%rcx), %rdx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	movslq	0x8(%rcx), %rdx
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x28, -0x10(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	leaq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %r8
               	movslq	(%rax), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rax)
               	movl	%r8d, (%rcx,%rdi,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdi
               	cmpl	$0x29, %edi
               	jne	<addr>
               	movslq	0x4(%rcx), %rdi
               	cmpl	$0x28, %edi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x28, -0x10(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %r8
               	movslq	(%rax), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rax)
               	movl	%r8d, (%rcx,%rdi,4)
               	movslq	(%rsi), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	movslq	(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	cmpl	$0x29, %esi
               	jne	<addr>
               	movslq	0x4(%rcx), %rsi
               	cmpl	$0x28, %esi
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, -0x8(%rbp)
               	movslq	(%rdx), %rsi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rdi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	movslq	(%rdx), %rsi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
