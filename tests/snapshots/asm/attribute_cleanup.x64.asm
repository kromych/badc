
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movslq	(%rdx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rdx)
               	movl	%edi, (%rcx,%rsi,4)
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movslq	(%rdx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rdx)
               	movl	%edi, (%rcx,%rsi,4)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
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
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%ecx, (%rdx,%rax,4)
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %r12
               	movl	$0x0, (%r12)
               	movl	$0x1, -0x18(%rbp)
               	movl	$0x2, -0x10(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rsi)
               	movl	%edx, (%rbx,%rax,4)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rdi)
               	movl	%edx, (%rsi,%rax,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rdi)
               	movl	%edx, (%rsi,%rax,4)
               	movslq	(%r12), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	0x8(%rbx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x0, (%r12)
               	leaq	<rip>, %rcx
               	movl	$0x1, (%rcx)
               	movl	$0x0, -0x8(%rbp)
               	movslq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movslq	(%r12), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%r12)
               	movl	$0x2bc, (%rbx,%rdx,4)   # imm = 0x2BC
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%r12), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	(%rbx), %rcx
               	cmpl	$0x2bc, %ecx            # imm = 0x2BC
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x0, (%r12)
               	callq	<addr>
               	movslq	(%r12), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	cmpl	$0x0, (%rbx)
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	0x8(%rbx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	0xc(%rbx), %rax
               	cmpl	$0x32, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x0, (%r12)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%r12), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movslq	0x8(%rbx), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, (%r12)
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	(%r12), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movslq	0x8(%rbx), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x0, (%r12)
               	movl	$0x28, -0x10(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdi
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%r12)
               	movl	%edi, (%rbx,%rax,4)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdi
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%r12)
               	movl	%edi, (%rbx,%rax,4)
               	movslq	(%r12), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x29, %eax
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x0, (%r12)
               	movl	$0x28, -0x10(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, (%r12)
               	movl	%edx, (%rbx,%rax,4)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%r12)
               	movl	%esi, (%rbx,%rax,4)
               	movslq	(%r12), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x29, %eax
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x0, (%r12)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, -0x8(%rbp)
               	movslq	(%rcx), %rcx
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%r12)
               	movl	%ecx, (%rbx,%rax,4)
               	movslq	(%rdx), %rcx
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %rdx
               	movl	%edx, (%r12)
               	movl	%ecx, (%rbx,%rax,4)
               	movslq	(%r12), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x0, (%r12)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %rdx
               	movl	%edx, (%r12)
               	movl	%ecx, (%rbx,%rax,4)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	(%r12), %rax
               	leaq	0x1(%rax), %rdx
               	movl	%edx, (%r12)
               	movl	%ecx, (%rbx,%rax,4)
               	movslq	(%r12), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
