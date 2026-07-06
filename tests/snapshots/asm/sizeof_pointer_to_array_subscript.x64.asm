
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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	%ecx, %rdx
               	leaq	0x3e8(%rdx), %rsi
               	movslq	%esi, %rdi
               	movw	%di, (%rax,%rdx,2)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	%ecx, %rdx
               	movswq	(%rax,%rdx,2), %rax
               	addq	$0x3e8, %rdx            # imm = 0x3E8
               	movslq	%edx, %rsi
               	movswq	%si, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	%ecx, %rdx
               	movswq	(%rax,%rdx,2), %rax
               	addq	$0x3e8, %rdx            # imm = 0x3E8
               	movslq	%edx, %rsi
               	movswq	%si, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	imulq	$0x64, %rsi, %rsi
               	addq	%rdi, %rsi
               	movl	%esi, (%rax,%rdi,4)
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	movslq	(%rax,%rdi,4), %rax
               	imulq	$0x64, %rsi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	movslq	(%rax,%rdi,4), %rax
               	imulq	$0x64, %rsi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movslq	%ecx, %rdi
               	imulq	$0xc, %rdi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movslq	%esi, %r9
               	addq	%r9, %rax
               	addq	%r8, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%rax)
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movslq	%ecx, %rdi
               	imulq	$0xc, %rdi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movslq	%esi, %r9
               	addq	%r9, %rax
               	movsbq	(%rax), %rax
               	addq	%r8, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %r8
               	movsbq	%r8b, %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movslq	%ecx, %rdi
               	imulq	$0xc, %rdi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movslq	%esi, %r9
               	addq	%r9, %rax
               	movsbq	(%rax), %rax
               	addq	%r8, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %r8
               	movsbq	%r8b, %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %rcx, %rax
               	addq	$0x6e, %rax
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %rcx, %rax
               	addq	$0x50, %rax
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rcx,%rcx,4), %rax
               	addq	$0x3c, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rcx,%rcx,4), %rax
               	addq	$0x28, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1c(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	0x14(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
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
