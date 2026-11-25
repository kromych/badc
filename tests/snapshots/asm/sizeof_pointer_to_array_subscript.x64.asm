
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
               	subq	$0x18, %rsp
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x8(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x10(%rdi), %rax
               	subq	%rdi, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x20(%r8), %rax
               	subq	%r8, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x40(%r9), %rax
               	subq	%r9, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x3c(%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x14(%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x18(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0xc(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x4(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x18, %rsp
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
               	addq	%rsi, %rdx
               	movl	(%rdx), %r9d
               	imulq	$0x64, %rax, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r11d
               	movl	0x4(%rdx), %r9d
               	leaq	0x1(%rdi), %r10
               	nopw	(%rax,%rax)
               	cmpl	%r10d, %r9d
               	jne	<addr>
               	movl	$0x2, %r9d
               	movl	0x8(%rdx), %edx
               	addq	$0x2, %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	movl	$0x3, %r11d
               	imulq	$0x14, %rax, %rdx
               	addq	%rsi, %rdx
               	movl	0xc(%rdx), %r9d
               	imulq	$0x64, %rax, %rdi
               	leaq	0x3(%rdi), %r10
               	nopl	(%rax)
               	cmpl	%r10d, %r9d
               	jne	<addr>
               	movl	$0x4, %r9d
               	movl	0x10(%rdx), %edx
               	addq	$0x4, %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	imulq	$0x14, %rax, %rdx
               	addq	%rsi, %rdx
               	movl	(%rdx), %r9d
               	imulq	$0x64, %rax, %rdi
               	cmpl	%edi, %r9d
               	jne	<addr>
               	movl	$0x1, %r11d
               	movl	0x4(%rdx), %r9d
               	leaq	0x1(%rdi), %r10
               	nopl	(%rax,%rax)
               	cmpl	%r10d, %r9d
               	jne	<addr>
               	movl	$0x2, %r9d
               	movl	0x8(%rdx), %edx
               	addq	$0x2, %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	movl	$0x3, %r11d
               	imulq	$0x14, %rax, %rdx
               	addq	%rsi, %rdx
               	movl	0xc(%rdx), %r9d
               	imulq	$0x64, %rax, %rdi
               	leaq	0x3(%rdi), %r10
               	nopl	(%rax)
               	cmpl	%r10d, %r9d
               	jne	<addr>
               	movl	$0x4, %r9d
               	movl	0x10(%rdx), %edx
               	addq	$0x4, %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
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
               	leaq	0x1(%rdi), %r8
               	movb	%r8b, 0x5(%rsi)
               	addq	%rcx, %rax
               	leaq	0x2(%rdi), %rsi
               	movb	%sil, 0x6(%rax)
               	imulq	$0xc, %rdx, %rsi
               	leaq	(%rcx,%rsi), %rax
               	leaq	0x4(%rsi), %rdi
               	addq	$0x3, %rdi
               	movb	%dil, 0x7(%rax)
               	leaq	0x8(%rsi), %rdi
               	movb	%dil, 0x8(%rax)
               	leaq	0x1(%rdi), %r8
               	movb	%r8b, 0x9(%rax)
               	addq	$0x2, %rdi
               	movb	%dil, 0xa(%rax)
               	addq	$0x8, %rsi
               	addq	$0x3, %rsi
               	movb	%sil, 0xb(%rax)
               	incq	%rdx
               	cmpl	$0x2, %edx
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%r10d, %r10d
               	imulq	$0xc, %r8, %rdi
               	leaq	(%rcx,%rdi), %rdx
               	movq	%r10, %rax
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	movsbq	(%rdx,%rsi), %r11
               	leaq	(%rdi,%rsi), %r9
               	nopl	(%rax,%rax)
               	cmpl	%r9d, %r11d
               	jne	<addr>
               	movl	$0x1, %r11d
               	addq	%rdx, %rsi
               	movsbq	0x1(%rsi), %rsi
               	incq	%r9
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rdx,%rsi), %r9
               	movsbq	0x2(%r9), %r9
               	leaq	(%rdi,%rsi), %r11
               	addq	$0x2, %r11
               	cmpl	%r11d, %r9d
               	jne	<addr>
               	movl	$0x3, %r11d
               	leaq	(%rdx,%rsi), %r9
               	movsbq	0x3(%r9), %r9
               	addq	%rdi, %rsi
               	addq	$0x3, %rsi
               	cmpl	%esi, %r9d
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%r10d, %r10d
               	imulq	$0xc, %r8, %rdi
               	leaq	(%rcx,%rdi), %rdx
               	movq	%r10, %rax
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	movsbq	(%rdx,%rsi), %r11
               	leaq	(%rdi,%rsi), %r9
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %r11d
               	jne	<addr>
               	movl	$0x1, %r11d
               	addq	%rdx, %rsi
               	movsbq	0x1(%rsi), %rsi
               	incq	%r9
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rdx,%rsi), %r9
               	movsbq	0x2(%r9), %r9
               	leaq	(%rdi,%rsi), %r11
               	addq	$0x2, %r11
               	cmpl	%r11d, %r9d
               	jne	<addr>
               	movl	$0x3, %r11d
               	leaq	(%rdx,%rsi), %r9
               	movsbq	0x3(%r9), %r9
               	addq	%rdi, %rsi
               	addq	$0x3, %rsi
               	cmpl	%esi, %r9d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%r8
               	nopl	(%rax,%rax)
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%r11, %r10
               	imulq	$0xc, %r8, %rcx
               	addq	$0x6e, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	%r10, %rax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %r10
               	jmp	<addr>
               	movq	%r11, %r10
               	jmp	<addr>
               	movq	%r11, %r10
               	imulq	$0xc, %r8, %rcx
               	addq	$0x50, %rcx
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	addq	%r10, %rax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %r10
               	jmp	<addr>
               	movq	%r11, %r10
               	jmp	<addr>
               	movq	%r9, %r8
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x3c, %rax
               	addq	%r8, %rax
               	addq	$0x18, %rsp
               	retq
               	movq	%r11, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r11, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x28, %rax
               	addq	%r8, %rax
               	addq	$0x18, %rsp
               	retq
               	movq	%r11, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r11, %r8
               	jmp	<addr>
