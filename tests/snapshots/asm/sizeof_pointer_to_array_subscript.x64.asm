
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
               	subq	$0x18, %rsp
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
               	leave
               	retq
               	leaq	0x10(%rdx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x20(%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x40(%rdi), %rax
               	subq	%rdi, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x3c(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x14(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x18(%r12), %rax
               	subq	%r12, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0xc(%r12), %rax
               	subq	%r12, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x4(%r12), %rax
               	subq	%r12, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
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
               	movabsq	$0x6400000004, %rax     # imm = 0x6400000004
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x6600000065, %rax     # imm = 0x6600000065
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x6800000067, %rax     # imm = 0x6800000067
               	movq	%rax, <rip> # <addr>
               	movabsq	$0xc9000000c8, %rax     # imm = 0xC9000000C8
               	movq	%rax, <rip> # <addr>
               	movabsq	$0xcb000000ca, %rax     # imm = 0xCB000000CA
               	movq	%rax, <rip> # <addr>
               	movl	$0xcc, <rip> # <addr>
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
               	xorl	%ecx, %ecx
               	imulq	$0xc, %rcx, %rax
               	movb	%al, (%r12,%rax)
               	leaq	(%r12,%rax), %rdx
               	leaq	0x1(%rax), %rsi
               	movb	%sil, 0x1(%rdx)
               	leaq	0x2(%rax), %rsi
               	movb	%sil, 0x2(%rdx)
               	leaq	0x3(%rax), %rsi
               	movb	%sil, 0x3(%rdx)
               	leaq	0x4(%rax), %rsi
               	movb	%sil, 0x4(%rdx)
               	addq	%r12, %rax
               	leaq	0x1(%rsi), %rdx
               	movb	%dl, 0x5(%rax)
               	imulq	$0xc, %rcx, %rax
               	leaq	(%r12,%rax), %rdx
               	leaq	0x4(%rax), %rsi
               	leaq	0x2(%rsi), %rdi
               	movb	%dil, 0x6(%rdx)
               	addq	$0x3, %rsi
               	movb	%sil, 0x7(%rdx)
               	leaq	0x8(%rax), %rsi
               	movb	%sil, 0x8(%rdx)
               	addq	%r12, %rax
               	leaq	0x1(%rsi), %rdx
               	movb	%dl, 0x9(%rax)
               	leaq	0x2(%rsi), %rdx
               	movb	%dl, 0xa(%rax)
               	imulq	$0xc, %rcx, %rax
               	leaq	(%r12,%rax), %rdx
               	addq	$0x8, %rax
               	addq	$0x3, %rax
               	movb	%al, 0xb(%rdx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	xorl	%r13d, %r13d
               	xorl	%r8d, %r8d
               	imulq	$0xc, %r13, %rdx
               	leaq	(%r12,%rdx), %rcx
               	movq	%r8, %rax
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	movsbq	(%rcx,%rsi), %rdi
               	addq	%rdx, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x28(%rsp)
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
               	movsbq	(%rcx,%rsi), %rdi
               	addq	%rdx, %rsi
               	movsbq	%sil, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x28(%rsp)
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
               	leave
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
               	leave
               	retq
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	0x28(%rsp), %r8
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
               	leave
               	retq
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	0x28(%rsp), %r8
               	jmp	<addr>
               	movq	%rdi, %r8
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x3c, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
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
               	leave
               	retq
               	movq	%rbx, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
