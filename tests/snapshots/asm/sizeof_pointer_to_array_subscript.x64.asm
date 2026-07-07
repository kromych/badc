
sizeof_pointer_to_array_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	0x10(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x10(%rax), %rax
               	leaq	0x20(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x18(%rax), %rax
               	leaq	0x40(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x18(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	leaq	0x3c(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	leaq	0x14(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	leaq	0x18(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	leaq	0xc(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	leaq	0x4(%rax), %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	$0x0, %rax
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movw	%cx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3e9, %ecx            # imm = 0x3E9
               	movw	%cx, 0x2(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3ea, %ecx            # imm = 0x3EA
               	movw	%cx, 0x4(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3eb, %ecx            # imm = 0x3EB
               	movw	%cx, 0x6(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3ec, %ecx            # imm = 0x3EC
               	movw	%cx, 0x8(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3ed, %ecx            # imm = 0x3ED
               	movw	%cx, 0xa(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3ee, %ecx            # imm = 0x3EE
               	movw	%cx, 0xc(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3ef, %ecx            # imm = 0x3EF
               	movw	%cx, 0xe(%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	movswq	(%rdx,%rcx,2), %rsi
               	leaq	0x3e8(%rcx), %rdx
               	movslq	%edx, %rdi
               	movswq	%di, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	movswq	(%rdx,%rcx,2), %rsi
               	leaq	0x3e8(%rcx), %rdx
               	movslq	%edx, %rdi
               	movswq	%di, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x0, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x3, %rdx
               	movl	%edx, 0xc(%rsi)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x4, %rdx
               	movl	%edx, 0x10(%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rsi, %r8
               	addq	%r8, %rdx
               	movslq	(%rdx,%rcx,4), %r8
               	imulq	$0x64, %rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rdi
               	movslq	%edi, %rsi
               	cmpq	$0x3, %rsi
               	jl	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rsi, %r8
               	addq	%r8, %rdx
               	movslq	(%rdx,%rcx,4), %r8
               	imulq	$0x64, %rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rdi
               	movslq	%edi, %rsi
               	cmpq	$0x3, %rsi
               	jl	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %r8
               	imulq	$0xc, %rsi, %rdi
               	leaq	(%r8,%rdi), %r9
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	addq	$0x0, %r9
               	addq	%r8, %rdi
               	addq	$0x0, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%r9)
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %r8
               	imulq	$0xc, %rsi, %rdi
               	leaq	(%r8,%rdi), %r9
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	addq	%r8, %rdi
               	incq	%rdi
               	movslq	%edi, %r8
               	movb	%r8b, 0x1(%r9)
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %r8
               	imulq	$0xc, %rsi, %rdi
               	leaq	(%r8,%rdi), %r9
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	addq	%r8, %rdi
               	addq	$0x2, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, 0x2(%r9)
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %r8
               	imulq	$0xc, %rsi, %rdi
               	leaq	(%r8,%rdi), %r9
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	addq	%r8, %rdi
               	addq	$0x3, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, 0x3(%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rdx
               	movslq	%edx, %rsi
               	cmpq	$0x2, %rsi
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x28(%rdx), %rsi
               	imulq	$0xc, %rbx, %rdx
               	leaq	(%rsi,%rdx), %r12
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r12
               	addq	%rcx, %r12
               	movsbq	(%r12), %r12
               	addq	%rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rsi
               	movsbq	%sil, %rdx
               	cmpq	%rdx, %r12
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%r8), %rdi
               	movslq	%edi, %r8
               	cmpq	$0x3, %r8
               	jl	<addr>
               	leaq	0x1(%rbx), %r9
               	movslq	%r9d, %rbx
               	cmpq	$0x2, %rbx
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x28(%rdx), %rsi
               	imulq	$0xc, %rbx, %rdx
               	leaq	(%rsi,%rdx), %r12
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r12
               	addq	%rcx, %r12
               	movsbq	(%r12), %r12
               	addq	%rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rsi
               	movsbq	%sil, %rdx
               	cmpq	%rdx, %r12
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%r8), %rdi
               	movslq	%edi, %r8
               	cmpq	$0x3, %r8
               	jl	<addr>
               	leaq	0x1(%rbx), %r9
               	movslq	%r9d, %rbx
               	cmpq	$0x2, %rbx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %r9, %rcx
               	addq	$0x6e, %rcx
               	movq	%rdi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %r9, %rcx
               	addq	$0x50, %rcx
               	movq	%rdi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rdi,%rdi,4), %rcx
               	addq	$0x3c, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rdi,%rdi,4), %rcx
               	addq	$0x28, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addq	$0x1c, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
