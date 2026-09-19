
loop_idiom_version.x64:	file format elf64-x86-64

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

<indexed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edx, %rdx
               	xorq	%rax, %rax
               	testl	%edx, %edx
               	jle	<addr>
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	leaq	(%rdx), %rcx
               	cmpq	%rcx, %r8
               	jb	<addr>
               	movq	%rcx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movslq	%eax, %rcx
               	movzbq	(%rsi,%rcx), %r8
               	movb	%r8b, (%rdi,%rcx)
               	incq	%rax
               	cmpl	%edx, %eax
               	jge	<addr>
               	jmp	<addr>

<into_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	xorq	%rax, %rax
               	testl	%esi, %esi
               	jle	<addr>
               	leaq	<rip>, %rcx
               	subq	%rdi, %rcx
               	leaq	(%rsi), %rdx
               	cmpq	%rdx, %rcx
               	jb	<addr>
               	leaq	<rip>, %rax
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movslq	%eax, %rcx
               	movzbq	(%rdi,%rcx), %r8
               	movb	%r8b, (%rdx,%rcx)
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	jmp	<addr>

<out_of_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	xorq	%rax, %rax
               	testl	%esi, %esi
               	jle	<addr>
               	leaq	<rip>, %rcx
               	movq	%rcx, %r10
               	movq	%rdi, %rcx
               	subq	%r10, %rcx
               	leaq	(%rsi), %rdx
               	cmpq	%rdx, %rcx
               	jb	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movslq	%eax, %rcx
               	leaq	<rip>, %rdx
               	movzbq	(%rdx,%rcx), %rdx
               	movb	%dl, (%rdi,%rcx)
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	jmp	<addr>

<blocked3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movl	%r13d, %eax
               	cmpl	$0x2, %eax
               	jbe	<addr>
               	movq	%rbx, %rdi
               	subq	%r12, %rdi
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x21, %rdx
               	leaq	(%rdx,%rdx,2), %rsi
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%r13d, %ecx
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rax
               	shrq	$0x21, %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	%rax, %rbx
               	addq	%rax, %r12
               	movl	%eax, %eax
               	movq	%rcx, %r13
               	subq	%rax, %r13
               	movl	%r13d, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x1(%rbx), %rdi
               	leaq	0x1(%r12), %rsi
               	movzbq	(%r12), %rcx
               	movb	%cl, (%rbx)
               	leaq	-0x1(%rax), %r13
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movl	%r13d, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movzbq	(%r12), %rcx
               	movb	%cl, (%rbx)
               	movzbq	0x1(%r12), %rcx
               	movb	%cl, 0x1(%rbx)
               	movzbq	0x2(%r12), %rcx
               	movb	%cl, 0x2(%rbx)
               	addq	$0x3, %rbx
               	addq	$0x3, %r12
               	leaq	-0x3(%rax), %r13
               	movl	%r13d, %eax
               	cmpl	$0x2, %eax
               	ja	<addr>
               	jmp	<addr>

<walk1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r12
               	movq	%rdx, %rbx
               	movq	%rsi, %r13
               	movl	%ebx, %edx
               	testl	%edx, %edx
               	jbe	<addr>
               	movq	%r12, %rax
               	subq	%r13, %rax
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movzbq	(%r13), %rcx
               	movb	%cl, (%r12)
               	incq	%r12
               	incq	%r13
               	leaq	-0x1(%rax), %rbx
               	movl	%ebx, %eax
               	testl	%eax, %eax
               	jbe	<addr>
               	jmp	<addr>

