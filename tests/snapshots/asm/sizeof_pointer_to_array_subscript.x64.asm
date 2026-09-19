
sizeof_pointer_to_array_subscript.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	0x8(%rsi), %r9
               	subq	%rsi, %r9
               	cmpq	$0x8, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x10(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x10, %rsi
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x20(%rdi), %rsi
               	subq	%rdi, %rsi
               	cmpq	$0x20, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x40(%r8), %rsi
               	subq	%r8, %rsi
               	cmpq	$0x40, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x3c(%rcx), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x3c, %rsi
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x14(%rcx), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x14, %rsi
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x18(%rdx), %rsi
               	subq	%rdx, %rsi
               	cmpq	$0x18, %rsi
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0xc(%rdx), %rsi
               	subq	%rdx, %rsi
               	cmpq	$0xc, %rsi
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x4(%rdx), %rsi
               	subq	%rdx, %rsi
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	(%rax), %rsi
               	movw	$0x3e8, (%rsi)          # imm = 0x3E8
               	movw	$0x3e9, 0x2(%rax)       # imm = 0x3E9
               	movw	$0x3ea, 0x4(%rax)       # imm = 0x3EA
               	movw	$0x3eb, 0x6(%rax)       # imm = 0x3EB
               	movw	$0x3ec, 0x8(%rax)       # imm = 0x3EC
               	movw	$0x3ed, 0xa(%rax)       # imm = 0x3ED
               	movw	$0x3ee, 0xc(%rax)       # imm = 0x3EE
               	movw	$0x3ef, 0xe(%rax)       # imm = 0x3EF
               	leaq	(%rcx), %rax
               	leaq	(%rax), %rsi
               	movl	$0x0, (%rsi)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x2, 0x8(%rax)
               	movl	$0x3, 0xc(%rax)
               	movl	$0x4, 0x10(%rax)
               	leaq	0x14(%rcx), %rax
               	leaq	(%rax), %rsi
               	movl	$0x64, (%rsi)
               	movl	$0x65, 0x4(%rax)
               	movl	$0x66, 0x8(%rax)
               	movl	$0x67, 0xc(%rax)
               	movl	$0x68, 0x10(%rax)
               	leaq	0x28(%rcx), %rax
               	leaq	(%rax), %rsi
               	movl	$0xc8, (%rsi)
               	movl	$0xc9, 0x4(%rax)
               	movl	$0xca, 0x8(%rax)
               	movl	$0xcb, 0xc(%rax)
               	movl	$0xcc, 0x10(%rax)
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	imulq	$0x14, %rax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%r8), %rsi
               	movslq	(%rsi), %r12
               	imulq	$0x64, %rax, %rsi
               	leaq	(%rsi), %r9
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movl	$0x1, %r9d
               	movslq	0x4(%r8), %r8
               	incq	%rsi
               	cmpl	%esi, %r8d
               	jne	<addr>
               	movl	$0x2, %r9d
               	leaq	(%rcx,%rdi), %rsi
               	movslq	0x8(%rsi), %r8
               	imulq	$0x64, %rax, %rsi
               	leaq	0x2(%rsi), %rdi
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x3, %r13d
               	imulq	$0x14, %rax, %r9
               	leaq	(%rcx,%r9), %rdi
               	movslq	0xc(%rdi), %r12
               	leaq	0x3(%rsi), %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	$0x4, %r8d
               	movslq	0x10(%rdi), %rdi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	imulq	$0x14, %rax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%r8), %rsi
               	movslq	(%rsi), %r12
               	imulq	$0x64, %rax, %rsi
               	leaq	(%rsi), %r9
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movl	$0x1, %r9d
               	movslq	0x4(%r8), %r8
               	incq	%rsi
               	cmpl	%esi, %r8d
               	jne	<addr>
               	movl	$0x2, %r9d
               	leaq	(%rcx,%rdi), %rsi
               	movslq	0x8(%rsi), %r8
               	imulq	$0x64, %rax, %rsi
               	leaq	0x2(%rsi), %rdi
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x3, %r13d
               	imulq	$0x14, %rax, %r9
               	leaq	(%rcx,%r9), %rdi
               	movslq	0xc(%rdi), %r12
               	leaq	0x3(%rsi), %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	$0x4, %r8d
               	movslq	0x10(%rdi), %rdi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	imulq	$0xc, %rax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%r8), %r9
               	leaq	(%r9), %rbx
               	leaq	(%rcx), %rsi
               	leaq	(%rsi), %rdi
               	movb	%dil, (%rbx)
               	incq	%rsi
               	movb	%sil, 0x1(%r9)
               	addq	$0x0, %r8
               	leaq	(%rcx), %rsi
               	leaq	0x2(%rsi), %rdi
               	movb	%dil, 0x2(%r8)
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x0, %rdi
               	leaq	0x3(%rsi), %rcx
               	movb	%cl, 0x3(%rdi)
               	imulq	$0xc, %rax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	0x4(%r8), %r9
               	leaq	(%r9), %rbx
               	leaq	0x4(%rcx), %rsi
               	leaq	(%rsi), %rdi
               	movb	%dil, (%rbx)
               	incq	%rsi
               	movb	%sil, 0x1(%r9)
               	addq	$0x4, %r8
               	leaq	0x4(%rcx), %rsi
               	leaq	0x2(%rsi), %rdi
               	movb	%dil, 0x2(%r8)
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x4, %rdi
               	leaq	0x3(%rsi), %rcx
               	movb	%cl, 0x3(%rdi)
               	imulq	$0xc, %rax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	0x8(%r8), %r9
               	leaq	(%r9), %rbx
               	leaq	0x8(%rcx), %rsi
               	leaq	(%rsi), %rdi
               	movb	%dil, (%rbx)
               	incq	%rsi
               	movb	%sil, 0x1(%r9)
               	addq	$0x8, %r8
               	leaq	0x8(%rcx), %rsi
               	leaq	0x2(%rsi), %rdi
               	movb	%dil, 0x2(%r8)
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x8, %rdi
               	leaq	0x3(%rsi), %rcx
               	movb	%cl, 0x3(%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%esi, %esi
               	cmpl	$0x2, %esi
               	jge	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %r8
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r8,%rdi), %r9
               	addq	$0x0, %r9
               	movsbq	(%r9), %r9
               	addq	%rcx, %rdi
               	addq	$0x0, %rdi
               	movsbq	%dil, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r13d
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r8
               	movsbq	0x1(%r8), %r12
               	leaq	(%rcx,%rdi), %r8
               	leaq	0x1(%r8), %r9
               	movsbq	%r9b, %r9
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movl	$0x2, %r12d
               	leaq	(%rdx,%rcx), %r9
               	addq	%rdi, %r9
               	movsbq	0x2(%r9), %r9
               	leaq	0x2(%r8), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	movl	$0x3, %r9d
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %r8
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r8
               	movsbq	0x3(%r8), %r8
               	addq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x2, %esi
               	jl	<addr>
               	xorl	%esi, %esi
               	cmpl	$0x2, %esi
               	jge	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %r8
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r8,%rdi), %r9
               	addq	$0x0, %r9
               	movsbq	(%r9), %r9
               	addq	%rcx, %rdi
               	addq	$0x0, %rdi
               	movsbq	%dil, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r13d
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r8
               	movsbq	0x1(%r8), %r12
               	leaq	(%rcx,%rdi), %r8
               	leaq	0x1(%r8), %r9
               	movsbq	%r9b, %r9
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	movl	$0x2, %r12d
               	leaq	(%rdx,%rcx), %r9
               	addq	%rdi, %r9
               	movsbq	0x2(%r9), %r9
               	leaq	0x2(%r8), %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	movl	$0x3, %r9d
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %r8
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r8
               	movsbq	0x3(%r8), %r8
               	addq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x2, %esi
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r9, %rbx
               	imulq	$0xc, %rsi, %rcx
               	addq	$0x6e, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r12, %rbx
               	jmp	<addr>
               	movq	%r13, %rbx
               	jmp	<addr>
               	movq	%r9, %rbx
               	imulq	$0xc, %rsi, %rcx
               	addq	$0x50, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r12, %rbx
               	jmp	<addr>
               	movq	%r13, %rbx
               	jmp	<addr>
               	movq	%r8, %rbx
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x3c, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r13, %rbx
               	jmp	<addr>
               	movq	%r9, %rbx
               	jmp	<addr>
               	movq	%r9, %rbx
               	jmp	<addr>
               	movq	%r8, %rbx
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x28, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r13, %rbx
               	jmp	<addr>
               	movq	%r9, %rbx
               	jmp	<addr>
               	movq	%r9, %rbx
               	jmp	<addr>
