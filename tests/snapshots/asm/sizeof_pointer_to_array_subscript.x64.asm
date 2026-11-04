
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
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rcx), %r9
               	subq	%rcx, %r9
               	cmpq	$0x8, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x10(%rsi), %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x20(%rdi), %rcx
               	subq	%rdi, %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x40(%r8), %rcx
               	subq	%r8, %rcx
               	cmpq	$0x40, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x3c(%rdx), %rcx
               	subq	%rdx, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x14(%rdx), %rcx
               	subq	%rdx, %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x18(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x18, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0xc(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x4(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movw	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movw	$0x3e9, <rip> # imm = 0x3E9
                                                # <addr>
               	movw	$0x3ea, <rip> # imm = 0x3EA
                                                # <addr>
               	movw	$0x3eb, <rip> # imm = 0x3EB
                                                # <addr>
               	movw	$0x3ec, <rip> # imm = 0x3EC
                                                # <addr>
               	movw	$0x3ed, <rip> # imm = 0x3ED
                                                # <addr>
               	movw	$0x3ee, <rip> # imm = 0x3EE
                                                # <addr>
               	movw	$0x3ef, <rip> # imm = 0x3EF
                                                # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x3, <rip> # <addr>
               	movl	$0x4, <rip> # <addr>
               	leaq	0x14(%rdx), %rcx
               	movl	$0x64, (%rcx)
               	movl	$0x65, 0x4(%rcx)
               	movl	$0x66, 0x8(%rcx)
               	movl	$0x67, 0xc(%rcx)
               	movl	$0x68, 0x10(%rcx)
               	leaq	0x28(%rdx), %rcx
               	movl	$0xc8, (%rcx)
               	movl	$0xc9, 0x4(%rcx)
               	movl	$0xca, 0x8(%rcx)
               	movl	$0xcb, 0xc(%rcx)
               	movl	$0xcc, 0x10(%rcx)
               	xorl	%r9d, %r9d
               	movq	%r9, %rcx
               	imulq	$0x14, %rcx, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movl	(%rdi), %ebx
               	imulq	$0x64, %rcx, %r8
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	movl	$0x1, %ebx
               	movl	0x4(%rdi), %edi
               	incq	%r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rdx, %rsi
               	movl	0x8(%rsi), %edi
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x3, %r12d
               	imulq	$0x14, %rcx, %rdi
               	addq	%rdx, %rdi
               	movl	0xc(%rdi), %r8d
               	leaq	0x3(%rsi), %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movl	$0x4, %r8d
               	movl	0x10(%rdi), %edi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorl	%r9d, %r9d
               	movq	%r9, %rcx
               	imulq	$0x14, %rcx, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movl	(%rdi), %ebx
               	imulq	$0x64, %rcx, %r8
               	cmpl	%r8d, %ebx
               	jne	<addr>
               	movl	$0x1, %ebx
               	movl	0x4(%rdi), %edi
               	incq	%r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x2, %ebx
               	addq	%rdx, %rsi
               	movl	0x8(%rsi), %edi
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x3, %r12d
               	imulq	$0x14, %rcx, %rdi
               	addq	%rdx, %rdi
               	movl	0xc(%rdi), %r8d
               	leaq	0x3(%rsi), %rbx
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movl	$0x4, %r8d
               	movl	0x10(%rdi), %edi
               	addq	$0x4, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
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
               	leaq	(%rcx,%rcx,4), %rax
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
               	leaq	(%rcx,%rcx,4), %rax
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
