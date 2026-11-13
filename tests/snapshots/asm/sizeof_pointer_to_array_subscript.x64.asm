
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
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r12 # <addr>
               	leaq	0x8(%rax), %r8
               	subq	%rax, %r8
               	cmpq	$0x8, %r8
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0x10(%rdx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0x20(%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0x40(%rdi), %rax
               	subq	%rdi, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0x3c(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0x14(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0x18(%r12), %rax
               	subq	%r12, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0xc(%r12), %rax
               	subq	%r12, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	0x4(%r12), %rax
               	subq	%r12, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x3e903e8, <rip> # imm = 0x3E903E8
                                                # <addr>
               	movl	$0x3eb03ea, <rip> # imm = 0x3EB03EA
                                                # <addr>
               	movl	$0x3ed03ec, <rip> # imm = 0x3ED03EC
                                                # <addr>
               	movl	$0x3ef03ee, <rip> # imm = 0x3EF03EE
                                                # <addr>
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x300000002, %rax      # imm = 0x300000002
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x6400000004, %rdx     # imm = 0x6400000004
               	leaq	0x14(%rcx), %rax
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x6600000065, %rdx     # imm = 0x6600000065
               	movq	%rdx, 0x4(%rax)
               	movabsq	$0x6800000067, %rdx     # imm = 0x6800000067
               	movq	%rdx, 0xc(%rax)
               	leaq	0x28(%rcx), %rax
               	movabsq	$0xc9000000c8, %rdx     # imm = 0xC9000000C8
               	movq	%rdx, (%rax)
               	movabsq	$0xcb000000ca, %rdx     # imm = 0xCB000000CA
               	movq	%rdx, 0x8(%rax)
               	movl	$0xcc, 0x10(%rax)
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	imulq	$0x14, %rax, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	(%rsi), %r9d
               	imulq	$0x64, %rax, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r9d
               	movl	0x4(%rsi), %esi
               	incq	%rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %r9d
               	addq	%rcx, %rdx
               	movl	0x8(%rdx), %esi
               	imulq	$0x64, %rax, %rdx
               	leaq	0x2(%rdx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x3, %ebx
               	imulq	$0x14, %rax, %rsi
               	addq	%rcx, %rsi
               	movl	0xc(%rsi), %edi
               	leaq	0x3(%rdx), %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x4, %edi
               	movl	0x10(%rsi), %esi
               	addq	$0x4, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	imulq	$0x14, %rax, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	(%rsi), %r9d
               	imulq	$0x64, %rax, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r9d
               	movl	0x4(%rsi), %esi
               	incq	%rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %r9d
               	addq	%rcx, %rdx
               	movl	0x8(%rdx), %esi
               	imulq	$0x64, %rax, %rdx
               	leaq	0x2(%rdx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x3, %ebx
               	imulq	$0x14, %rax, %rsi
               	addq	%rcx, %rsi
               	movl	0xc(%rsi), %edi
               	leaq	0x3(%rdx), %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x4, %edi
               	movl	0x10(%rsi), %esi
               	addq	$0x4, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	imulq	$0xc, %rax, %rcx
               	leaq	(%r12,%rcx), %rdx
               	movb	%cl, (%rdx)
               	leaq	0x1(%rcx), %rsi
               	movb	%sil, 0x1(%rdx)
               	leaq	0x2(%rcx), %rsi
               	movb	%sil, 0x2(%rdx)
               	leaq	0x3(%rcx), %rsi
               	movb	%sil, 0x3(%rdx)
               	leaq	(%r12,%rcx), %rdx
               	addq	$0x4, %rdx
               	addq	$0x4, %rcx
               	movb	%cl, (%rdx)
               	imulq	$0xc, %rax, %rcx
               	leaq	(%r12,%rcx), %rdx
               	leaq	0x4(%rdx), %rsi
               	leaq	0x4(%rcx), %rdi
               	leaq	0x1(%rdi), %r8
               	movb	%r8b, 0x1(%rsi)
               	addq	$0x2, %rdi
               	movb	%dil, 0x2(%rsi)
               	addq	$0x4, %rdx
               	leaq	0x4(%rcx), %rsi
               	addq	$0x3, %rsi
               	movb	%sil, 0x3(%rdx)
               	leaq	(%r12,%rcx), %rdx
               	addq	$0x8, %rdx
               	addq	$0x8, %rcx
               	movb	%cl, (%rdx)
               	imulq	$0xc, %rax, %rcx
               	leaq	(%r12,%rcx), %rdx
               	leaq	0x8(%rdx), %rsi
               	leaq	0x8(%rcx), %rdi
               	leaq	0x1(%rdi), %r8
               	movb	%r8b, 0x1(%rsi)
               	addq	$0x2, %rdi
               	movb	%dil, 0x2(%rsi)
               	addq	$0x8, %rdx
               	addq	$0x8, %rcx
               	addq	$0x3, %rcx
               	movb	%cl, 0x3(%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%r13d, %r13d
               	xorl	%r8d, %r8d
               	imulq	$0xc, %r13, %rdx
               	leaq	(%r12,%rdx), %rcx
               	movq	%r8, %rax
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	addq	%rdx, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x1, %r14d
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	0x1(%rdi), %r9
               	leaq	(%rdx,%rsi), %rdi
               	leaq	0x1(%rdi), %rbx
               	movsbq	%bl, %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movl	$0x2, %r9d
               	addq	%rcx, %rsi
               	movsbq	0x2(%rsi), %rsi
               	addq	$0x2, %rdi
               	movsbq	%dil, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x3, %r9d
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	0x3(%rdi), %rdi
               	addq	%rdx, %rsi
               	addq	$0x3, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x2, %r13d
               	jl	<addr>
               	xorl	%r13d, %r13d
               	xorl	%r8d, %r8d
               	imulq	$0xc, %r13, %rdx
               	leaq	(%r12,%rdx), %rcx
               	movq	%r8, %rax
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	addq	%rdx, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x1, %r14d
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	0x1(%rdi), %r9
               	leaq	(%rdx,%rsi), %rdi
               	leaq	0x1(%rdi), %rbx
               	movsbq	%bl, %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movl	$0x2, %r9d
               	addq	%rcx, %rsi
               	movsbq	0x2(%rsi), %rsi
               	addq	$0x2, %rdi
               	movsbq	%dil, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x3, %r9d
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	0x3(%rdi), %rdi
               	addq	%rdx, %rsi
               	addq	$0x3, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x2, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%r9, %r8
               	imulq	$0xc, %r13, %rcx
               	addq	$0x6e, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r14, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	imulq	$0xc, %r13, %rcx
               	addq	$0x50, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r14, %r8
               	jmp	<addr>
               	movq	%rdi, %r8
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x3c, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%rbx, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%rdi, %r8
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x28, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%rbx, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
