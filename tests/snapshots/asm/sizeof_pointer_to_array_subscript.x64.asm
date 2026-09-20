
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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
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
               	leaq	0x10(%rdx), %rsi
               	subq	%rdx, %rsi
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
               	leaq	0x18(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x18, %rsi
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0xc(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0xc, %rsi
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x4(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movw	$0x3e8, (%rdx)          # imm = 0x3E8
               	movw	$0x3e9, 0x2(%rdx)       # imm = 0x3E9
               	movw	$0x3ea, 0x4(%rdx)       # imm = 0x3EA
               	movw	$0x3eb, 0x6(%rdx)       # imm = 0x3EB
               	movw	$0x3ec, 0x8(%rdx)       # imm = 0x3EC
               	movw	$0x3ed, 0xa(%rdx)       # imm = 0x3ED
               	movw	$0x3ee, 0xc(%rdx)       # imm = 0x3EE
               	movw	$0x3ef, 0xe(%rdx)       # imm = 0x3EF
               	movl	$0x0, (%rcx)
               	movl	$0x1, 0x4(%rcx)
               	movl	$0x2, 0x8(%rcx)
               	movl	$0x3, 0xc(%rcx)
               	movl	$0x4, 0x10(%rcx)
               	leaq	0x14(%rcx), %rdx
               	movl	$0x64, (%rdx)
               	movl	$0x65, 0x4(%rdx)
               	movl	$0x66, 0x8(%rdx)
               	movl	$0x67, 0xc(%rdx)
               	movl	$0x68, 0x10(%rdx)
               	leaq	0x28(%rcx), %rdx
               	movl	$0xc8, (%rdx)
               	movl	$0xc9, 0x4(%rdx)
               	movl	$0xca, 0x8(%rdx)
               	movl	$0xcb, 0xc(%rdx)
               	movl	$0xcc, 0x10(%rdx)
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	imulq	$0x14, %rdx, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movslq	(%rdi), %rbx
               	imulq	$0x64, %rdx, %r8
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	movl	$0x1, %ebx
               	movslq	0x4(%rdi), %rdi
               	incq	%r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rcx, %rsi
               	movslq	0x8(%rsi), %rdi
               	imulq	$0x64, %rdx, %rsi
               	leaq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x3, %r12d
               	imulq	$0x14, %rdx, %rdi
               	addq	%rcx, %rdi
               	movslq	0xc(%rdi), %r8
               	leaq	0x3(%rsi), %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movl	$0x4, %r8d
               	movslq	0x10(%rdi), %rdi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	imulq	$0x14, %rdx, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movslq	(%rdi), %rbx
               	imulq	$0x64, %rdx, %r8
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	movl	$0x1, %ebx
               	movslq	0x4(%rdi), %rdi
               	incq	%r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rcx, %rsi
               	movslq	0x8(%rsi), %rdi
               	imulq	$0x64, %rdx, %rsi
               	leaq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x3, %r12d
               	imulq	$0x14, %rdx, %rdi
               	addq	%rcx, %rdi
               	movslq	0xc(%rdi), %r8
               	leaq	0x3(%rsi), %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movl	$0x4, %r8d
               	movslq	0x10(%rdi), %rdi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	imulq	$0xc, %rcx, %rdx
               	leaq	(%rax,%rdx), %rsi
               	movb	%dl, (%rsi)
               	leaq	0x1(%rdx), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	0x2(%rdx), %rdi
               	movb	%dil, 0x2(%rsi)
               	leaq	0x3(%rdx), %rdi
               	movb	%dil, 0x3(%rsi)
               	leaq	(%rax,%rdx), %rsi
               	addq	$0x4, %rsi
               	addq	$0x4, %rdx
               	movb	%dl, (%rsi)
               	imulq	$0xc, %rcx, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	0x4(%rsi), %rdi
               	leaq	0x4(%rdx), %r8
               	leaq	0x1(%r8), %r9
               	movb	%r9b, 0x1(%rdi)
               	addq	$0x2, %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	$0x4, %rsi
               	leaq	0x4(%rdx), %rdi
               	addq	$0x3, %rdi
               	movb	%dil, 0x3(%rsi)
               	leaq	(%rax,%rdx), %rsi
               	addq	$0x8, %rsi
               	addq	$0x8, %rdx
               	movb	%dl, (%rsi)
               	imulq	$0xc, %rcx, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	0x8(%rsi), %rdi
               	leaq	0x8(%rdx), %r8
               	leaq	0x1(%r8), %r9
               	movb	%r9b, 0x1(%rdi)
               	addq	$0x2, %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	$0x8, %rsi
               	addq	$0x8, %rdx
               	addq	$0x3, %rdx
               	movb	%dl, 0x3(%rsi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	xorl	%edi, %edi
               	xorl	%r9d, %r9d
               	movq	%r9, %rcx
               	imulq	$0xc, %rdi, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%r8,%rsi), %rbx
               	movsbq	(%rbx), %rbx
               	addq	%rdx, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	$0x1, %r13d
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	movsbq	0x1(%r8), %rbx
               	leaq	(%rdx,%rsi), %r8
               	leaq	0x1(%r8), %r12
               	movsbq	%r12b, %r12
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rax, %rdx
               	addq	%rsi, %rdx
               	movsbq	0x2(%rdx), %rdx
               	leaq	0x2(%r8), %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	$0x3, %ebx
               	imulq	$0xc, %rdi, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	movsbq	0x3(%r8), %r8
               	addq	%rsi, %rdx
               	addq	$0x3, %rdx
               	movsbq	%dl, %rdx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x2, %edi
               	jl	<addr>
               	xorl	%edi, %edi
               	xorl	%r9d, %r9d
               	movq	%r9, %rcx
               	imulq	$0xc, %rdi, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%r8,%rsi), %rbx
               	movsbq	(%rbx), %rbx
               	addq	%rdx, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	$0x1, %r13d
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	movsbq	0x1(%r8), %rbx
               	leaq	(%rdx,%rsi), %r8
               	leaq	0x1(%r8), %r12
               	movsbq	%r12b, %r12
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rax, %rdx
               	addq	%rsi, %rdx
               	movsbq	0x2(%rdx), %rdx
               	leaq	0x2(%r8), %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	$0x3, %ebx
               	imulq	$0xc, %rdi, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	movsbq	0x3(%r8), %r8
               	addq	%rsi, %rdx
               	addq	$0x3, %rdx
               	movsbq	%dl, %rdx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x2, %edi
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %r9
               	imulq	$0xc, %rdi, %rax
               	addq	$0x6e, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %r9
               	jmp	<addr>
               	movq	%r13, %r9
               	jmp	<addr>
               	movq	%rbx, %r9
               	imulq	$0xc, %rdi, %rax
               	addq	$0x50, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %r9
               	jmp	<addr>
               	movq	%r13, %r9
               	jmp	<addr>
               	movq	%r8, %r9
               	leaq	(%rdx,%rdx,4), %rax
               	addq	$0x3c, %rax
               	addq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r12, %r9
               	jmp	<addr>
               	movq	%rbx, %r9
               	jmp	<addr>
               	movq	%rbx, %r9
               	jmp	<addr>
               	movq	%r8, %r9
               	leaq	(%rdx,%rdx,4), %rax
               	addq	$0x28, %rax
               	addq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r12, %r9
               	jmp	<addr>
               	movq	%rbx, %r9
               	jmp	<addr>
               	movq	%rbx, %r9
               	jmp	<addr>