<words4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movl	%r13d, %eax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	movq	%rbx, %rdi
               	subq	%r12, %rdi
               	movq	%rax, %rcx
               	andq	$0x3, %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	(%r12), %ecx
               	movl	%ecx, (%rbx)
               	movl	0x4(%r12), %ecx
               	movl	%ecx, 0x4(%rbx)
               	movl	0x8(%r12), %ecx
               	movl	%ecx, 0x8(%rbx)
               	movl	0xc(%r12), %ecx
               	movl	%ecx, 0xc(%rbx)
               	addq	$0x10, %rbx
               	addq	$0x10, %r12
               	leaq	-0x4(%rax), %r13
               	movl	%r13d, %eax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	jmp	<addr>

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r9
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	movslq	%r13d, %r13
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rcx)
               	movb	%r8b, (%rdi,%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rbx
               	leaq	(%rbx,%r12), %rdi
               	leaq	(%rbx,%r13), %rsi
               	movl	%r14d, %edx
               	movq	%r9, %rax
               	callq	*%rax
               	leaq	<rip>, %r8
               	leaq	(%r8,%r12), %rax
               	leaq	(%r8,%r13), %rcx
               	movl	%r14d, %edi
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%edi, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorq	%r13, %r13
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	xorq	%r12, %r12
               	cmpl	$0x8, %r12d
               	jge	<addr>
               	xorq	%rbx, %rbx
               	movl	%ebx, %ecx
               	cmpl	$0x14, %ecx
               	ja	<addr>
               	leaq	-<rip>, %rdi      # <addr>
               	movq	%r13, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-<rip>, %rdi      # <addr>
               	movl	%ebx, %ecx
               	movq	%r13, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %ecx
               	cmpl	$0x14, %ecx
               	jbe	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	xorq	%r14, %r14
               	cmpl	$0x8, %r14d
               	jge	<addr>
               	xorq	%r13, %r13
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	xorq	%rbx, %rbx
               	cmpl	$0x14, %ebx
               	jg	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rcx)
               	leaq	<rip>, %rsi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %r12
               	movslq	%r14d, %rax
               	leaq	(%r12,%rax), %rdi
               	movslq	%r13d, %rax
               	leaq	(%r12,%rax), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movslq	%r14d, %rax
               	addq	%rdi, %rax
               	movslq	%r13d, %rcx
               	addq	%rdi, %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%rdi, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jle	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x8, %r14d
               	jl	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rcx)
               	leaq	<rip>, %rsi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rbx
               	leaq	0x8(%rbx), %rsi
               	movabsq	$-0x3, %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%r12, %r12
               	cmpl	$0x8, %r12d
               	jge	<addr>
               	xorq	%rbx, %rbx
               	cmpl	$0x14, %ebx
               	jg	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rcx)
               	leaq	<rip>, %rsi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %r13
               	movslq	%r12d, %rax
               	leaq	(%r13,%rax), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	%r12d, %rcx
               	addq	%rax, %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%r13, %rdi
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rcx)
               	leaq	<rip>, %rsi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %r13
               	movslq	%r12d, %rax
               	leaq	(%r13,%rax), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	%r12d, %rcx
               	addq	%rax, %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rax,%rsi), %rsi
               	movb	%sil, (%rcx,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%r13, %rdi
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jle	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	leaq	<rip>, %rbx
               	leaq	0x20(%rbx), %r12
               	xorq	%rax, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rcx)
               	leaq	<rip>, %rsi
               	movb	%dil, (%rsi,%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movq	%rbx, %rax
               	subq	%r12, %rax
               	cmpq	$0x9, %rax
               	jb	<addr>
               	movl	$0x9, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x9(%rbx), %rdx
               	leaq	0x9(%r12), %rax
               	movl	$0x2, %ecx
               	leaq	<rip>, %rcx
               	addq	$0x9, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x29, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rsi
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rcx
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	(%rax), %rdx
               	movl	$0x1020304, %ecx        # imm = 0x1020304
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x2040608, %ecx        # imm = 0x2040608
               	movl	%ecx, 0x4(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x4(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x306090c, %ecx        # imm = 0x306090C
               	movl	%ecx, 0x8(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x8(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x4080c10, %ecx        # imm = 0x4080C10
               	movl	%ecx, 0xc(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0xc(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x50a0f14, %ecx        # imm = 0x50A0F14
               	movl	%ecx, 0x10(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x10(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x60c1218, %ecx        # imm = 0x60C1218
               	movl	%ecx, 0x14(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x14(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x70e151c, %ecx        # imm = 0x70E151C
               	movl	%ecx, 0x18(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x18(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x8101820, %ecx        # imm = 0x8101820
               	movl	%ecx, 0x1c(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x1c(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x9121b24, %ecx        # imm = 0x9121B24
               	movl	%ecx, 0x20(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x20(%rdx)
               	leaq	<rip>, %rax
               	movl	$0xa141e28, %ecx        # imm = 0xA141E28
               	movl	%ecx, 0x24(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x24(%rdx)
               	leaq	<rip>, %rax
               	movl	$0xb16212c, %ecx        # imm = 0xB16212C
               	movl	%ecx, 0x28(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x28(%rdx)
               	leaq	<rip>, %rax
               	movl	$0xc182430, %ecx        # imm = 0xC182430
               	movl	%ecx, 0x2c(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x2c(%rdx)
               	leaq	<rip>, %rax
               	movl	$0xd1a2734, %ecx        # imm = 0xD1A2734
               	movl	%ecx, 0x30(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x30(%rdx)
               	leaq	<rip>, %rax
               	movl	$0xe1c2a38, %ecx        # imm = 0xE1C2A38
               	movl	%ecx, 0x34(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x34(%rdx)
               	leaq	<rip>, %rax
               	movl	$0xf1e2d3c, %ecx        # imm = 0xF1E2D3C
               	movl	%ecx, 0x38(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x38(%rdx)
               	leaq	<rip>, %rax
               	movl	$0x10203040, %ecx       # imm = 0x10203040
               	movl	%ecx, 0x3c(%rax)
               	leaq	<rip>, %rdx
               	movl	%ecx, 0x3c(%rdx)
               	leaq	<rip>, %rbx
               	movl	$0x20, %r12d
               	leaq	0x20(%rbx), %rsi
               	movl	$0x8, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rsi
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%rbx)
               	movq	0x8(%r12), %rax
               	movq	%rax, 0x8(%rbx)
               	movq	0x10(%r12), %rax
               	movq	%rax, 0x10(%rbx)
               	movq	0x18(%r12), %rax
               	movq	%rax, 0x18(%rbx)
               	movq	0x20(%r12), %rax
               	movq	%rax, 0x20(%rbx)
               	movq	0x28(%r12), %rax
               	movq	%rax, 0x28(%rbx)
               	movq	0x30(%r12), %rax
               	movq	%rax, 0x30(%rbx)
               	movq	0x38(%r12), %rax
               	movq	%rax, 0x38(%rbx)
               	popq	%rax
               	leaq	0x20(%rbx), %rsi
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movzbq	(%r12), %rax
               	movb	%al, (%rbx)
               	movzbq	0x1(%r12), %rax
               	movb	%al, 0x1(%rbx)
               	movzbq	0x2(%r12), %rax
               	movb	%al, 0x2(%rbx)
               	leaq	0x3(%rbx), %rax
               	leaq	0x3(%r12), %rcx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	addq	$0x3, %rax
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	0x3(%rax), %rdx
               	leaq	0x3(%rcx), %rax
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
