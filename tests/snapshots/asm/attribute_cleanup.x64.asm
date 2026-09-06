
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
               	movl	$0x32, %eax
               	movl	%eax, -0x10(%rbp)
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	jmp	<addr>
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
               	movslq	%eax, %rax
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
               	xorq	%rax, %rax
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
               	movl	$0xa, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	$0xb, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0xc, %eax
               	movl	%eax, -0x8(%rbp)
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
               	xorq	%rax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x1, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	$0x2, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x3, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rbx)
               	movl	%esi, (%rdi,%rcx,4)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rbx)
               	movl	%esi, (%rdi,%rcx,4)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rbx)
               	movl	%esi, (%rdi,%rcx,4)
               	movslq	(%rbx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%eax, (%rbx)
               	leaq	<rip>, %rcx
               	movl	%edx, (%rcx)
               	movl	%eax, -0x8(%rbp)
               	movslq	(%rcx), %rcx
               	leaq	<rip>, %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	movl	$0x2bc, %esi            # imm = 0x2BC
               	leaq	<rip>, %rdx
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rbx)
               	movl	%esi, (%rdx,%rax,4)
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x32, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xc, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0xa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rdi, %rdi
               	movl	%edi, (%rbx)
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xc, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0xa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rbx)
               	movl	$0x28, %edx
               	movl	%edx, -0x10(%rbp)
               	movl	$0x29, %esi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdi
               	leaq	<rip>, %r8
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %r9
               	movl	%r9d, (%rbx)
               	movl	%edi, (%r8,%rax,4)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdi
               	leaq	<rip>, %r8
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %r9
               	movl	%r9d, (%rbx)
               	movl	%edi, (%r8,%rax,4)
               	movl	$0x2a, %eax
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x29, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x28, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%ecx, (%rbx)
               	movl	%edx, -0x10(%rbp)
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %rcx
               	leaq	<rip>, %rsi
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rbx)
               	movl	%ecx, (%rsi,%rax,4)
               	leaq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %rcx
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rbx)
               	movl	%ecx, (%rdi,%rax,4)
               	movl	$0x2b, %eax
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x29, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x28, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rbx)
               	movl	$0x14, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x15, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	(%rdx), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rbx)
               	movl	%edx, (%rdi,%rax,4)
               	movslq	(%rsi), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rbx)
               	movl	%edx, (%rsi,%rax,4)
               	movl	$0x1e, %eax
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x15, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x14, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%ecx, (%rbx)
               	movl	$0x14, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x15, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, (%rbx)
               	movl	%ecx, (%rdx,%rax,4)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, (%rbx)
               	movl	%ecx, (%rdx,%rax,4)
               	movl	$0x1f, %eax
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x15, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x14, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
