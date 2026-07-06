
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
               	addq	$0x10, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	subq	%rcx, %rax
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
               	addq	$0x20, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	subq	%rcx, %rax
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
               	addq	$0x40, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	subq	%rcx, %rax
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
               	addq	$0x3c, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x20(%rcx), %rcx
               	subq	%rcx, %rax
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
               	addq	$0x14, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x20(%rcx), %rcx
               	subq	%rcx, %rax
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
               	addq	$0x18, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x28(%rcx), %rcx
               	subq	%rcx, %rax
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
               	addq	$0xc, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x28(%rcx), %rcx
               	subq	%rcx, %rax
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
               	addq	$0x4, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x28(%rcx), %rcx
               	subq	%rcx, %rax
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	movswq	(%rdx,%rax,2), %rdx
               	leaq	0x3e8(%rax), %rsi
               	movslq	%esi, %rdi
               	movswq	%di, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	movswq	(%rdx,%rax,2), %rdx
               	leaq	0x3e8(%rax), %rsi
               	movslq	%esi, %rdi
               	movswq	%di, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rsi, %rdx
               	addq	$0x0, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x0, %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	incq	%rsi
               	movl	%esi, 0x4(%rdx)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x2, %rsi
               	movl	%esi, 0x8(%rdx)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x3, %rsi
               	movl	%esi, 0xc(%rdx)
               	leaq	-0x70(%rbp), %rdx
               	movq	0x20(%rdx), %rdx
               	imulq	$0x14, %rax, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x4, %rsi
               	movl	%esi, 0x10(%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movq	0x20(%rdi), %rdi
               	imulq	$0x14, %rax, %r8
               	addq	%r8, %rdi
               	movslq	(%rdi,%rdx,4), %rdi
               	imulq	$0x64, %rax, %r8
               	addq	%rdx, %r8
               	movslq	%r8d, %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movq	0x20(%rdi), %rdi
               	imulq	$0x14, %rax, %r8
               	addq	%r8, %rdi
               	movslq	(%rdi,%rdx,4), %rdi
               	imulq	$0x64, %rax, %r8
               	addq	%rdx, %r8
               	movslq	%r8d, %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %rdi
               	imulq	$0xc, %rax, %r8
               	addq	%r8, %rdi
               	movq	%rdx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	addq	$0x0, %rdi
               	addq	%r9, %r8
               	addq	$0x0, %r8
               	movslq	%r8d, %r9
               	movb	%r9b, (%rdi)
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %rdi
               	imulq	$0xc, %rax, %r8
               	addq	%r8, %rdi
               	movq	%rdx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	addq	%r9, %r8
               	incq	%r8
               	movslq	%r8d, %r9
               	movb	%r9b, 0x1(%rdi)
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %rdi
               	imulq	$0xc, %rax, %r8
               	addq	%r8, %rdi
               	movq	%rdx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	addq	%r9, %r8
               	addq	$0x2, %r8
               	movslq	%r8d, %r9
               	movb	%r9b, 0x2(%rdi)
               	leaq	-0x70(%rbp), %rdi
               	movq	0x28(%rdi), %rdi
               	imulq	$0xc, %rax, %r8
               	addq	%r8, %rdi
               	movq	%rdx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	addq	%r9, %r8
               	addq	$0x3, %r8
               	movslq	%r8d, %r9
               	movb	%r9b, 0x3(%rdi)
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	movq	0x28(%r9), %r9
               	imulq	$0xc, %rax, %rbx
               	addq	%rbx, %r9
               	movq	%rdx, %r12
               	shlq	$0x2, %r12
               	addq	%r12, %r9
               	addq	%rdi, %r9
               	movsbq	(%r9), %r9
               	addq	%r12, %rbx
               	addq	%rdi, %rbx
               	movslq	%ebx, %r12
               	movsbq	%r12b, %rbx
               	cmpq	%rbx, %r9
               	jne	<addr>
               	leaq	0x1(%rdi), %r8
               	movslq	%r8d, %rdi
               	cmpq	$0x4, %rdi
               	jl	<addr>
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	movq	0x28(%r9), %r9
               	imulq	$0xc, %rax, %rbx
               	addq	%rbx, %r9
               	movq	%rdx, %r12
               	shlq	$0x2, %r12
               	addq	%r12, %r9
               	addq	%rdi, %r9
               	movsbq	(%r9), %r9
               	addq	%r12, %rbx
               	addq	%rdi, %rbx
               	movslq	%ebx, %r12
               	movsbq	%r12b, %rbx
               	cmpq	%rbx, %r9
               	jne	<addr>
               	leaq	0x1(%rdi), %r8
               	movslq	%r8d, %rdi
               	cmpq	$0x4, %rdi
               	jl	<addr>
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %rcx, %rax
               	addq	$0x6e, %rax
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %rcx, %rax
               	addq	$0x50, %rax
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rcx,%rcx,4), %rax
               	addq	$0x3c, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rcx,%rcx,4), %rax
               	addq	$0x28, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1c(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	0x14(%rcx), %rax
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
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
