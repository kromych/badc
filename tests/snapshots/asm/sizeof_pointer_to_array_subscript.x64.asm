
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	leaq	0x8(%rsi), %r9
               	movq	%rsi, %r10
               	movq	%r9, %rsi
               	subq	%r10, %rsi
               	cmpq	$0x8, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0x10(%rcx), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x10, %rsi
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0x20(%rdi), %rsi
               	subq	%rdi, %rsi
               	cmpq	$0x20, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0x40(%r8), %rsi
               	subq	%r8, %rsi
               	cmpq	$0x40, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0x3c(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x3c, %rsi
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0x14(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x14, %rsi
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0x18(%rdx), %rsi
               	subq	%rdx, %rsi
               	cmpq	$0x18, %rsi
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0xc(%rdx), %rsi
               	subq	%rdx, %rsi
               	cmpq	$0xc, %rsi
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	0x4(%rdx), %rsi
               	subq	%rdx, %rsi
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	(%rcx), %rsi
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	movw	%di, (%rsi)
               	movl	$0x3e9, %esi            # imm = 0x3E9
               	movw	%si, 0x2(%rcx)
               	movl	$0x3ea, %esi            # imm = 0x3EA
               	movw	%si, 0x4(%rcx)
               	movl	$0x3eb, %esi            # imm = 0x3EB
               	movw	%si, 0x6(%rcx)
               	movl	$0x3ec, %esi            # imm = 0x3EC
               	movw	%si, 0x8(%rcx)
               	movl	$0x3ed, %esi            # imm = 0x3ED
               	movw	%si, 0xa(%rcx)
               	movl	$0x3ee, %esi            # imm = 0x3EE
               	movw	%si, 0xc(%rcx)
               	movl	$0x3ef, %esi            # imm = 0x3EF
               	movw	%si, 0xe(%rcx)
               	leaq	(%rax), %rcx
               	leaq	(%rcx), %rsi
               	xorq	%rdi, %rdi
               	movl	%edi, (%rsi)
               	movl	$0x1, %esi
               	movl	%esi, 0x4(%rcx)
               	movl	$0x2, %esi
               	movl	%esi, 0x8(%rcx)
               	movl	$0x3, %esi
               	movl	%esi, 0xc(%rcx)
               	movl	$0x4, %esi
               	movl	%esi, 0x10(%rcx)
               	leaq	0x14(%rax), %rcx
               	leaq	(%rcx), %rsi
               	movl	$0x64, %edi
               	movl	%edi, (%rsi)
               	movl	$0x65, %esi
               	movl	%esi, 0x4(%rcx)
               	movl	$0x66, %esi
               	movl	%esi, 0x8(%rcx)
               	movl	$0x67, %esi
               	movl	%esi, 0xc(%rcx)
               	movl	$0x68, %esi
               	movl	%esi, 0x10(%rcx)
               	leaq	0x28(%rax), %rcx
               	leaq	(%rcx), %rsi
               	movl	$0xc8, %edi
               	movl	%edi, (%rsi)
               	movl	$0xc9, %esi
               	movl	%esi, 0x4(%rcx)
               	movl	$0xca, %esi
               	movl	%esi, 0x8(%rcx)
               	movl	$0xcb, %esi
               	movl	%esi, 0xc(%rcx)
               	movl	$0xcc, %esi
               	movl	%esi, 0x10(%rcx)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rbx
               	leaq	(%rax,%rbx), %r8
               	leaq	(%r8), %rdi
               	movslq	(%rdi), %r13
               	imulq	$0x64, %rsi, %rdi
               	leaq	(%rdi), %r9
               	cmpl	%r9d, %r13d
               	jne	<addr>
               	movl	$0x1, %r9d
               	movslq	0x4(%r8), %r8
               	incq	%rdi
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x2, %r14d
               	imulq	$0x14, %rsi, %rbx
               	leaq	(%rax,%rbx), %r8
               	movslq	0x8(%r8), %r13
               	imulq	$0x64, %rsi, %rdi
               	leaq	0x2(%rdi), %r9
               	cmpl	%r9d, %r13d
               	jne	<addr>
               	movl	$0x3, %r9d
               	movslq	0xc(%r8), %r8
               	addq	$0x3, %rdi
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x4, %r8d
               	imulq	$0x14, %rsi, %rdi
               	addq	%rax, %rdi
               	movslq	0x10(%rdi), %rdi
               	imulq	$0x64, %rsi, %rsi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rbx
               	leaq	(%rax,%rbx), %r8
               	leaq	(%r8), %rdi
               	movslq	(%rdi), %r13
               	imulq	$0x64, %rsi, %rdi
               	leaq	(%rdi), %r9
               	cmpl	%r9d, %r13d
               	jne	<addr>
               	movl	$0x1, %r9d
               	movslq	0x4(%r8), %r8
               	incq	%rdi
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x2, %r14d
               	imulq	$0x14, %rsi, %rbx
               	leaq	(%rax,%rbx), %r8
               	movslq	0x8(%r8), %r13
               	imulq	$0x64, %rsi, %rdi
               	leaq	0x2(%rdi), %r9
               	cmpl	%r9d, %r13d
               	jne	<addr>
               	movl	$0x3, %r9d
               	movslq	0xc(%r8), %r8
               	addq	$0x3, %rdi
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x4, %r8d
               	imulq	$0x14, %rsi, %rdi
               	addq	%rax, %rdi
               	movslq	0x10(%rdi), %rdi
               	imulq	$0x64, %rsi, %rsi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %rbx
               	leaq	(%rbx), %r8
               	leaq	(%r8), %r13
               	leaq	(%rcx), %rdi
               	leaq	(%rdi), %r9
               	movq	%r9, %r12
               	movb	%r12b, (%r13)
               	incq	%rdi
               	movq	%rdi, %r9
               	movb	%r9b, 0x1(%r8)
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x0, %rdi
               	addq	$0x0, %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, %r8
               	movb	%r8b, 0x2(%rdi)
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%r8), %r9
               	leaq	(%rcx), %rdi
               	addq	$0x3, %rdi
               	movq	%rdi, %rbx
               	movb	%bl, 0x3(%r9)
               	leaq	0x4(%r8), %r9
               	leaq	(%r9), %r13
               	leaq	0x4(%rcx), %rdi
               	leaq	(%rdi), %rbx
               	movq	%rbx, %r12
               	movb	%r12b, (%r13)
               	incq	%rdi
               	movq	%rdi, %r8
               	movb	%r8b, 0x1(%r9)
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x4, %rdi
               	addq	$0x4, %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, %r8
               	movb	%r8b, 0x2(%rdi)
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	0x4(%r8), %r9
               	leaq	0x4(%rcx), %rdi
               	addq	$0x3, %rdi
               	movq	%rdi, %rbx
               	movb	%bl, 0x3(%r9)
               	leaq	0x8(%r8), %r9
               	leaq	(%r9), %r13
               	leaq	0x8(%rcx), %rdi
               	leaq	(%rdi), %rbx
               	movq	%rbx, %r12
               	movb	%r12b, (%r13)
               	incq	%rdi
               	movq	%rdi, %r8
               	movb	%r8b, 0x1(%r9)
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x8, %rdi
               	addq	$0x8, %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, %r8
               	movb	%r8b, 0x2(%rdi)
               	imulq	$0xc, %rsi, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	addq	$0x8, %rsi
               	addq	$0x8, %rcx
               	addq	$0x3, %rcx
               	movq	%rcx, %rdi
               	movb	%dil, 0x3(%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%r13, %r13
               	movslq	%edi, %r8
               	imulq	$0xc, %r8, %rax
               	leaq	(%rdx,%rax), %rbx
               	movslq	%ecx, %r9
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rbx
               	addq	$0x0, %rbx
               	movsbq	(%rbx), %rbx
               	addq	%rax, %rsi
               	addq	$0x0, %rsi
               	movq	%rsi, %r12
               	movsbq	%r12b, %rsi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	$0x1, %r13d
               	leaq	(%rdx,%rax), %rbx
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rbx
               	movsbq	0x1(%rbx), %rbx
               	addq	%rax, %rsi
               	incq	%rsi
               	movq	%rsi, %r12
               	movsbq	%r12b, %rsi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	$0x2, %r13d
               	leaq	(%rdx,%rax), %rbx
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rbx
               	movsbq	0x2(%rbx), %rbx
               	addq	%rsi, %rax
               	addq	$0x2, %rax
               	movq	%rax, %r12
               	movsbq	%r12b, %rax
               	cmpl	%eax, %ebx
               	jne	<addr>
               	movl	$0x3, %r13d
               	imulq	$0xc, %r8, %rax
               	leaq	(%rdx,%rax), %r8
               	addq	%rsi, %r8
               	movsbq	0x3(%r8), %r8
               	addq	%rsi, %rax
               	addq	$0x3, %rax
               	movq	%rax, %rsi
               	movsbq	%sil, %rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x2, %edi
               	jl	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%r13, %r13
               	movslq	%edi, %r8
               	imulq	$0xc, %r8, %rax
               	leaq	(%rdx,%rax), %rbx
               	movslq	%ecx, %r9
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rbx
               	addq	$0x0, %rbx
               	movsbq	(%rbx), %rbx
               	addq	%rax, %rsi
               	addq	$0x0, %rsi
               	movq	%rsi, %r12
               	movsbq	%r12b, %rsi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	$0x1, %r13d
               	leaq	(%rdx,%rax), %rbx
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rbx
               	movsbq	0x1(%rbx), %rbx
               	addq	%rax, %rsi
               	incq	%rsi
               	movq	%rsi, %r12
               	movsbq	%r12b, %rsi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	$0x2, %r13d
               	leaq	(%rdx,%rax), %rbx
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rbx
               	movsbq	0x2(%rbx), %rbx
               	addq	%rsi, %rax
               	addq	$0x2, %rax
               	movq	%rax, %r12
               	movsbq	%r12b, %rax
               	cmpl	%eax, %ebx
               	jne	<addr>
               	movl	$0x3, %r13d
               	imulq	$0xc, %r8, %rax
               	leaq	(%rdx,%rax), %r8
               	addq	%rsi, %r8
               	movsbq	0x3(%r8), %r8
               	addq	%rsi, %rax
               	addq	$0x3, %rax
               	movq	%rax, %rsi
               	movsbq	%sil, %rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x2, %edi
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	imulq	$0xc, %rdi, %rax
               	addq	$0x6e, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%r13, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	imulq	$0xc, %rdi, %rax
               	addq	$0x50, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%r13, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%r8, %r12
               	leaq	(%rcx,%rcx,4), %rax
               	addq	$0x3c, %rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%r9, %r12
               	jmp	<addr>
               	movq	%r14, %r12
               	jmp	<addr>
               	movq	%r9, %r12
               	jmp	<addr>
               	movq	%r8, %r12
               	leaq	(%rcx,%rcx,4), %rax
               	addq	$0x28, %rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%r9, %r12
               	jmp	<addr>
               	movq	%r14, %r12
               	jmp	<addr>
               	movq	%r9, %r12
               	jmp	<addr>
