
sizeof_pointer_to_array_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x30, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x8(%rdx), %rdi
               	subq	%rdx, %rdi
               	cmpq	$0x8, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x10(%rsi), %rdx
               	subq	%rsi, %rdx
               	cmpq	$0x10, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x20(%r8), %rdx
               	subq	%r8, %rdx
               	cmpq	$0x20, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x40(%r9), %rdx
               	subq	%r9, %rdx
               	cmpq	$0x40, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x3c(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x3c, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x14(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x14, %rdx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x18(%rcx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x18, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0xc(%rcx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0xc, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	leaq	0x4(%rcx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x4, %rdx
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x3e903e8, <rip> # imm = 0x3E903E8
                                                # <addr>
               	movl	$0x3eb03ea, <rip> # imm = 0x3EB03EA
                                                # <addr>
               	movl	$0x3ed03ec, <rip> # imm = 0x3ED03EC
                                                # <addr>
               	movl	$0x3ef03ee, <rip> # imm = 0x3EF03EE
                                                # <addr>
               	movabsq	$0x100000000, %rdx      # imm = 0x100000000
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x300000002, %rdx      # imm = 0x300000002
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x6400000004, %rdx     # imm = 0x6400000004
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x6600000065, %rdx     # imm = 0x6600000065
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x6800000067, %rdx     # imm = 0x6800000067
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0xc9000000c8, %rdx     # imm = 0xC9000000C8
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0xcb000000ca, %rdx     # imm = 0xCB000000CA
               	movq	%rdx, <rip> # <addr>
               	movl	$0xcc, <rip> # <addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	imulq	$0x14, %rdx, %rsi
               	leaq	(%rax,%rsi), %r8
               	movl	(%r8), %ebx
               	imulq	$0x64, %rdx, %r9
               	cmpl	%r9d, %ebx
               	jne	<addr>
               	movl	$0x1, %ebx
               	movl	0x4(%r8), %r8d
               	incq	%r9
               	nop
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rax, %rsi
               	movl	0x8(%rsi), %r8d
               	imulq	$0x64, %rdx, %rsi
               	leaq	0x2(%rsi), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	$0x3, %r10d
               	movq	%r10, 0x28(%rsp)
               	imulq	$0x14, %rdx, %r8
               	addq	%rax, %r8
               	movl	0xc(%r8), %r9d
               	leaq	0x3(%rsi), %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movl	$0x4, %r9d
               	movl	0x10(%r8), %r8d
               	addq	$0x4, %rsi
               	nopl	(%rax)
               	cmpl	%esi, %r8d
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	imulq	$0x14, %rdx, %rsi
               	leaq	(%rax,%rsi), %r8
               	movl	(%r8), %ebx
               	imulq	$0x64, %rdx, %r9
               	cmpl	%r9d, %ebx
               	jne	<addr>
               	movl	$0x1, %ebx
               	movl	0x4(%r8), %r8d
               	incq	%r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rax, %rsi
               	movl	0x8(%rsi), %r8d
               	imulq	$0x64, %rdx, %rsi
               	leaq	0x2(%rsi), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	$0x3, %r10d
               	movq	%r10, 0x28(%rsp)
               	imulq	$0x14, %rdx, %r8
               	addq	%rax, %r8
               	movl	0xc(%r8), %r9d
               	leaq	0x3(%rsi), %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movl	$0x4, %r9d
               	movl	0x10(%r8), %r8d
               	addq	$0x4, %rsi
               	cmpl	%esi, %r8d
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	xorl	%edx, %edx
               	imulq	$0xc, %rdx, %rax
               	movb	%al, (%rcx,%rax)
               	leaq	(%rcx,%rax), %rsi
               	leaq	0x1(%rax), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	0x2(%rax), %rdi
               	movb	%dil, 0x2(%rsi)
               	leaq	0x3(%rax), %rdi
               	movb	%dil, 0x3(%rsi)
               	leaq	0x4(%rax), %rdi
               	movb	%dil, 0x4(%rsi)
               	addq	%rcx, %rax
               	leaq	0x1(%rdi), %rsi
               	movb	%sil, 0x5(%rax)
               	imulq	$0xc, %rdx, %rax
               	leaq	(%rcx,%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x2(%rdi), %r8
               	movb	%r8b, 0x6(%rsi)
               	addq	$0x3, %rdi
               	movb	%dil, 0x7(%rsi)
               	leaq	0x8(%rax), %rdi
               	movb	%dil, 0x8(%rsi)
               	addq	%rcx, %rax
               	leaq	0x1(%rdi), %rsi
               	movb	%sil, 0x9(%rax)
               	leaq	0x2(%rdi), %rsi
               	movb	%sil, 0xa(%rax)
               	imulq	$0xc, %rdx, %rax
               	leaq	(%rcx,%rax), %rsi
               	addq	$0x8, %rax
               	addq	$0x3, %rax
               	movb	%al, 0xb(%rsi)
               	incq	%rdx
               	cmpl	$0x2, %edx
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%r10d, %r10d
               	movq	%r10, 0x28(%rsp)
               	imulq	$0xc, %r8, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	movq	0x28(%rsp), %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	movsbq	(%rdx,%rdi), %r9
               	addq	%rsi, %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x18(%rsp)
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rdx,%rdi), %r9
               	movsbq	0x1(%r9), %rbx
               	leaq	(%rsi,%rdi), %r9
               	leaq	0x1(%r9), %r10
               	movq	%r10, 0x20(%rsp)
               	cmpl	0x20(%rsp), %ebx
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rdx, %rdi
               	movsbq	0x2(%rdi), %rdi
               	addq	$0x2, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rdx,%rdi), %r9
               	movsbq	0x3(%r9), %r9
               	addq	%rsi, %rdi
               	addq	$0x3, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%r10d, %r10d
               	movq	%r10, 0x28(%rsp)
               	imulq	$0xc, %r8, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	movq	0x28(%rsp), %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	movsbq	(%rdx,%rdi), %r9
               	addq	%rsi, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x18(%rsp)
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rdx,%rdi), %r9
               	movsbq	0x1(%r9), %rbx
               	leaq	(%rsi,%rdi), %r9
               	leaq	0x1(%r9), %r10
               	movq	%r10, 0x20(%rsp)
               	cmpl	0x20(%rsp), %ebx
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rdx, %rdi
               	movsbq	0x2(%rdi), %rdi
               	addq	$0x2, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rdx,%rdi), %r9
               	movsbq	0x3(%r9), %r9
               	addq	%rsi, %rdi
               	addq	$0x3, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%rbx, 0x28(%rsp)
               	imulq	$0xc, %r8, %rcx
               	addq	$0x6e, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	0x28(%rsp), %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%rbx, 0x28(%rsp)
               	jmp	<addr>
               	movq	0x18(%rsp), %r11
               	movq	%r11, 0x28(%rsp)
               	jmp	<addr>
               	movq	%rbx, 0x28(%rsp)
               	imulq	$0xc, %r8, %rcx
               	addq	$0x50, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	0x28(%rsp), %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	%rbx, 0x28(%rsp)
               	jmp	<addr>
               	movq	0x18(%rsp), %r11
               	movq	%r11, 0x28(%rsp)
               	jmp	<addr>
               	movq	%r9, %rdi
               	leaq	(%rdx,%rdx,4), %rax
               	addq	$0x3c, %rax
               	addq	%rdi, %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	jmp	<addr>
               	movq	%rbx, %rdi
               	jmp	<addr>
               	movq	%rbx, %rdi
               	jmp	<addr>
               	movq	%r9, %rdi
               	leaq	(%rdx,%rdx,4), %rax
               	addq	$0x28, %rax
               	addq	%rdi, %rax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	jmp	<addr>
               	movq	%rbx, %rdi
               	jmp	<addr>
               	movq	%rbx, %rdi
               	jmp	<addr>
